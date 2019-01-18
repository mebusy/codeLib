package fs

import (
    "log"
    "github.com/fsnotify/fsnotify"
)

func StartNewWatcher( path string  ) {
	watcher, err := fsnotify.NewWatcher()
	if err != nil {
		log.Fatal(err)
	}
	defer watcher.Close()

	go func() {
		for {
			select {
			case event, ok := <-watcher.Events:
				log.Println("event:", event)
				if !ok {
					// return
                    continue
				}
				if event.Op&fsnotify.Write == fsnotify.Write {
					log.Println("modified file:", event.Name)
				}
			case err, ok := <-watcher.Errors:
				log.Println("error:", err)
				if !ok {
					// return
                    return 
				}
			}
		}
	}()

    log.Println( "watch path:" , path  )
	err = watcher.Add( path )
	if err != nil {
		log.Fatal(err)
	}
}
