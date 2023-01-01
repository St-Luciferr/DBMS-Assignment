/*
employee(employee-name, street, city)
works(employee-name, company-name, salary)
company(company-name, city)
manages (employee-name, manager-name)
*/

/*
1. Give an SQL schema definition for the employee database of Figure 5. Choose an appropriate
primary key for each relation schema, and insert any other integrity constraints (for example,
foreign keys) you find necessary.
*/

CREATE DATABASE db_Company;
USE db_Company;

CREATE TABLE tbl_employee (
    employee_name VARCHAR(64) NOT NULL PRIMARY KEY,
    street VARCHAR(32),
    city VARCHAR(32)
);


CREATE TABLE Tbl_Company (
    company_name VARCHAR(64) NOT NULL PRIMARY KEY,
    city VARCHAR(32)
);


CREATE TABLE Tbl_works (
    employee_name VARCHAR(64) NOT NULL PRIMARY KEY,
    company_name VARCHAR(64),
    salary FLOAT,
    FOREIGN KEY (employee_name)
        REFERENCES Tbl_employee (employee_name),
    FOREIGN KEY (company_name)
        REFERENCES Tbl_Company (company_name)
);



CREATE TABLE Tbl_manages (
    employee_name VARCHAR(64) NOT NULL PRIMARY KEY,
    manager_name VARCHAR(64) NOT NULL,
    FOREIGN KEY (employee_name)
        REFERENCES Tbl_employee (employee_name)
);

 -- Insert some data into Employee Table
INSERT INTO Tbl_employee(employee_name, street, city)
VALUES ('Raj Kumar Dhakal','Chandor Chowk','Lalitpur'),
	   ('Ujjwal Poudel', 'Maitighar', 'Kathmandu'),
	   ('Rishav Subedi', 'Maitighar', 'Kathmandu'),
       ('Santosh Pandey', 'Char Do bato', 'Bhaktapur'),
       ('Prabin Bohora', 'Chandol Chowk', 'Lalitpur'),
       ('Shiwani Shah','Budhhanagar','Kathmandu'),
       ('Prinsa Joshi','Suryabinayak','Bhaktapur'),
       ('Hellington Javier', 'Aster Avenue', 'Bellington'),
       ('Einstein Karki', 'New chowk', 'New town'),
       ('Newton Neupane', 'Old chowk', 'Old Town'),
       ('John','Old Chowk','Old Town');

-- View data in employee table      
SELECT 
    *
FROM
    tbl_employee;

-- Insert Data in Company table
INSERT INTO Tbl_Company(company_name, city)
VALUES ('Bhoos Games', 'Lalitpur'),
        ('Fuse Machines', 'Bhaktapur'),
        ('F1Soft IT Solution', 'Kathmandu'),
        ('MSI Corporated','Kathmandu'),
        ('First Bank Corporation','Bhaktapur'),
        ('Small Bank Corporation','Bhaktapur');
        
-- View data from company table
SELECT 
    *
FROM
    tbl_company;

-- Insert Data into Work Table
INSERT INTO Tbl_Works(employee_name, company_name, salary)
VALUES ('Raj Kumar Dhakal', 'Fuse Machines', 55000),
	   ('Ujjwal Poudel', 'MSI Corporated', 65000),
	   ('Prabin Bohora', 'Fuse Machines', 69000),
       ('Santosh Pandey', 'F1Soft IT Solution', 85000),
       ('Rishav Subedi', 'Bhoos Games', 100000),
       ('Shiwani Shah','First Bank Corporation',55000),
       ('Prinsa Joshi','First Bank Corporation',55000),
       ('John','Small Bank Corporation',8000),
       ('Hellington Javier', 'First Bank Corporation', 25000),
	   ('Einstein Karki', 'First Bank Corporation', 56000),
       ('Newton Neupane', 'First Bank Corporation', 47256),
       ('Raj Kumar Dhakal', 'Fuse Machines', 55000);

-- View data from Works table
SELECT 
    *
FROM
    tbl_works;

-- Insert data into manages table
INSERT INTO Tbl_manages(employee_name, manager_name)
VALUES ('Hellington Javier', 'Newton Neupane'),
	   ('Einstein Karki', 'Newton Neupane'),
       ('Rishav Subedi', 'Ujjwal Poudel'),
       ('Shiwani Shah', 'Prinsa Joshi'),
	   ('John', 'Shiwani Shah'),
       ('Raj Kumar Dhakal', 'Prabin Bohora');

-- View data from Manages table
SELECT 
    *
FROM
    tbl_manages;
    
/*
2. Consider the employee database of Figure 5, where the primary keys are underlined. Give
an expression in SQL for each of the following queries:
*/

/*
2.a) Find the names of all employees who work for First Bank Corporation
*/
SELECT 
    employee_name
