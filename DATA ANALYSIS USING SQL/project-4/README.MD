# ONLINE BOOK STORE Sales Analysis using SQL Project --P4

## Project Overview

**Project Title**: ONLINE BOOK STORE Sales Analysis  
**Level**: Intermediate  
**Database**: `online_book_store`

This project demonstrates the implementation of a ONLINE BOOK STORE using SQL. It includes creating and managing tables and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

## Objectives

1. **Set up the online_book_store Database**: Create and populate the database with tables for customers, orders, books.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **JOINS (performing joins)**: Using joins to execute tasks based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 1. Database Setup
- **Database Creation**: Created a database named `online_book_store`.
- **Table Creation**: Created tables for customers, orders, books. Each table includes relevant columns and relationships.

```sql
CREATE DATABASE oneline_book_store;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers
(
            customer_id integer,
            name varchar(100),
            email varchar(100),
            phone integer,
            city varchar (100),
            country varchar(100)
);


-- Create table "orders"
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
             order_id integer,
             customer_id integer,
             book_id integer,
             order_date date,
             quantity integer,
             total_amount float
);


-- Create table "books"
DROP TABLE IF EXISTS books;
CREATE TABLE books
(
            boook_id integer,
            title varchar(400),
            author varchar(400),
            genre varchar(100),
            published_year integer,
            price float,
            stock integer
);

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books, orders,customers` table.
- **Read**: Retrieved and displayed data from various tables.

--BASIC SQL TASKS

**Task 1. Retrieve all books in the "Fiction" genre:**

```sql
select * from books where genre='Fiction';
```

**Task 2: Find books published after the year 1950:**

```sql
 select  title,author,genre ,published_year from books where published_year>1950 order by published_year desc;

 --OR YOU CAN REFER THIS 2ND QUERY ALSO

  select  * from books where published_year>1950 order by published_year asc;

```

**Task 3: **List all customers from the Canada:**


```sql
select * from customers where country='Canada'

```

**Task 4: **Show orders placed in November 2023:**

```sql
select * from orders where order_date between '2023-11-01' and '2023-11-30';

```


**Task 5: Retrieve the total stock of books available:**

```sql
select sum(stock) as total_stock_available from books;

```

- **Task 6: Find the details of the most expensive book**
```sql
select * from books order by price desc limit 1;

```

**Task 7. Show all customers who ordered more than 1 quantity of a book**:

```sql
select * from orders where quantity>1;

--ANOTHER WAY BY USING JOINS 
select cust.name,
 o.quantity
from orders as o
join 
books as bk
on bk.boook_id=o.book_id
 join 
customers as cust
 on cust.customer_id=o.customer_id
  where o.quantity>1
 group by cust.name,o.quantity;
```

8. **Task 8: Retrieve all orders where the total amount exceeds $20**:

```sql
SELECT * FROM ORDERS WHERE total_amount>20;

```

9. **TASK 9: List all genres available in the Books table**:
```sql
select distinct genre from books;
```

10. **TASK-10 Find the book with the lowest stock**:

```sql
select * from books order by stock asc limit 1;

```

Task 11. **Calculate the total revenue generated from all orders**:
```sql
SELECT SUM(total_amount) As Revenue 
FROM Orders;
```
--ADVANCE SQL TASKS 

Task 12: ** Retrieve the total number of books sold for each genre:**
```sql
select bk.genre,
       sum(o.quantity) as total_number_of_books_sold
from orders as o
join 
books as bk
on bk.boook_id=o.book_id
group by bk.genre;
```

**Task 13: Find the average price of books in the "Fantasy" genre:**  

```sql
select* from books;
select avg(price),title as average_price from books where genre='Fiction' group by title;

```
**Task 14: List customers who have placed at least 2 orders**  

```sql
select 
cust.name,
o.customer_id,
count(o.order_id) as order_count
from customers as cust
join orders as o
on o.customer_id=cust.customer_id
group by o.customer_id,cust.name
having count(o.order_id)>=2;


```


**Task 15:  Find the most frequently ordered book:**

```sql
select bk.title,o.book_id,
count(o.order_id) as order_count
from orders as o
join 
books as bk
on o.book_id=bk.boook_id
group by o.book_id,bk.title
order by order_count desc limit 1;

```

**Task 16:  Show the top 3 most expensive books of 'Fantasy' Genre**

```sql
select max(price)as expensive_price,title,stock from books where genre='Fantasy' group by title,stock order by max(price) desc limit 3 ;


--OR WE CAN REFER TO THIS ALSO

SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

```


**Task 17: Retrieve the total quantity of books sold by each author**

```sql
select bk.author,sum(quantity) as total_quantity
from books as bk
join 
orders as o
on o.book_id=bk.boook_id
group by bk.author;

```

**Task 18: List the cities where customers who spent over $30 are located:**

```sql
select distinct  cust.city,
                 o.total_amount,
                 cust.name
from
orders as o
join 
customers as cust
on cust.customer_id=o.customer_id
where  o.total_amount >30;

```

**Task 19:  Find the customer who spent the most on orders:**

```sql
select 
cust.name,
cust.customer_id,
sum(o.total_amount) as total_spent

from customers as cust
join 
orders as o
on o.customer_id=cust.customer_id
group by 1,2
order by total_spent desc limit 1 ;

```

**Task 20: Calculate the stock remaining after fulfilling all orders**
```sql
SELECT bk.boook_id,
       bk.title, 
	   bk.stock,
	   COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	   bk.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books bk
left JOIN orders o
ON bk.boook_id=o.book_id
GROUP BY 1,2,3
ORDER BY bk.boook_id;


```



## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book ordered,revenue generated,most expensive books.
- **Summary Reports**: Aggregated data on high-demand books and customer performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a online_book_store system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.

Thank you for your interest in this project!

