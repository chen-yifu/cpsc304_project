-- WARNING: this is a MySQL script
drop database if exists drone_delivery;
create database drone_delivery;
use drone_delivery;

CREATE TABLE Store_Staff (

staff_id integer primary key auto_increment,

staff_fullname varchar(20),

password varchar(30),

phone varchar(30),

email varchar(50),

address varchar(30),

role varchar(20) DEFAULT 'RS'

);

CREATE TABLE Store_Operating_Hour (

fullname varchar(20),

address varchar(30),

close_hour varchar(20),

open_hour varchar(20),

rating integer,

type varchar(20),

primary key(fullname, address)

);

CREATE TABLE Store_Address (

fullname varchar(30),

phone varchar(20),

address varchar(30) not null,

primary key(fullname,phone)

);

CREATE TABLE Store_Contact_Info(

store_id integer auto_increment,

phone varchar(20),

fullname varchar(20),

primary key(store_id,fullname,phone)

);

CREATE TABLE Store_Staff_Operates_Store

(

staff_id integer,

store_id integer,

since date,

fullname varchar(20),

phone varchar(20),

primary key (staff_id,store_id),

foreign key (staff_id) references Store_Staff (staff_id) on delete cascade on update cascade,

foreign key (store_id, fullname, phone) references Store_Contact_Info (store_id, fullname, phone) on delete cascade on update cascade

);

Create table Item(

fullname varchar(20),

store_id integer,

Ingredients varchar(30),

Calorie real,

Price real,

Primary key(fullname, store_id),

Foreign key(store_id) references Store_Contact_Info(store_id)

On delete cascade

on update cascade

);

create table Customer(

customer_id integer primary key auto_increment,

fullname varchar(20),

password varchar(20),

phone varchar(20),

email varchar(30),

address varchar(30),

VIP_Level int default 0,

customer_since datetime default current_timestamp

);

create table Drone(

drone_id integer auto_increment,

model varchar(30),

capacity integer,

gps_location varchar(30),

status varchar(30),

primary key (drone_id)

);

create table Drone_Agent(

drone_Agent_id integer primary key auto_increment,

fullname varchar(20),

password varchar(20),

phone varchar(20),

email varchar(30),

address varchar(30),

flight_experience varchar(30) default '1 yr'

);

create table Agent_Operates_Drone(

drone_id integer,

drone_Agent_id integer,

primary key (drone_id, drone_Agent_id ),

foreign key (drone_id) references Drone(drone_id) on delete no action on update no action,

foreign key (drone_Agent_id) references Drone_Agent(drone_Agent_id)

on delete cascade

on update cascade

);

create table Payment_Method(

id integer auto_increment,

fullname varchar(20),

comment varchar(30),

primary key (id)

);

CREATE table Orders(

order_id integer auto_increment,

status varchar(20),

comment varchar(50),

customer_id integer,

drone_id integer,

order_time TIMESTAMP TIMESTAMP,

deliver_status varchar(20),

delivery_start_time TIMESTAMP TIMESTAMP,

delivery_address varchar(30),

estimated_time TIMESTAMP TIMESTAMP,

store_id integer,

primary key (order_id),

foreign key (customer_id) references Customer(customer_id)

-- on delete no action

-- on update no action,
on delete cascade
on update cascade,

foreign key(drone_id) references drone(drone_id)

on delete no action

on update no action

);

create table Payment(

payment_id integer auto_increment,

order_id integer,

payment_method_id integer,

SN varchar(30),

amount real,

status varchar(30),

primary key (payment_id),

foreign key (order_id) references Orders(order_id)

on delete cascade on update cascade,

foreign key (payment_method_id) references Payment_Method(id)

on delete cascade

on update cascade

);

create table Drone_Activity_History(

history_id integer auto_increment,

drone_id integer,

status varchar(30),

update_at date,

create_at date,

order_id integer,

gps_location varchar(30),

primary key (history_id),

foreign key (drone_id) references Drone(drone_id) on delete cascade,

foreign key (order_id) references Orders(order_id) on delete cascade

);

create table Order_Contains_Item(

order_id integer,

item_fullname varchar(30),

quantity integer,

primary key (order_id,item_fullname),

foreign key (order_id) references Orders(order_id)

on delete cascade on update cascade,

foreign key (item_fullname) references Item(fullname)

on delete cascade

on update cascade

);

