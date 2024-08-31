-- Joins

-- joins allow you to combine 2 tables together (or more) if they have a common column.
-- doesn't mean they need the same column name, but the data in it are the same and can be used to join the tables together
-- there are several joins we will look at today, inner joins, outer joins, and self joins

USE parks_and_recreation;

-- here are the first 2 tables - let's see what columns and data in the rows we have in common that we can join on
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- let's start with an inner join -- inner joins return rows that are the same in both columns

-- since we have the same columns we need to specify which table they're coming from

SELECT *
FROM employee_demographics
JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id;

-- notice Ron Swanson isn't in the results? This is because he doesn't have an employee id in the demographics table. He refused to give his birth date or age or gender

-- use aliasing!
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


-- OUTER JOINS

-- for outer joins we have a left and a right join
-- a left join will take everything from the left table even if there is no match in the join, but will only return matches from the right table
-- the exact opposite is true for a right join

SELECT *
FROM employee_salary sal
LEFT JOIN employee_demographics dem
	ON dem.employee_id = sal.employee_id;

-- so you'll notice we have everything from the left table or the salary table. Even though there is no match to ron swanson. 
-- Since there is not match on the right table it's just all Nulls

-- if we just switch this to a right join it basically just looks like an inner join
-- that's because we are taking everything from the demographics table and only matches from the left or salary table. Since they have all the matches
-- it looks kind of like an inner join
SELECT *
FROM employee_salary sal
RIGHT JOIN employee_demographics dem
	ON dem.employee_id = sal.employee_id;



-- Self Join

-- a self join is where you tie a table to itself

SELECT *
FROM employee_salary;

-- what we could do is a secret santa so the person with the higher ID is the person's secret santa


SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id = emp2.employee_id
    ;

-- now let's change it to give them their secret santa
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1  = emp2.employee_id
    ;



SELECT emp1.employee_id as emp_santa, emp1.first_name as santa_first_name, emp1.last_name as santa_last_name, emp2.employee_id, emp2.first_name, emp2.last_name
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1  = emp2.employee_id
    ;

-- So leslie is Ron's secret santa and so on -- Mark Brandanowitz didn't get a secret santa, but he doesn't deserve one because he broke Ann's heart so it's all good


-- Joining multiple tables

-- now we have on other table we can join - let's take a look at it
SELECT * 
FROM parks_and_recreation.parks_departments;


SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;

-- now notice when we did that, since it's an inner join it got rid of andy because he wasn't a part of any department

-- if we do a left join we would still include him because we are taking everything from the left table which is the salary table in this instance
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;
    

#UNIONS


#A union is how you can combine rows together- not columns like we have been doing with joins where one column is put next to another
#Joins allow you to combine the rows of data

#Now you should keep it the same kind of data otherwise if you start mixing tips with first_names it would be really confusing, but you can do it.
#Let's try it out and use Union to bring together some random data, then we will look at an actual use case

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT occupation, salary
FROM employee_salary;

#So you can see we basically combined the data together, but not side by side in different columns, but one on top of the other in the same columns
#This obviously is not good since you're mixing data, but it can be done if you want.

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;

-- notice it gets rid of duplicates? Union is actually shorthand for Union Distinct

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;

-- we can use UNION ALL to show all values

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;



#Now Let's actually try to use UNION
# The Parks department is trying to cut their budget and wants to identify older employees they can push out or high paid employees who they can reduce pay or push out
-- let's create some queries to help with this

SELECT first_name, last_name, 'Old'
FROM employee_demographics
WHERE age > 50;



SELECT first_name, last_name, 'Old Lady' as Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Old Man'
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Highly Paid Employee'
FROM employee_salary
WHERE salary >= 70000
ORDER BY first_name
