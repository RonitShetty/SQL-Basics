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

SELECT * FROM employees
WHERE e_salary > (SELECT AVG(e_salary) FROM employees);

SELECT * FROM employees
WHERE e_salary = (SELECT MAX(e_salary) FROM employees);

use database employees_db;

create table bank(
  e_id int PRIMARY key,
  bank_name varchar(20),
  ITR_paid_amount int
  );
 
 select* from bank
 
 insert INTO bank values (1,'kotak',1200);
 insert INTO bank values (2,'SBI',1400);
 insert INTO bank values (3,'ICICI',1500);
 insert INTO bank values (4,'RBL',1100);
 insert INTO bank values (5,'kotak',1150);
 insert INTO bank values (6,'SBI',1000);
 insert INTO bank values (7,'SBI',1390);
 insert INTO bank values (8,'AXIS',2200);
 insert INTO bank values (9,'IDFC',1900);
 insert INTO bank values (10,'AXIS',1800);
 insert INTO bank values (100,'AXIS',1800);
 insert INTO bank values (101,'RBL',1700);
 

select * FROM bank
select * FROM employees

select * from employees
inner JOIN bank on employees.e_id=bank.e_id

select * from employees
LEFT JOIN bank on employees.e_id=bank.e_id

select * from employees
RIGHT JOIN bank on employees.e_id=bank.e_id

CREATE VIEW DEVELOPEMENT_EMPLOYEES AS SELECT e_id, e_name, e_salary FROM EMPLOYEES
WHERE E_DEPT = 'Developement';

SELECT * FROM DEVELOPEMENT_EMPLOYEES;
SELECT * FROM EMPLOYEES;

SELECT e_id, e_name, 1.1*e_salary as bonus from employees;

CREATE OR REPLACE PROCEDURE SHOW_EMPS()
RETURNS TABLE()
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
DECLARE
    res RESULTSET DEFAULT (SELECT * FROM EMPLOYEES);
BEGIN
    RETURN TABLE(res);
END;
$$;

CALL SHOW_EMPS();

CREATE OR REPLACE PROCEDURE INSERT_EMPL(
    p_id INTEGER, 
    p_name VARCHAR, 
    p_salary INTEGER, 
    p_age INTEGER, 
    p_gender VARCHAR, 
    p_dept VARCHAR
)
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    INSERT INTO employees (e_id, e_name, e_salary, e_age, e_gender, e_dept) 
    VALUES (:p_id, :p_name, :p_salary, :p_age, :p_gender, :p_dept);

    RETURN 'Success: Employee ' || :p_name || ' added with ID ' || :p_id;
EXCEPTION
    WHEN OTHER THEN
        RETURN 'Error: ' || SQLERRM;
END;
$$;

CALL INSERT_EMPL(100,'John',5000000,30,'Male','Developement');

SELECT * FROM EMPLOYEES WHERE e_id = 100;

CREATE OR REPLACE PROCEDURE UPDATE_SAL(NEW_SAL INT, EMP_ID INT)
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    UPDATE EMPLOYEES
    SET E_SALARY = :NEW_SAL  -- Added colon to bind variable
    WHERE E_ID = :EMP_ID;    -- Added colon to bind variable
    
    RETURN 'SALARY UPDATED'; -- Removed unnecessary parentheses
END;
$$;

CALL UPDATE_SAL(45000, 9);


select * from employees;

SELECT e_id, e_name, CASE WHEN e_salary > 35000 THEN 'High' WHEN e_salary BETWEEN 30000 AND 35000 THEN 'Medium' ELSE 'Low' END AS Salary_Level FROM EMPLOYEES;

SELECT E_NAME, IFF(E_AGE > 30, 'Senior', 'Junior') AS SENIORITY FROM EMPLOYEES;