create table Staff_Fullfills_Order(

staff_id integer,

order_id integer,

fulfill_time date,

status varchar(30),

primary key (staff_id, order_id),

foreign key (staff_id) references Store_Staff(staff_id) on delete cascade on UPDATE cascade,

foreign key (order_id) references Orders(order_id) on delete cascade on UPDATE cascade

);

INSERT INTO Store_Staff VALUES(default, 'SANGHUN JO', 'RKAWK123', '778-123-1111', NULL, '1234 W 1th Ave', 'RS');

INSERT INTO Store_Staff VALUES(default, 'HAORAN CHEN', 'haoran123', '778-123-2222', 'haoran.chen18@gmail.com','1234 W 2th Ave', 'GS');

INSERT INTO Store_Staff VALUES(default, 'YiFu Chen', 'Yifu123', '778-123-3333', NULL, '1234 W 3th Ave', 'RS');

INSERT INTO Store_Staff VALUES(default, 'Greg Livingstone', 'greg123', '778-123-4444', 'greg@gmail.com','1234 W 4th Ave', 'SS');

INSERT INTO Store_Staff VALUES(default, 'Filip Ivan', 'filip123', '778-123-5555', 'filip@gmail.com', '1234 W 5th Ave', 'GS');


INSERT INTO Store_Operating_Hour VALUES('McDonalds', '123 West Mall, Vancouver', 'Closes 11 p.m.', 'Opens 8 a.m.', 3,'Restaurant');

INSERT INTO Store_Operating_Hour VALUES('Tim Hortons', '345 West Mall, Vancouver', 'Closes 11 p.m.', 'Opens 8 a.m.', 3,'Restaurant');

INSERT INTO Store_Operating_Hour VALUES('Dominos', '456 East Mall, Vancouver', 'Closes 11 p.m.', 'Opens 8 a.m.', 5,'Restaurant');

INSERT INTO Store_Operating_Hour VALUES('The Point', '567 Lower Mall, Vancouver', 'Closes 11 p.m.', 'Opens 8 a.m.', 5,'Restaurant');

INSERT INTO Store_Operating_Hour VALUES('Ikes Cafe', '678 East Mall, Vancouver', 'Closes 11 p.m.', 'Opens 8 a.m.', 3,'Restaurant');


INSERT INTO Store_Address VALUES('McDonalds', '604-111-2222', '123 West Mall, Vancouver');

INSERT INTO Store_Address VALUES('Tim Hortons', '604-111-3333', '345 West Mall, Vancouver');

INSERT INTO Store_Address VALUES('Dominos', '604-111-4444', '456 East Mall, Vancouver');

INSERT INTO Store_Address VALUES('The Point', '604-111-5555', '567 Lower Mall, Vancouver');

INSERT INTO Store_Address VALUES('Ikes Cafe', '604-111-6666', '678 East Mall, Vancouver');



INSERT INTO Store_Contact_Info VALUES(default, '604-111-2222', 'McDonalds');

INSERT INTO Store_Contact_Info VALUES(default, '604-111-3333', 'Tim Hortons');

INSERT INTO Store_Contact_Info VALUES(default, '604-111-4444', 'Dominos');

INSERT INTO Store_Contact_Info VALUES(default, '604-111-5555', 'The Point');

INSERT INTO Store_Contact_Info VALUES(default, '604-111-6666', 'Ikes Cafe');


INSERT INTO Store_Staff_Operates_Store VALUES (1, 1, '2019-01-01', 'McDonalds', '604-111-2222');

INSERT INTO Store_Staff_Operates_Store VALUES (2, 2, '2019-05-01', 'Tim Hortons', '604-111-3333');

INSERT INTO Store_Staff_Operates_Store VALUES (3, 1, '2017-01-21', 'McDonalds', '604-111-2222');

INSERT INTO Store_Staff_Operates_Store VALUES (4, 1, '2018-02-25', 'McDonalds', '604-111-2222');

INSERT INTO Store_Staff_Operates_Store VALUES (5, 1, '2019-01-01', 'McDonalds', '604-111-2222');


