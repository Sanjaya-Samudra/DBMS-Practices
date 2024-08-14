select distinct first_name,gender from `parks_and_recreation`.employee_demographics;

INSERT INTO `parks_and_recreation`.employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(13,'Leslie', 'Knope', 44, 'Female','1979-09-25');

select first_name,gender from `parks_and_recreation`.employee_demographics where first_name='Leslie';

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01' and age>35;


select first_name,gender from `parks_and_recreation`.employee_demographics where first_name !='Leslie';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%';

SELECT gender
FROM employee_demographics
GROUP BY gender;

SELECT first_name
FROM employee_demographics
GROUP BY gender;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

SELECT *
FROM employee_demographics
ORDER BY first_name;

SELECT *
FROM employee_demographics
ORDER BY gender, age;

SELECT *
FROM employee_demographics
ORDER BY age, gender;

SELECT *
FROM employee_demographics
ORDER BY gender DESC, age DESC;

SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT gender, AVG(age) as AVG_age
FROM employee_demographics
GROUP BY gender
HAVING AVG_age > 40
;

SELECT *
FROM employee_demographics
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3;


SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3,2;

-- we can use the keyword AS to specify we are using an Alias

SELECT gender, AVG(age) AS Avg_age
FROM employee_demographics
GROUP BY gender
;

SELECT DISTINCT dept_id, COUNT(*) 
FROM employee_salary 
WHERE salary > 30000 
GROUP BY dept_id 
HAVING COUNT(*) > 1
ORDER BY dept_id ASC 
LIMIT 1;
