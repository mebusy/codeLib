package tools

import (
    "log"
    "net"
    "os"
)

var _ip string

func GetIP() string {
    
    if _ip != "" {
    } else {
        name, err := os.Hostname()  
        if err != nil {
            log.Println( err ) 
            return "unknown"
        }   
        // Looks up the _ip addresses
        // associated with the hostname
        addrs, err := net.LookupHost(name)
        if err != nil {
            log.Println( err )
            return "unknown"
        }
        // Prints each of the _ip addresses,
        // as there can be more than one
        for _, a := range addrs {
            _ip = a 
            break 
        }
    }
    return _ip 
}
