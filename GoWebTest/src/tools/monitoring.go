package tools

// To mimic the Java behaviour of stack-dump on SIGQUIT but still leaving the program
// On *NIX systems (including OSX) send a signal abort SIGQUIT:
// kill -l   to list all signal definition
// kill <signal> processid

import (
	"github.com/Masterminds/cookoo/safely"
	"log"
	"runtime"
    "os"
    "os/signal"
    "syscall"
)

func monitorRuntime( m *runtime.MemStats ) {
    log.Println("Number of CPUs:", runtime.NumCPU(), "used:" , runtime.GOMAXPROCS(0)  )
    r := runtime.NumGoroutine()
    log.Println("Number of goroutines", r)
    runtime.ReadMemStats(m)
    log.Println("Allocated memory", m.Alloc)
}


func DumpGoroutines() {
	safely.Go(func() {
        // log.Println( "wait to signal" )
		sigs := make(chan os.Signal, 1)
		signal.Notify(sigs, syscall.SIGQUIT)
		buf := make([]byte, 1<<20)
		for {
			<-sigs
			stacklen := runtime.Stack(buf, true)
			log.Printf("=== received SIGQUIT ===\n*** goroutine dump...\n%s\n*** end\n", buf[:stacklen])

            m := &runtime.MemStats{}
            monitorRuntime(m)
		}
	})
}
