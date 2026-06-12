-- ZEPTO ANALYSIS SALES PROJECT-P5

--USING DATABASE ZEPTO P-5
drop table if exists zepto ;

--CREATING TABLE ZEPTO 

CREATE TABLE zepto(

sku_id serial primary key,
Category VARCHAR(400),
name VARCHAR(100),
mrp INTEGER,
discount_percent INTEGER,
available_quantity INTEGER,
discounted_selling_price INTEGER,
weight_in_Gms	INTEGER,
out_Of_Stock boolean,
quantity INTEGER
);

select * from zepto;

                                       --DATA EXPLORATION

--TASK-1: Counting of rows
select count(*) from zepto;


--TASK-2: sample data 
select * from zepto limit 10;

--TASK-3:null values

select * from zepto
where name is null
or 
category is null
or 
mrp is null
or 
discount_percent is null
or
available_quantity is null
or
discounted_selling_price is null
or
weight_in_gms is null
or
out_of_stock is null
or
quantity is null;

--TASK-4: different product categories
select distinct category from zepto order by category;

--TASK-5: How many products are in stock and out of stock?

select out_of_stock ,count(sku_id) from zepto group by out_of_stock;

--TASK-6: product names present multiple times

select name,
       count(sku_id) as "number_of_sku"
	   from zepto
group by name 
having count(sku_id)>1
order by count(sku_id) desc;


                                --DATA CLEANING

--TASK-7: products with price=0

select * from zepto where mrp=0 or discounted_selling_price=0;

delete from zepto where mrp=0;

--TASK-8: convert paise to rupee

update zepto 
set mrp=mrp/100.0,
    discounted_selling_price=discounted_selling_price/100.0;

select name,mrp,  discounted_selling_price from zepto;

                                       --BUSINESS INSIGHTS

--TASK-9:find the top 10 best value prodcuts based on the discount percentage.

select  distinct name, discount_percent,mrp 
from zepto 
order by discount_percent 
desc limit 10;

--TASK-10: What are the products with High MRP but out of stock 

select distinct name ,mrp from zepto
where out_of_stock=TRUE and mrp>300
order by mrp desc ;

--TASK-11: Calculate estimated revenue for each category

select category,
        sum(discounted_selling_price * available_quantity) as total_revenue
from zepto 
group by category
order by total_revenue;

--TASK-12: find all the products where mrp is greater than 500 and discount is less than 10%
	 select distinct name,
	        mrp,
			discount_percent
			from zepto 
where mrp>500 and discount_percent <10
order by mrp desc,
discount_percent desc;

--TASK-13: Identify the top 5 categories offering the highest average discount percentage

select category,
       round(avg(discount_percent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

--TASK-14: find the price per gram for products above 100g and sort by best value

select distinct name,
       weight_in_gms,
	   discounted_selling_price,
	   round(discounted_selling_price/weight_in_gms ,2) as price_per_gms
from zepto
where weight_in_gms >=100
order by price_per_gms;
		

alter table zepto
alter column  discounted_selling_price type  numeric(8,2);


-- TASK-15: group the products into categories like low,medium,bulk.


select distinct name,
        weight_in_gms,
	case 
	   when  weight_in_gms<1000 then 'low'
       when  weight_in_gms>5000 then 'medium'
        else 'bulk'
 end as weight_category
from zepto;

--TASK-16: what is the total inventory weight per category

select category,
sum(weight_in_gms* available_quantity) as total_weight
from zepto
group by category 
order by total_weight ;








