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
    "flag"
)

/*
原理
热重启的原理非常简单，但是涉及到一些系统调用以及父子进程之间文件句柄的传递等等细节比较多。
处理过程分为以下几个步骤：

监听信号（USR2）
收到信号时fork子进程（使用相同的启动命令），将服务监听的socket文件描述符传递给子进程
子进程监听父进程的socket，这个时候父进程和子进程都可以接收请求
子进程启动成功之后，父进程停止接收新的连接，等待旧连接处理完成（或超时）
父进程退出，升级完成


细节
父进程将socket文件描述符传递给子进程可以通过命令行，或者环境变量等
子进程启动时使用和父进程一样的命令行，对于golang来说用更新的可执行程序覆盖旧程序
server.Shutdown()优雅关闭方法是go1.8的新特性
server.Serve(l)方法在Shutdown时立即返回，Shutdown方法则阻塞至context完成，所以Shutdown的方法要写在主goroutine中
//*/


var hot = flag.Bool("hot", false, "listen on fd open 3 (internal use only)")

func init() {
    flag.Parse()     
}

func LanuchForHotUpdate() bool {
    return *hot
}

func reload( listener net.Listener ) error {
    tl, ok := listener.(*net.TCPListener)
    if !ok {
        return errors.New("listener is not tcp listener")
    }
 
    f, err := tl.File()
    if err != nil {
        return err
    }
 
    args := []string{"-hot"}
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
        ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
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
