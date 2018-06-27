create database itthumb;

create user jsy IDENTIFIED by '1234';

grant select, insert, update, delete, create, drop, alter on itthumb.* to 'jsy'@'%' IDENTIFIED by '1234'

create table user(
	memberid varchar(30) PRIMARY KEY,
	password varchar(255),
	name varchar(10),
	regdate datetime,
	tel varchar(15),
	membergrade int(2),
	recognizecode int(5),
	image varchar(50),
	birth datetime,
	industy varchar(50),
	site varchar(50),
	region varchar(50),
	slogun varchar(100),
	introduce varchar(500),
	modifydate datetime,
	address varchar(50),
	locking int(2)
)

create table hireboard(
	hireno int PRIMARY KEY,
	qualification varchar(100),
	hirestatus varchar(20),
	salary int,
	workday varchar(20),
	memberid varchar(30),
	hide int(2),
	deadline datetime,
	readcnt int
)