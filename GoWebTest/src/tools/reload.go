package tools

import (
	"github.com/Masterminds/cookoo/safely"
    "log"
    "os"
    "os/signal"
    "syscall"
    "context"
    "net/http"
    "time"
)

func EnableHostUpdate( server *http.Server) {
	safely.Go(func() {
		sigs := make(chan os.Signal, 1)
		signal.Notify(sigs, syscall.SIGUSR2)
        ctx, _ := context.WithTimeout(context.Background(), 1*time.Second)
		for {
			<-sigs
            server.Shutdown(ctx)
            log.Println( "server shutdown" )
            
		}
	})
        
}
