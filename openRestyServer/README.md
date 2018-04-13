# how to setup server

 1. runDB.sh
 2. runServer.sh


# DB init 

 - When a container is started for the first time, a new database with the specified name will be created and initialized with the provided configuration variables
 - Furthermore, it will execute files with extensions .sh, .sql and .sql.gz that are found in /docker-entrypoint-initdb.d
    - Files will be executed in alphabetical order.


# Where to Store Data

 - Note that users on host systems with SELinux enabled may see issues with this. 
 - The current workaround is to assign the relevant SELinux policy type to the new data directory so that the container will be allowed to access it:

```bash
chcon -Rt svirt_sandbox_file_t DB/data
```  


# change the default URL of swagger config file 

 - in  webTools/swaggerUI/index.html 

