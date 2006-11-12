#create database model_security_demo;
use portfolio;
source schema.sql;
grant all on model_security_demo.* to 'root'@'localhost';