FROM
    tbl_works
WHERE
    company_name = 'First Bank Corporation';

/*
2.b) Find the names and cities of residence of all employees who work for First Bank Corporation.
*/
SELECT 
    tbl_employee.employee_name, tbl_employee.city
FROM
    tbl_employee
WHERE
    tbl_employee.employee_name = ANY (SELECT DISTINCT
            tbl_works.employee_name
        FROM
            tbl_works
        WHERE
            tbl_works.company_name = 'First Bank Corporation');

/*
2.c) Find the names, street addresses, and cities of residence of all employees who work for
First Bank Corporation and earn more than $10,000.
*/
SELECT 
    tbl_employee.employee_name,
    tbl_employee.street,
    tbl_employee.city
FROM
    tbl_employee
WHERE
    tbl_employee.employee_name = ANY (SELECT 
            tbl_works.employee_name
        FROM
            tbl_works
        WHERE
            tbl_works.company_name = 'First Bank Corporation'
                AND tbl_works.salary > 10000);

/*
2.d) Find all employees in the database who live in the same cities as the companies for
which they work.
*/
SELECT 
    tbl_employee.employee_name, Tbl_employee.city
FROM
    tbl_employee
WHERE
    tbl_employee.city = (SELECT 
            tbl_Company.city
        FROM
            tbl_Company
        WHERE
            tbl_Company.company_name = (SELECT 
                    tbl_Works.company_name
                FROM
                    tbl_Works
                WHERE
                    tbl_works.employee_name = tbl_employee.employee_name));
                    
/*
2.e) Find all employees in the database who live in the same cities and on the same streets
as do their managers.
*/
SELECT 
    *
FROM
    Tbl_manages
WHERE
    (SELECT 
            tbl_employee.city
        FROM
            Tbl_employee
        WHERE
            Tbl_employee.employee_name = Tbl_manages.manager_name) = (SELECT 
            tbl_employee.city
        FROM
            Tbl_employee
        WHERE
            Tbl_employee.employee_name = Tbl_manages.employee_name)
        AND (SELECT 
            tbl_employee.street
        FROM
            Tbl_employee
        WHERE
            Tbl_employee.employee_name = Tbl_manages.manager_name) = (SELECT 
            tbl_employee.street
        FROM
            Tbl_employee
        WHERE
            Tbl_employee.employee_name = Tbl_manages.employee_name);                    

/*
2.f) Find all employees in the database who do not work for First Bank Corporation.
*/
SELECT 
    tbl_works.employee_name
FROM
    tbl_works
WHERE
    tbl_works.company_name != 'First Bank Corporation';


/*
2.g) Find all employees in the database who earn more than each employee of Small Bank
Corporation
*/
-- how to show for each employee??

/*
2.h) Assume that the companies may be located in several cities. Find all companies located
in every city in which Small Bank Corporation is located.
*/

SELECT 
    *
FROM
    tbl_company
WHERE
    tbl_company.city = (SELECT 
            tbl_company.city
        FROM
            tbl_company
        WHERE
            tbl_company.company_name = 'Small Bank Corporation');

/*
2.i) Find all employees who earn more than the average salary of all employees of their
company.
*/
SELECT 
    tbl_works.employee_name, tbl_works.company_name
FROM
    (SELECT 
        company_name, AVG(salary) AS av
    FROM
        tbl_works
    GROUP BY company_name) AS avg_salary
        JOIN
    tbl_works ON avg_salary.company_name = tbl_works.company_name
WHERE
    tbl_works.salary > avg_salary.av;
    
/*
2.j) Find the company that has the most employees.
*/

SELECT 
    company_name, cnt
FROM
    (SELECT 
        company_name, COUNT(employee_name) AS cnt
    FROM
        tbl_works
    GROUP BY company_name) as W1
ORDER BY cnt DESC
LIMIT 1;

/*
2.k) Find the company that has the smallest payroll.
*/
SELECT 
    company_name, payroll 
FROM
    (SELECT 
        company_name, sum(salary) AS payroll
    FROM
        tbl_works
    GROUP BY company_name) as total_payroll
ORDER BY payroll asc
LIMIT 1;


/*
2.l) Find those companies whose employees earn a higher salary, on average, than the
average salary at First Bank Corporation.
*/
SELECT 
    company_name,av
FROM
    (SELECT 
        company_name, AVG(salary) AS av
    FROM
        tbl_works
    GROUP BY company_name) AS avg_salary
WHERE
    avg_salary.av > (SELECT 
            avgs
        FROM
            (SELECT 
                company_name, AVG(salary) AS avgs
            FROM
                tbl_works
            GROUP BY company_name) AS avgs_salary
        WHERE
            avgs_salary.company_name = 'First Bank Corporation');
            
