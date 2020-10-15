// +build darwin netbsd freebsd openbsd dragonfly

package gows

import (
    "github.com/gorilla/websocket"
    "log"
    "reflect"
    "sync"
    "syscall"
)

type epoll struct {
    fd          int
    connections map[int]*websocket.Conn
    lock        *sync.RWMutex

    changes     []syscall.Kevent_t
    ts          syscall.Timespec
}

func MkEpoll() (*epoll, error) {
    fd, err := syscall.Kqueue()
    if err != nil {
        panic(err)
    }
    _, err = syscall.Kevent(fd, []syscall.Kevent_t{{
        Ident:  0,
        Filter: syscall.EVFILT_USER,
        Flags:  syscall.EV_ADD | syscall.EV_CLEAR,
    }}, nil, nil)
    if err != nil {
        return nil, err
    }

    return &epoll{
        fd:          fd,
        lock:        &sync.RWMutex{},
        connections: make(map[int]*websocket.Conn),
        ts:          syscall.NsecToTimespec(1e9),
    }, nil
}

func (e *epoll) Add(conn *websocket.Conn) error {
    fd := websocketFD(conn)

    e.lock.Lock()
    defer e.lock.Unlock()

    e.changes = append(e.changes,
        syscall.Kevent_t{
            Ident: uint64(fd), Flags: syscall.EV_ADD | syscall.EV_EOF, Filter: syscall.EVFILT_READ,
        },
    )

    e.connections[fd] = conn
    if len(e.connections)%100 == 0 {
        log.Printf("Total number of connections: %v", len(e.connections))
    }
    return nil
}

func (e *epoll) Remove(conn *websocket.Conn) error {
    fd := websocketFD(conn)

    e.lock.Lock()
    defer e.lock.Unlock()

    if len(e.changes) <= 1 {
        e.changes = nil
    } else {
        changes := make([]syscall.Kevent_t, 0, len(e.changes)-1)
        ident := uint64(fd)
        for _, ke := range e.changes {
            if ke.Ident != ident {
                changes = append(changes)
            }
        }
        e.changes = changes
    }


    delete(e.connections, fd)
    if len(e.connections)%100 == 0 {
        log.Printf("Total number of connections: %v", len(e.connections))
    }
    return nil
}

func (e *epoll) Wait() ([]*websocket.Conn, error) {
    //events := make([]unix.EpollEvent, 100)
    count := 100
	events := make([]syscall.Kevent_t, count, count)

	e.lock.RLock()
	changes := e.changes
	e.lock.RUnlock()

    // n, err := unix.EpollWait(e.fd, events, 100)
	n, err := syscall.Kevent(e.fd, changes, events, &e.ts)
	if err != nil {
		return nil, err
	}

    e.lock.RLock()
    defer e.lock.RUnlock()

    var connections []*websocket.Conn
    for i := 0; i < n; i++ {
        conn := e.connections[int(events[i].Ident)]
        connections = append(connections, conn)
    }
    return connections, nil
}

func websocketFD(conn *websocket.Conn) int {
    connVal := reflect.Indirect(reflect.ValueOf(conn)).FieldByName("conn").Elem()
    tcpConn := reflect.Indirect(connVal).FieldByName("conn")
    fdVal := tcpConn.FieldByName("fd")
    pfdVal := reflect.Indirect(fdVal).FieldByName("pfd")
    return int(pfdVal.FieldByName("Sysfd").Int())
}
