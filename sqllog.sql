create database itthumb;

create user jsy IDENTIFIED by '1234';

grant select, insert, update, delete, create, drop, alter on itthumb.* to 'jsy'@'%' IDENTIFIED by '1234'

create table user(
	memberid varchar(30) PRIMARY KEY,
	password varchar(255),
	name varchar(10),
	regdate date,
	tel varchar(15),
	membergrade int(2),
	recognizecode int(5),
	image varchar(50),
	birth date,
	industy varchar(50),
	site varchar(50),
	slogun varchar(100),
	introduce varchar(500),
	modifydate date,
	address varchar(50),
	locking int(2),
	createpf int(2)
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
	readcnt int,
	subject varchar(100),
	image varchar(200),
	content varchar(2000)
)
