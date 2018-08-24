USE mind ;

CREATE TABLE IF NOT EXISTS tbl_keynote (
    key1  VARCHAR(50) NOT NULL,
    key2  VARCHAR(50) NOT NULL,
    relation VARCHAR(512) NOT NULL,
    PRIMARY KEY (key1,key2)
) ;

