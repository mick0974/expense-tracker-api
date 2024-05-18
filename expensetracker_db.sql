drop database expensetrackerdb;
drop user expensetracker;
create user expensetracker with password 'password';
create database expensetrackerdb with template=template0 owner=expensetracker;
\connect expensetrackerdb;
alter default privileges grant all on tables to expensetracker;
alter default privileges grant all on sequences to expensetracker;

create table et_users(
user_id integer primary key not null,
first_name varchar(20) not null,
last_name varchar(20) not null,
email varchar(30) not null,
password text not null
);

create table et_categories(
category_id integer primary key not null,
user_id integer not null,
title varchar(20) not null,
description varchar(50) not null
);
alter table et_categories add constraint cat_users_fk
foreign key (user_id) references et_users(user_id);

create table et_transactions(
transaction_id integer primary key not null,
category_id integer not null,
user_id integer not null,
amount numeric(10,2) not null,
note varchar(50) not null,
transaction_date bigint not null
);
alter table et_transactions add constraint trans_cat_fk
foreign key (category_id) references et_categories(category_id);
alter table et_transactions add constraint trans_users_fk
foreign key (user_id) references et_users(user_id);

create sequence et_users_seq increment 1 start 1;
create sequence et_categories_seq increment 1 start 1;
create sequence et_transactions_seq increment 1 start 1000;

TRUNCATE et_categories, et_transactions;

INSERT INTO et_categories(category_id, user_id, title, description)
VALUES
(1, 1, 'tile1', 'description1'),
(2, 1, 'tile2', 'description2'),
(3, 1, 'tile3', 'description3'),
(4, 1, 'tile4', 'description4'),
(5, 1, 'tile5', 'description5');

INSERT INTO et_transactions(transaction_id, user_id, category_id, amount, note, transaction_date)
VALUES
(1, 1, 1, 100.50, 'note1', 10102024),
(2, 1, 1, 93.05, 'note2', 10102024),
(3, 1, 1, 40000.10, 'note3', 10102024),
(4, 1, 2, 30.70, 'note4', 10102024),
(5, 1, 2, 6.00, 'note5', 10102024),
(6, 1, 2, 100.00, 'note6', 10102024),
(7, 1, 3, 100.50, 'note7', 11112024),
(8, 1, 3, 93.05, 'note8', 11112024),
(9, 1, 3, 40000.10, 'note9', 11112024),
(10, 1, 3, 30.70, 'note10', 11112024),
(11, 1, 4, 6.00, 'note11', 11112024),
(12, 1, 4, 100.00, 'note12', 11112024),
(13, 1, 5, 100.50, 'note13', 09092024),
(14, 1, 5, 93.05, 'note14', 09092024),
(15, 1, 5, 40000.10, 'note15', 09092024),
(16, 1, 1, 30.70, 'note16', 09092024),
(17, 1, 1, 6.00, 'note17', 09092024),
(18, 1, 1, 100.00, 'note18', 09092024);
