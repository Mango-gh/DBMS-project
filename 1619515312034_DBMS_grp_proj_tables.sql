create database colony_db;



\c colony_db;




create table plot
(
plot_number
 int NOT NULL,
plot_dimension
 varchar(20),
primary key ( plot_number)
);




create table person
(
Fname
 varchar(10) NOT NULL,
Lname
 varchar(10),
aadhar_no
 varchar(20),
age
 numeric(2,0) check(age>0 and age<120),
occupation
 varchar(30),
address
 varchar(20),
primary key (aadhar_no)
);




create table owns
(
plot_num
 int NOT NULL ,
aadhar_num
 varchar(20),
since
 numeric(4,0) check (since > 1701 and since < 2100),
primary key (aadhar_num,plot_num),
foreign key (plot_num) references plot,
foreign key (aadhar_num) references person(aadhar_no)
);





create table stays_in
(
aadhar_num
 varchar(20) NOT NULL,
plot_number
 int NOT NULL,
since
 int NOT NULL,
foreign key (plot_number) references plot,
foreign key (aadhar_num) references person(aadhar_no)
);
%% alter table stays_in add sex char(1);
%% alter table stays_in add constraint aadhar_num primary key (aadhar_num);
%% alter table stays_in drop constraint aadhar_num;


create table facilities
(
Name
 varchar(30),
type
 varchar(15),
duration
 varchar(20),
primary key (Name)
);




create table uses
(
name
 varchar(30),
p_aadhar_no
 varchar(100),
start_date
 numeric(4,0),
duration
 varchar(30),
foreign key (p_aadhar_no) references person(aadhar_no),
foreign key (name) references facilities(Name),
foreign key (duration) references faclties(duration) 
);



create table eco_factors
(
plot_number
 int,
waste_segregation
 varchar(10),
green_cover 
 varchar(4),
no_of_cars
 int,
rain_water_harvesting
 varchar(50), 
solar_heating_and_ligthing
 varchar(50),
maintenance
 numeric(8,2),
 primary key (plot_number),
foreign key (plot_number) references plot(plot_number)
);




create table vehicles
(
plot_number
 int,
no_of_cars
 int,
no_of_scooters
 int,
Electric_Vehicles
 int,
Other
 varchar(200),
primary key (plot_number),
foreign key (plot_number) references plot(plot_number)
);





create table house
(
house_no
 int,
plot_number
 int,
no_of_floors
 int,
no_of_rooms
 int,
Car_Parking
 int,
 primary key(house_no),
foreign key (plot_number) references plot
);



CREATE VIEW main_view AS
SELECT a.plot_number, a.waste_segregation,a.green_cover , b.no_of_cars, b.Electric_Vehicles
FROM eco_factors as a LEFT JOIN vehicles as b
ON a.plot_number = b.plot_number;

select * from main_view;
select * from eco_factors;
select * from vehicles;

select plot_number from main_view where no_of_cars>2;
