--dodawanie nowych rekordów do bazy danych
--skopiujmy sobie tabele przed modyfikacj¹
CREATE TABLE copy_employees
AS (SELECT * FROM employees); 
CREATE TABLE copy_departments
AS (SELECT * FROM departments); 
CREATE TABLE sales_reps
AS (SELECT * FROM departments where 1 = 0); 

select * from copy_employees;
select * from copy_departments;

--dodajmy nowy wiersz
INSERT INTO copy_departments
(department_id, department_name, manager_id, location_id) --nazwy kolumn (opcjonalnie)
VALUES
(200,'Human Resources', 205, 1500);

INSERT INTO copy_departments
VALUES 
(210,'Estate Management', 102, 1700); --kolejnoœæ wartoœci jak kolejnoœæ kolumn

INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES
(302,'Grigorz','Polanski', 'gpolanski', NULL, '15-Jun-2015', 'IT_PROG',4200);

INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES (304,'Test',USER, 't_user', 4159982010, SYSDATE, 'ST_CLERK',2500); --dodajemy sysdate

INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
VALUES
(303,'Angelina','Wright', 'awright','4159982010', 
TO_DATE('July 10, 2015 17:20', 'Month fmdd, yyyy HH24:MI'), --funkcja w insert
'MK_REP', 3600); 

--kopiowanie z jednej tabeli do drugiej
INSERT INTO sales_reps (id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';


INSERT INTO sales_reps
SELECT * 
FROM employees;


--zmiana istniej¹cych rekordów w bazie
UPDATE copy_employees
SET phone_number = '123456'
WHERE employee_id = 303; --wa¿ne: dodajemy where, ¿eby nie zmieniaæ wszystkich rekordów

UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'
WHERE employee_id >= 303;  

UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'; --update wszystkich warunków

--pracownik 101 bêdzie mia³ tak¹ sam¹ pensje jak pracownik 100
UPDATE copy_employees SET salary = (SELECT salary
FROM copy_employees WHERE employee_id = 100) 
WHERE employee_id = 101;

--wiele kolumn na raz
UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE employee_id = 205), 
job_id = (SELECT job_id
FROM copy_employees
WHERE employee_id = 205)
WHERE employee_id = 206;


--usuwanie rekordów
--usuwanie jednego wiersza
DELETE from copy_employees WHERE employee_id = 303;

--delete z podzapytaniem
DELETE FROM copy_employees
WHERE department_id = (SELECT department_id
FROM departments WHERE department_name = 'Shipping');

--delete z podzapytaniem wielowierszowym
DELETE FROM copy_employees e
WHERE e.manager_id IN
(SELECT d.manager_id
FROM employees d
HAVING count (d.department_id) < 2
GROUP BY d.manager_id);



drop table copy_employees;
drop table copy_departments;
drop table sales_reps;
