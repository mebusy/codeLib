// +build linux darwin

package main

import (
	"log"
	"syscall"
)

func MaxOpenFiles() {
	var rLimit syscall.Rlimit

	err := syscall.Getrlimit(syscall.RLIMIT_NOFILE, &rLimit)
	if err != nil {
		log.Println("Error Getting Rlimit ", err)
	}

    log.Printf( "rlimt cur:%d , max: %d \n" , rLimit.Cur , rLimit.Max   )
	if rLimit.Cur < rLimit.Max {
		rLimit.Cur = rLimit.Max
		err = syscall.Setrlimit(syscall.RLIMIT_NOFILE, &rLimit)
		if err != nil {
			log.Println("Error Setting Rlimit ", err)
		} else {
			log.Println("set rlimit: ", rLimit.Max)
		}

        log.Printf( "try set rlimt cur:%d , max: %d \n" , rLimit.Cur , rLimit.Max   )
	}
}