INSERT INTO item VALUES ('fries', 1, 'potato', 200, 3.99);

INSERT INTO item VALUES ('salad', 1, 'veggies, ranch', 30, 5.99);

INSERT INTO item VALUES ('coffee', 2, 'coffee beans', 10, 1.99);

INSERT INTO item VALUES ('doughnut', 2, 'flour, sugar', 200, 2.99);

INSERT INTO item VALUES ('pizza', 3, 'flour, cheese, veggies, meat', 500, 12.99);


INSERT INTO Customer VALUES (default, 'Bob Wang', 'Bob123456', '604-321-1234', 'bob@gmail.com','123 Broadway, Vancouver',default, default);

INSERT INTO Customer VALUES (default, 'Billy Jackson', 'Billy123456', '604-111-1234', 'billy@gmail.com','456 5th Avenue, Vancouver', default, default);

INSERT INTO Customer VALUES (default, 'Jane Doyle', 'JD321JD321', '604-222-1234', 'jd@gmail.com','567 Broadway, Vancouver', default, default);

INSERT INTO Customer VALUES (default, 'Jim Miller', 'jimmmmmmiller', '604-333-1234', 'jm@gmail.com','332 8th Avenue, Kelowna', default, default);

INSERT INTO Customer VALUES (default, 'Ivring Lee', 'lee981221', '604-444-1234', 'lee1221@gmail.com','111 West Mall, Vancouver',default,default);


INSERT INTO Drone VALUES (default, 'DJI Heavy-Duty Delivery Drone', 3, '49.2606° N, 123.2430° W', 'charging');

INSERT INTO Drone VALUES (default, 'DJI Heavy-Duty Delivery Drone', 3, '49.2606° N, 123.2460° W', 'powered off');

INSERT INTO Drone VALUES (default, 'DJI Heavy-Duty Delivery Drone', 3, '49.2626° N, 123.2470° W', 'active');

INSERT INTO Drone VALUES (default, 'Long-Distance Delivery Drone', 2, '49.2646° N, 123.4450° W', 'active');

INSERT INTO Drone VALUES (default, 'Long-Distance Delivery Drone', 2, '49.2636° N, 123.5440° W', 'active');


INSERT INTO Drone_Agent VALUES(1, 'Jivuh Aney', 'JA123456', '778-000-0005', 'jivuhaney@gmail.com', '1004 West Mall, Vancouver', '1 year');

INSERT INTO Drone_Agent values(2, 'Mary Jung' , 'mary123456', '778-000-0001', 'maryjung@gmail.com', '1000 West Mall, Vancouver','2 years');

INSERT INTO Drone_Agent VALUES(3, 'Tom Jung', 'Tom123456', '778-000-0002', 'tomjung@gmail.com', '1001 West Mall, Vancouver', '4 years');

INSERT INTO Drone_Agent VALUES(4, 'Marcus Naky', 'Naky123456', '778-000-0004', 'marcusnaky@gmail.com', '1003 West Mall, Vancouver', '1 year');

INSERT INTO Drone_Agent VALUES(5, 'Jacky Liu','JACK123456', '778-000-0003', 'jackyliu@gmail.com', '1002 West Mall, Vancouver', '1 year');


INSERT INTO Payment_Method VALUES (1, 'Cash on Delivery', 'pays cash upon delivery');

INSERT INTO Payment_Method VALUES (2, 'Credit card', 'pays by credit card on app');

INSERT INTO Payment_Method VALUES (3, 'Debit Card', 'pays by debit card on app');

INSERT INTO Payment_Method VALUES (4, 'PayPal', 'pays by paypal on app');

INSERT INTO Payment_Method VALUES (5, 'Apple Pay', 'pays by Apple Pay on app');


INSERT INTO Orders VALUES (default, 'completed', 'satisfied', 5, 1, default, 'processing', default, '555 West Mall, Vancouver', default , 12);

INSERT INTO Orders VALUES (default, 'completed', 'satisfied', 5, 1, default, 'waiting', null, '555 West Mall, Vancouver', null, 12);

INSERT INTO Orders VALUES (default, 'completed', 'satisfied', 5, 1, default, 'completed', default, '555 West Mall, Vancouver', null, 12);

