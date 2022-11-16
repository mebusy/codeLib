

module("db_config") --package.seeall


mysql = {
	host = "192.168.1.7", -- "10.103.247.115" , --
	port = 3306 ,
	database = "test" ,
	user = "u1" ,
	password = "pu1"  ,
	max_packet_size = 1024 * 1024 ,
}


redis = {
	host = "192.168.1.6", -- "10.103.247.115" , --
	port = 6379 ,	
	
}



