// +build linux darwin

package tools

import (
	"log"
	"syscall"
)

// 
func MaxOpenFiles() {
	var rLimit syscall.Rlimit

	err := syscall.Getrlimit(syscall.RLIMIT_NOFILE, &rLimit)
	if err != nil {
		log.Println("Error Getting Rlimit ", err)
	}

	log.Printf("rlimt cur:%d , max: %d \n", rLimit.Cur, rLimit.Max)
	max := rLimit.Max
	if max < 200000 {
		max = 200000
	}
	if rLimit.Cur < max {
		rLimit.Cur = max
		rLimit.Max = max
		err = syscall.Setrlimit(syscall.RLIMIT_NOFILE, &rLimit)
		if err != nil {
			log.Println("Error Setting Rlimit ", err)
		} else {
			log.Println("set rlimit: ", rLimit.Max)
			log.Printf("try set rlimt cur:%d , max: %d \n", rLimit.Cur, rLimit.Max)
		}

	}
}
