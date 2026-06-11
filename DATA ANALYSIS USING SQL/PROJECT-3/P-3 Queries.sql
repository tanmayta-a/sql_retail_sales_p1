--PIZZAHUT PROJECT-3--
--USING DATABASE PIZZAHUT

--CREATING TABLES

create table order_details(
order_details_id integer,
order_id integer,
pizza_id varchar(50),
quantity integer
);

--IMPORTING DATA THROUGH CSV FILES

select * from order_details;

create table orders(
order_id integer,
order_date Date,
order_time Time
);

select * from orders;

create table pizza_types(
pizza_type varchar(1000),
name varchar(50),
category varchar(50),
ingredients varchar(1000)
);

select * from pizza_types;

drop table pizza_types ;

create table pizzas(
pizza_id varchar(50),
pizza_type varchar(50),
size varchar(50),
price varchar(1000)
);

select * from pizzas;
select * from order_details;
select * from pizza_types;
select * from orders;


--BASIC SQL TASKS 

--TASK-1: Retrieve the total number of orders placed.
          SELECT count(order_id) as total_orders from orders;
    


--Task 2: Calculate the total revenue generated from pizza sales.
          
		  create table total_revenue 
		  as 
		  select 
		  round(sum(od.quantity * cast(pz.price as numeric) ),2) as total_revenue
		  from order_details as od
		  join 
		  pizzas as pz
		  on pz.pizza_id=od.pizza_id;
		  
		  select * from total_revenue ;
      
         

--Task 3: Identify the highest-priced pizza.
        select pzt.name,
               pz.price
         from pizza_types as pzt
               join 
         pizzas as pz
                 on pzt.pizza_type=pz.pizza_type
          order by pz.price desc limit 1;
          

           
--Task 4: Identify the most common pizza size ordered.
        select count(od.order_details_id) as order_count, 
               pz.size
	   from pizzas as pz
            join 
        order_details as od
             on od.pizza_id =pz.pizza_id
        group by pz.size
        order by order_count desc;


--Task 5: List the top 5 most ordered pizza types
--along with their quantities.

       select pzt.name,
              sum (od.quantity) as quantity 
       from pizza_types as pzt
            join 
       pizzas as pz
           on pz.pizza_type=pzt.pizza_type  
             join 
       order_details as od
            on od.pizza_id=pz.pizza_id
          group by pzt.name 
	      order by quantity desc limit 5;

--INTERMEDIATE SQL TASKS

--Task 6:Join the necessary tables to find the total quantity of each pizza category ordered.

       select 
       pzt.category,
             sum(od.quantity)as total_quantity
       from pizza_types as pzt
            join 
       pizzas as pz
           on pz.pizza_type=pzt.pizza_type  
             join 
       order_details as od
            on od.pizza_id=pz.pizza_id
         group by  pzt.category 
		 order by total_quantity desc ;


--Task 7: Determine the distribution of orders by hour of the day.
           select extract (hour from order_time) as hour_time,
		           count(order_id) as distributed_orders
	       from orders
           group by hour_time  order by  distributed_orders asc ;


--Task 8: Join relevant tables to find the category-wise distribution of pizzas.
          select category,count(name) as categorized_names
		  from pizza_types
		  group by category;


--Task 9: Group the orders by date and
--        calculate the average number of pizzas ordered per day.


          select round(avg(quantites),0) as avg_pizza_ordered_per_day from 
          (select o.order_date,
           sum(od.quantity) as quantites
           from orders as o 
              join 
           order_details as od
             on o.order_id=od.order_id
                 group by o.order_date) as order_quantity ;


--Task 10:Determine the top 3 most ordered pizza types based on revenue.

           select pzt.name,
           sum(od.quantity * cast(pz.price as numeric) ) as total_revenue
           from pizza_types as pzt
                 join 
           pizzas as pz
              on pzt.pizza_type=pz.pizza_type
                 join 
           order_details as od
              on od.pizza_id=pz.pizza_id
           group by pzt.name
           order by total_revenue desc limit 3;

---ADVANCED SQL TASKS
	
--Task 11:Calculate the percentage contribution of
--each pizza type to total revenue.
         select pzt.category,
        (sum(od.quantity * cast(pz.price as numeric) ) / (select * from total_revenue ))*100 as revenue
         from pizza_types as pzt
               join 
         pizzas as pz
           on pzt.pizza_type=pz.pizza_type
               join 
         order_details as od
           on od.pizza_id=pz.pizza_id
          group by pzt.category
          order by revenue desc;


--Task 12:Analyze the cumulative revenue generated over time.
         select order_date,
         sum(revenue)  over (order by order_date ) as cum_revenue 
         from
         (select o.order_date ,
          sum(od.quantity * cast(pz.price as numeric )) as revenue
          from order_details as od
               join 
          pizzas as pz
             on od.pizza_id=pz.pizza_id
               join 
         orders as o
             on o.order_id=od.order_id
         group by o.order_date) as sales;


--Task 13:Determine the top 3 most ordered pizza types based on revenue for each pizza category.


         SELECT
		 name,
		 revenue
		FROM
		 
         (SELECT category,name,revenue,
         RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn 
       FROM
		 
       (SELECT pzt.category,
       pzt.name,
       SUM(od.quantity * CAST(pz.price AS numeric)) as revenue
	           from pizza_types AS pzt
	               JOIN
	           pizzas AS pz
	                 ON pz.pizza_type=pzt.pizza_type
	               JOIN 
	          order_details AS od
	                  ON od.pizza_id=pz.pizza_id
					  
	 GROUP BY 1,2)AS a ) AS b 
	   
	WHERE rn<=3; 
 










