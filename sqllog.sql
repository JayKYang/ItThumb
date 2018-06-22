create database itthumb;

create user jsy IDENTIFIED by '1234';

grant select, insert, update, delete, create, drop, alter on itthumb.* to 'jsy'@'%' IDENTIFIED by '1234'