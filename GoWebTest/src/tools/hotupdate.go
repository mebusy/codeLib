package tools

import (
	"github.com/Masterminds/cookoo/safely"
    "log"
    "errors"
    "os"
    "os/signal"
    "syscall"
    "context"
    "net/http"
    "time"
    "os/exec"
    "net"
)

func reload( listener net.Listener ) error {
    tl, ok := listener.(*net.TCPListener)
    if !ok {
        return errors.New("listener is not tcp listener")
    }
 
    f, err := tl.File()
    if err != nil {
        return err
    }
 
    args := []string{}
    cmd := exec.Command(os.Args[0], args...)
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr
    // put socket FD at the first entry
    cmd.ExtraFiles = []*os.File{f}
    return cmd.Start()
}


func EnableHostUpdate( server *http.Server, listener net.Listener ) {
	safely.Go(func() {
		sigs := make(chan os.Signal, 1)
		signal.Notify(sigs, syscall.SIGUSR2)
        ctx, _ := context.WithTimeout(context.Background(), 1*time.Second)
		for {
			<-sigs

            err := reload( listener  )
            if err != nil {
                log.Printf("graceful restart error: %v \n", err)
                return 
            }

            server.Shutdown(ctx)
            log.Println( "reload" )
            
		}
	})
        
}
