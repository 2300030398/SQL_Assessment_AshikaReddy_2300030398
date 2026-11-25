-- 1. Create and select the database
create database if not exists calibo;
use calibo;

-- Show databases and current database
show databases;
select database();

-- Create student table
create table if not exists student (
    student_id int not null,
    name varchar(50) default null,
    primary key (student_id)
);

-- Insert student records
insert into student (student_id, name) values
(11, 'ashish'),
(12, 'akshay'),
(13, 'harshitha'),
(14, 'harshii'),
(15, 'teja'),
(16, 'ashi');

-- Basic select queries
select student_id, name from student order by name;
select * from student where student_id between 12 and 15;
show tables;
describe student;

-- 2. Customer table with unique Aadhaar number
create table if not exists cus (
    cus_id int not null,
    name varchar(50) default null,
    adharnum bigint default null,
    primary key (cus_id),
    unique key adharnum (adharnum)
);

-- Insert customer records
insert into cus (cus_id, name, adharnum) values
(201, 'teja', 810234567891),
(202, 'ashi', 820345678912),
(203, 'akshay', 830456789123),
(204, 'ashish', 840567891234),
(205, 'harshii', 850678912345),
(206, 'harshitha', 860789123456);

-- View, filter and count customers
select * from cus;
select name, adharnum from cus where name like 'ash%';
select count(*) as total_customers from cus;

-- 3. Employee table with unique Aadhaar number
create table if not exists emp (
    emp_id int not null,
    name varchar(50) default null,
    adharnum bigint default null,
    primary key (emp_id),
    unique key adharnum (adharnum)
);

-- Insert employee records
insert into emp (emp_id, name, adharnum) values
(301, 'harshitha', 910111213141),
(302, 'ashi', 920212223242),
(303, 'ashish', 930313233343),
(304, 'teja', 940414243444),
(305, 'akshay', 950515253545),
(306, 'harshii', 960616263646);

-- View and describe employee table
select * from emp order by emp_id desc;
describe emp;

-- 4. Employee salary table
create table if not exists employee_salary (
    emp_id int not null,
    empname varchar(50) default null,
    dept varchar(50) default null,
    salary bigint default null,
    primary key (emp_id)
);

-- Insert salary records
insert into employee_salary (emp_id, empname, dept, salary) values
(21, 'akshay', 'IT', 72000),
(22, 'ashish', 'IT', 68000),
(23, 'ashi', 'IT', 78000),
(24, 'teja', 'HR', 49000),
(25, 'harshii', 'HR', 56000),
(26, 'harshitha', 'HR', 53000),
(27, 'ashish', 'Finance', 82000),
(28, 'akshay', 'Finance', 77000),
(29, 'teja', 'Finance', 88000),
(30, 'ashi', 'Marketing', 91000),
(31, 'harshitha', 'Marketing', 59000),
(32, 'harshii', 'Marketing', 64000);

-- View all and filter by department
select * from employee_salary;
select empname, salary from employee_salary where dept in ('IT', 'HR') order by salary desc;

-- 5. Employees table with constraints
create table if not exists employees (
    id int not null,
    name varchar(50) not null,
    email varchar(100) default null,
    age int unsigned default null,
    salary decimal(10,2) default null,
    joined date default null,
    primary key (id),
    unique key email (email)
);

-- Insert employee details
insert into employees (id, name, email, age, salary, joined) values
(1, 'harshii', 'harshii@mail.com', 26, 47000.00, '2022-04-11'),
(2, 'ashish', 'ashish@mail.com', 33, 81000.00, '2020-02-17'),
(3, 'ashi', 'ashi@mail.com', 29, 56000.00, '2023-06-05'),
(4, 'akshay', 'akshay@mail.com', 31, 73000.00, '2021-09-23'),
(5, 'teja', 'teja@mail.com', 27, 49500.00, '2024-01-15'),
(6, 'harshitha', 'harshitha@mail.com', 34, 86000.00, '2019-12-08');

-- Filter by salary, age and joining date
select * from employees;
select name, salary from employees where salary >= 55000;
select name, age from employees where age < 30;
select name, joined from employees where joined < '2022-01-01';

-- Add a new column
alter table employees add city varchar(50);
describe employees;

-- 6. Invoices table with zero-filled codes
create table if not exists invoices (
    code int(6) unsigned zerofill default null
);

insert into invoices (code) values (7), (88), (905), (2310), (48765);
select * from invoices;

-- 7. Users table with unique email
create table if not exists users (
    id int not null,
    email varchar(100) default null,
    primary key (id),
    unique key email (email)
);

insert into users (id, email) values
(1, 'teja@mail.com'),
(2, 'ashi@mail.com'),
(3, 'akshay@mail.com'),
(4, 'ashish@mail.com'),
(5, 'harshii@mail.com'),
(6, 'harshitha@mail.com');

select * from users;

-- 8. Aggregate functions
select count(*) as total_staff from employee_salary;
select count(*) as finance_staff from employee_salary where dept = 'Finance';
select sum(salary) as payroll from employee_salary;
select round(avg(salary), 2) as mean_salary from employee_salary;
select min(salary) as least_salary from employee_salary;
select max(salary) as top_salary from employee_salary;

-- Aggregates per department
select dept, count(*) as staff_count from employee_salary group by dept;
select dept, sum(salary) as dept_payroll from employee_salary group by dept;
select dept, round(avg(salary), 2) as dept_mean from employee_salary group by dept;
select dept, max(salary) as top_pay, min(salary) as low_pay from employee_salary group by dept;

