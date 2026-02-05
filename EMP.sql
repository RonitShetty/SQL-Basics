CREATE DATABASE EMPLOYEES_DB;
CREATE SCHEMA EMPLOYEES_SC;
USE DATABASE EMPLOYEES_DB;
USE SCHEMA EMPLOYEES_SC;

create table empl(
e_id int ,
e_name varchar(20),
e_salary int,
e_age int,
e_gender varchar(10),
e_dept varchar(50),
PRIMARY key(e_id)
);

select * from empl;

insert INTO empl values (3,'Ram',24000,27,'Male','Developement');
insert INTO empl values (4,'Sham',18000,30,'Male','Account');
insert INTO empl values (5,'Sai',21000,38,'Fale','Sales');
insert INTO empl values (6,'Pooja',26000,22,'Female','Purchase');
insert INTO empl values (7,'Govind',32000,30,'Male','Account');
insert INTO empl values (8,'Raghav',20000,32,'Male','Sales');
insert INTO empl values (9,'Rohini',35000,34,'Male','Account');
insert INTO empl values (10,'Rupa',40000,23,'Female','Developement');

SELECT * FROM empl;

SHOW COLUMNS;

SELECT * FROM EMPL LIMIT 4 OFFSET 1;

SELECT e_name, e_salary FROM empl
ORDER BY e_salary ASC;

SELECT count(e_id), e_dept FROM EMPL
GROUP BY e_dept;

select e_name, e_salary from empl
where e_salary >=25000;

select e_name, e_salary from empl
where e_salary between 10000 and 20000;

---e id of emps female, dept sales, salary > 20000, no dupes

SELECT e_id from empl
WHERE e_salary > 20000 AND e_dept = 'Sales' AND e_gender = 'Female';

SELECT e_name from empl
WHERE e_dept IN ('Sales','Development');

UPDATE empl set e_age = 35 where e_id=1;
SELECT * FROM empl;

UPDATE empl set e_gender = 'Female' where e_id = 5;

SELECT AVG(e_salary), e_dept FROM empl  
WHERE e_dept = 'Sales' OR e_dept='Account'
GROUP BY e_dept;

SELECT e_dept, e_name, e_salary 
FROM (SELECT e_dept, e_name, e_salary,RANK() OVER (PARTITION BY e_dept ORDER BY e_salary ASC) as rnk
FROM empl) sub
WHERE rnk = 1;

ALTER TABLE empl 
ADD e_email VARCHAR(100);

ALTER TABLE empl
DROP COLUMN e_email;

ALTER TABLE empl RENAME TO employees;

DELETE FROM employees WHERE e_id = 7;

SELECT e_dept,AVG(e_salary), AVG(e_age) FROM employees GROUP BY e_dept;

SELECT MIN(e_salary), Max(e_salary), AVG(e_salary), COUNT(*), e_dept FROM employees GROUP BY e_dept;

SELECT e_dept, e_name, e_salary FROM employees WHERE (e_dept, e_salary) IN (SELECT e_dept, MAX(e_salary) FROM employees GROUP BY e_dept);

SELECT e_name, e_age, e_salary FROM employees 
WHERE e_age > (SELECT AVG(e_age) FROM employees) AND e_salary <25000;

SELECT e_name, e_dept FROM employees 
WHERE e_dept = 'Sales' OR e_dept = 'Account' AND e_salary > (SELECT AVG(e_salary) FROM employees WHERE e_dept = employees.e_dept);

SELECT e_dept, AVG(e_salary), COUNT(*) FROM employees 
GROUP BY e_dept
HAVING AVG(e_salary) > 22000 AND COUNT(*) >2;

SELECT e_id, e_name, e_salary
FROM employees
WHERE e_salary > (SELECT MAX(e_salary) FROM employees WHERE e_dept = 'Sales');

SELECT MAX(e_salary) - MIN(e_salary) AS salary_diff
FROM employees;
