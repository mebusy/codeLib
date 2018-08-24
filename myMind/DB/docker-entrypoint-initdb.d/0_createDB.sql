use mysql;
grant all privileges on *.* to mind@'%' identified by 'mindpwd';
grant select,insert,update,delete,create,drop on *.* to mind@'%' identified by 'mindpwd';
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS mind;