-- 9. GROUP BY with WHERE
select dept, count(*) as staff_count
from employee_salary
where salary >= 60000
group by dept;

-- GROUP BY with HAVING
select dept, round(avg(salary), 2) as dept_mean
from employee_salary
group by dept
having avg(salary) > 65000;

select dept, count(*) as staff_count
from employee_salary
group by dept
having count(*) >= 3;

-- WHERE and HAVING together
select dept, sum(salary) as dept_payroll
from employee_salary
where salary > 50000
group by dept
having sum(salary) > 150000;

-- 10. Subquery: highest salary
select * from employee_salary
where salary = (select max(salary) from employee_salary);

-- Subquery: below average salary
select * from employee_salary
where salary < (select avg(salary) from employee_salary);

-- Correlated subquery: above own department average
select es.emp_id, es.empname, es.dept, es.salary
from employee_salary es
where es.salary > (
    select avg(inner_es.salary)
    from employee_salary inner_es
    where inner_es.dept = es.dept
);

-- Subquery-style filter: departments with more than two staff
select dept from employee_salary
group by dept
having count(*) > 2;

-- 11. Inner join
select c.cus_id, c.name, e.emp_id
from cus c
inner join emp e on e.name = c.name;

-- Left join
select c.cus_id, c.name, e.emp_id
from cus c
left join emp e on e.name = c.name;

-- Right join
select c.cus_id, c.name, e.emp_id
from cus c
right join emp e on e.name = c.name;

-- Full outer join (left + right with union)
select c.cus_id, c.name, e.emp_id
from cus c
left join emp e on e.name = c.name
union
select c.cus_id, c.name, e.emp_id
from cus c
right join emp e on e.name = c.name;

-- Cross join
select s.name as student_name, c.name as customer_name
from student s
cross join cus c;

-- 12. Self join: employee and manager
create table if not exists employee_reporting (
    emp_id int primary key,
    empname varchar(50) not null,
    manager_id int,
    foreign key (manager_id) references employee_reporting(emp_id)
);

insert into employee_reporting (emp_id, empname, manager_id) values
(1, 'harshitha', null),
(2, 'akshay', 1),
(3, 'teja', 1),
(4, 'ashi', 2),
(5, 'ashish', 3),
(6, 'harshii', 3);

select worker.empname as employee, boss.empname as manager
from employee_reporting worker
left join employee_reporting boss on worker.manager_id = boss.emp_id;

-- 13. Orders database
create database if not exists orders;
use orders;

-- Categories table
create table if not exists categories (
    category_id int not null,
    category_name varchar(100) not null,
    primary key (category_id)
);

-- Products table linked to categories
create table if not exists products (
    product_id int not null,
    product_name varchar(100) not null,
    category_id int default null,
    price decimal(10,2) default null,
    primary key (product_id),
    key category_id (category_id),
    constraint products_ibfk_1 foreign key (category_id) references categories (category_id)
);

-- Order details table linked to products
create table if not exists order_details (
    order_detail_id int not null,
    order_id int default null,
    product_id int default null,
    quantity int default null,
    price decimal(10,2) default null,
    primary key (order_detail_id),
    key product_id (product_id),
    constraint order_details_ibfk_1 foreign key (product_id) references products (product_id)
);

-- Insert categories
insert into categories (category_id, category_name) values
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home Appliances');

-- Insert products
insert into products (product_id, product_name, category_id, price) values
(101, 'Laptop', 1, 58000.00),
(102, 'Smartphone', 1, 28000.00),
(103, 'Headphones', 1, 4500.00),
(104, 'T-Shirt', 2, 999.00),
(105, 'Jeans', 2, 2200.00),
(106, 'Jacket', 2, 3800.00),
(107, 'SQL Book', 3, 650.00),
(108, 'Python Book', 3, 900.00),
(109, 'AI Book', 3, 1400.00),
(110, 'Washing Machine', 4, 24000.00),
(111, 'Microwave', 4, 11000.00),
(112, 'Refrigerator', 4, 42000.00);

-- Insert order details
insert into order_details (order_detail_id, order_id, product_id, quantity, price) values
(1, 5001, 101, 3, 58000.00),
(2, 5002, 102, 4, 28000.00),
(3, 5003, 103, 6, 4500.00),
(4, 5004, 104, 12, 999.00),
(5, 5005, 105, 7, 2200.00),
(6, 5006, 106, 2, 3800.00),
(7, 5007, 107, 25, 650.00),
(8, 5008, 108, 18, 900.00),
(9, 5009, 109, 9, 1400.00),
(10, 5010, 110, 3, 24000.00),
(11, 5011, 111, 5, 11000.00),
(12, 5012, 112, 2, 42000.00);

-- View all tables
select * from categories;
select * from products order by price desc;
select * from order_details;
show tables;

-- 14. Multiple-table join
select c.category_name, p.product_name, od.order_id, od.quantity
from categories c
inner join products p on p.category_id = c.category_id
inner join order_details od on od.product_id = p.product_id
order by c.category_name, p.product_name;

-- 15. Category-wise total sales
select c.category_name, sum(od.quantity * od.price) as total_sales
from categories c
inner join products p on p.category_id = c.category_id
inner join order_details od on od.product_id = p.product_id
group by c.category_id, c.category_name
order by total_sales desc;
