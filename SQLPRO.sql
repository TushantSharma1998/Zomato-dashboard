
CREATE DATABASE zomato;

use zomato;

show tables;


## importing tables using data Import Wizard

DESC Country;
DESC Currency;
DESC Calender;
DESC Main;

SELECT *
FROM country;
SELECT count(*)
FROM country;

SELECT *
FROM currency;
SELECT count(*)
FROM currency;


SELECT * 
FROM main; 
SELECT count(*) 
FROM main; 

SELECT * FROM Calender;

## imported tables using data Import Wizard


TRUNCATE TABLE main;


alter table main rename ï»¿RestaurantID to RestaurantID;

alter table main
drop column MyUnknownColumn;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/main_uncleaned.csv'
INTO TABLE main
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(RestaurantID,RestaurantName,CountryCode,City,Address,Locality,LocalityVerbose,Longitude,Latitude,Cuisines,Currency,Has_Table_booking,Has_Online_delivery,Is_delivering_now,Switch_to_order_menu,Price_range,Votes,Average_Cost_for_two,Rating,Datekey_Opening);



## Q-3

select Average_Cost_for_two, concat('$',
format(Average_Cost_for_two,2)) as USD
from main;

select Average_Cost_for_two, concat('$',
Average_Cost_for_two) as USD
from main;

## Q-4

select city, count(RestaurantID) as Citybasedrestaurants
from main
group by city
order by city;

select b.Countryname,count(a.RestaurantID)from main a
left join
country b
on 
a.CountryCode = b.CountryID
group by 1;

## Q-5

select year,quarter,month_no,count(RestaurantID) as "Counts" 
from calender
group by 1,2,3 
order by 1;

## Q-6

select Rating, count(RestaurantID) as "Restaurants based on Ratings"
from main
group by Rating
order by rating;

## Q-7


Select Avg_bucket,count(RestaurantID) from (
select RestaurantID,Average_Cost_for_two,
case 
when Average_Cost_for_two >= 0 and Average_Cost_for_two <= 25000 then "0-25000"
when Average_Cost_for_two >= 25001 and Average_Cost_for_two <= 50000 then "25001-50000"
when Average_Cost_for_two >= 50001 and Average_Cost_for_two <= 75000 then "50001-75000"
when Average_Cost_for_two >= 75001 and Average_Cost_for_two <= 100000 then "75001-100000"
when Average_Cost_for_two >= 100001 and Average_Cost_for_two <= 200000 then "100001-200000"
when Average_Cost_for_two >= 200001 and Average_Cost_for_two <= 300000 then "200001-300000"
when Average_Cost_for_two >= 300001 and Average_Cost_for_two <= 400000 then "300001-400000"
when Average_Cost_for_two >= 400001 and Average_Cost_for_two <= 500000 then "400001-500000"
else "Above 500000"
end as "Avg_bucket"
from main) a
group by 1;

## Q-8

select Has_Table_booking, 
((count(RestaurantID)/(select count(RestaurantID) from main)) * 100) as "percent %"
from main
group by Has_Table_booking;

## Q-9

select Has_Online_delivery, 
((count(*)/(select count(*) from main))*100) as "percent %"
from main
group by Has_Online_delivery;



-- Views

## Q-3

create view Q3 as
select Average_Cost_for_two, concat('$',
Average_Cost_for_two) as USD
from main;
select * from Q3;

## Q-4 

create view Q4 as 
select city, count(RestaurantID) as Citybasedrestaurants
from main
group by city
order by city;
select * from Q4;

## Q-4a

create view Q4a as
select b.Countryname,count(a.RestaurantID)from main a
left join
country b
on 
a.CountryCode = b.CountryID
group by 1;
select * from Q4a;

## Q-5

create view Q5 as
select year,quarter,month_no,count(RestaurantID) as "Counts" 
from calender
group by 1,2,3 
order by 1;
select * from Q5;

## Q-6

create view Q6 as
select Rating, count(RestaurantID) as "Restaurants based on Ratings"
from main
group by Rating
order by rating;
select * from Q6;

## Q-7

create view Q7 as
Select Avg_bucket,count(RestaurantID) from (
select RestaurantID,Average_Cost_for_two,
case 
when Average_Cost_for_two >= 0 and Average_Cost_for_two <= 25000 then "0-25000"
when Average_Cost_for_two >= 25001 and Average_Cost_for_two <= 50000 then "25001-50000"
when Average_Cost_for_two >= 50001 and Average_Cost_for_two <= 75000 then "50001-75000"
when Average_Cost_for_two >= 75001 and Average_Cost_for_two <= 100000 then "75001-100000"
when Average_Cost_for_two >= 100001 and Average_Cost_for_two <= 200000 then "100001-200000"
when Average_Cost_for_two >= 200001 and Average_Cost_for_two <= 300000 then "200001-300000"
when Average_Cost_for_two >= 300001 and Average_Cost_for_two <= 400000 then "300001-400000"
when Average_Cost_for_two >= 400001 and Average_Cost_for_two <= 500000 then "400001-500000"
else "Above 500000"
end as "Avg_bucket"
from main) a
group by 1;
select * from Q7;

## Q-8

create view Q8 as
select Has_Table_booking, 
((count(RestaurantID)/(select count(RestaurantID) from main)) * 100) as "percent %"
from main
group by Has_Table_booking;
select * from Q8;

## Q-9 
create view Q9 as
select Has_Online_delivery, 
((count(*)/(select count(*) from main))*100) as "percent %"
from main
group by Has_Online_delivery;
select * from Q9;

