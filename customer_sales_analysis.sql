CREATE WAREHOUSE SALES_WH
WITH
WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE;

USE WAREHOUSE SALES_WH;

create database customer_sales;

use database customer_sales;

create schema sales_schema;
use schema sales_schema;

create file format csv_format
type = 'csv'
field_delimiter = ','
skip_header = 1;

create stage sales_stage
file_format = csv_format

show stages

select * from CUSTOMERS;
select * from ORDERS;
select * from FOODITEMS;

select c.customer_id, concat(c.first_name,' ',c.last_name) as Customer_name, sum(o.total_amount) as total_amount_spent
from CUSTOMERS c 
join ORDERS o on c.customer_id = o.customer_id
group by c.customer_id, concat(c.first_name,' ',c.last_name)
order by total_amount_spent desc;


select c.customer_id, concat(c.first_name,' ',c.last_name) as Customer_name, sum(o.total_amount) as total_amount_spent
from CUSTOMERS c 
join ORDERS o on c.customer_id = o.customer_id 
group by c.customer_id, concat(c.first_name,' ',c.last_name)
order by total_amount_spent desc 
limit 1;

select sum(total_amount) as Total_Revenue
from ORDERS;

select f.category, sum(o.total_amount) as Revenue
from FOODITEMS f 
join ORDERS o on f.food_id = o.food_id
group by category order by Revenue desc;

select status as Order_Status,sum(total_amount) as Revenue
from orders group by status
order by Revenue desc;

select rank() over(order by sum(o.total_amount)desc) as rank, concat(c.first_name,' ',c.last_name) as Customer_name, sum(o.total_amount) as total_spent 
from CUSTOMERS c 
join ORDERS o on c.CUSTOMER_ID = o.CUSTOMER_ID
group by customer_name
order by total_spent desc
limit 3;

select c.customer_id, concat(c.first_name,' ',c.last_name) as customer_name, count(o.customer_id) as Orders_placed
from CUSTOMERS c 
join ORDERS O ON c.customer_id = o.customer_id
group by c.customer_id,concat(c.first_name,' ',c.last_name) 
order by Orders_placed desc;

select o.order_id, c.customer_id, f.food_id, o.status, o.total_amount as Total_amount
from ORDERS o 
join CUSTOMERS c on o.customer_id = c.customer_id
join FOODITEMS f on o.food_id = f.food_id 
where o.status = 'Delivered'
group by o.order_id, c.customer_id, f.food_id, o.status, o.total_amount 
order by o.order_id ;



select o.order_id, concat(c.first_name,' ',c.last_name) as customer_name, o.order_date, o.status, o.total_amount as Total_spent
from ORDERS o
join CUSTOMERS c on o.customer_id = c.customer_id
where o.order_date > '2026-07-12'
group by o.order_id, concat(c.first_name,' ',c.last_name), o.order_date, o.status, o.total_amount;


create view CUSTOMER_SALES_REPORT as
select c.customer_id, concat(c.first_name,' ',c.last_name) as Customer_name, sum(o.total_amount) as total_amount_spent
from CUSTOMERS c 
join ORDERS o on c.customer_id = o.customer_id
group by c.customer_id, concat(c.first_name,' ',c.last_name)
order by total_amount_spent;

select * from CUSTOMER_SALES_REPORT;


SHOW CREATE TABLE ORDERS;