INSERT INTO Orders VALUES (default, 'completed', 'satisfied', 5, 1, default, 'pending', default, '555 West Mall, Vancouver', null, 14);

INSERT INTO Orders VALUES (default, 'completed', 'satisfied', 5, 1, default, 'pending', default, '555 West Mall, Vancouver', null, 13);

INSERT INTO Orders VALUES (default, 'completed', 'satisfied', 3, 2, default, 'completed', default, '333 West Mall, Vancouver', null, 13);

INSERT INTO Orders VALUES (default, 'completed', 'satisfied', 3, 3, default, 'completed', default, '333 West Mall, Vancouver', null, 13);

INSERT INTO Orders VALUES (default, 'completed', 'satisfied', 4, 4, default, 'pending', default, '444 West Mall, Vancouver', null, 13);


INSERT INTO Payment VALUES (default, 1, 2, '1111', '12.99', 'successfully paid');

INSERT INTO Payment VALUES (default, 2, 2, '1111', '22.99', 'successfully paid');

INSERT INTO Payment VALUES (default, 3, 2, '1111', '32.99', 'successfully paid');

INSERT INTO Payment VALUES (default, 4, 2, '1111', '32.99', 'successfully paid');

INSERT INTO Payment VALUES (default, NULL, 2, '2222', '12.99', 'awaiting payment');


INSERT INTO Drone_Activity_History VALUES (default, 1, 'charging', '2020-05-10', '2019-11-01', NULL, '49.2606° N, 123.2430° W');

INSERT INTO Drone_Activity_History VALUES (default, 2, 'powered off', '2020-06-01', '2020-01-30', NULL, '49.2606° N, 123.2460° W');

INSERT INTO Drone_Activity_History VALUES (default, 3, 'active', '2020-06-01', '2020-01-30', NULL, '49.2626° N, 123.2470° W');

INSERT INTO Drone_Activity_History VALUES (default, 4, 'active', '2020-06-01', '2020-01-30', NULL, '49.2646° N, 123.4450° W');

INSERT INTO Drone_Activity_History VALUES (default, 5, 'active', '2020-06-01', '2020-01-30', NULL, '49.2636° N, 123.5440° W');


INSERT INTO Order_Contains_Item VALUES (1, 'Pizza', 1);

INSERT INTO Order_Contains_Item VALUES (2, 'Fries', 3);

INSERT INTO Order_Contains_Item VALUES (2, 'Salad', 2);

INSERT INTO Order_Contains_Item VALUES (4, 'Doughnut', 6);

INSERT INTO Order_Contains_Item VALUES (5, 'Coffee', 2);

INSERT INTO Order_Contains_Item VALUES (6, 'Doughnut', 8);

INSERT INTO Order_Contains_Item VALUES (7, 'Coffee', 5);

INSERT INTO Order_Contains_Item VALUES (8, 'Fries', 3);


INSERT INTO Staff_Fullfills_Order VALUES (1,1, '2019-01-31', 'completed');

INSERT INTO Staff_Fullfills_Order VALUES (2,2, '2019-10-21', 'completed');

INSERT INTO Staff_Fullfills_Order VALUES (3,3, '2019-11-11', 'completed');

INSERT INTO Staff_Fullfills_Order VALUES (4,4, '2020-05-31', 'completed');

INSERT INTO Staff_Fullfills_Order VALUES (5,5, '2020-06-01', 'in progress');

insert into Staff_Fullfills_Order values(1,2,'2020-06-14','completed');
insert into Staff_Fullfills_Order values(1,3,'2020-06-14','completed');
insert into Staff_Fullfills_Order values(1,4,'2020-06-14','completed');
insert into Staff_Fullfills_Order values(1,5,'2020-06-14','completed');
insert into Staff_Fullfills_Order values(1,6,'2020-06-14','completed');
insert into Staff_Fullfills_Order values(1,7,'2020-08-14','completed');
insert into Staff_Fullfills_Order values(1,8,'2020-09-14','completed');


INSERT INTO Agent_Operates_Drone VALUES (1,1);

INSERT INTO Agent_Operates_Drone VALUES (2,2);

INSERT INTO Agent_Operates_Drone VALUES (3,3);

INSERT INTO Agent_Operates_Drone VALUES (4,4);



