--omówmy proste polecenie
select * from employees;
select salary from employees;
select hire_date from employees;

--distinct usuwa duplikaty
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;

--tabela dual - tabela do wykonywania obliczeñ
select 2+3 from dual;
select 3-2 from dual;
select 12*30 from dual;
select 319/29 + 12 from dual; --SQL automatycznie rozpoznaje kolejnoœæ wykonywania dzia³añ

--operator where - filtrowanie wierszy
--where: mo¿emy u¿ywaæ opeatorów porównania: =, >, >=, <, <=, <> / != / ^=
SELECT employee_id, last_name, department_id FROM employees WHERE department_id = 90;
SELECT first_name, last_name FROM employees WHERE last_name = 'Taylor';
/*WHERE hire_date < '01-Jan-2000'
WHERE salary >= 6000
WHERE job_id = 'IT_PROG'*/

--between
SELECT last_name, salary FROM employees WHERE salary BETWEEN 9000 AND 11000; 
--jest to to samo co: WHERE salary >= 9000 AND salary <=11000;

--in
SELECT city, state_province, country_id FROM locations WHERE country_id IN('UK', 'CA');
--jest to to samo co: WHERE country_id = 'UK' OR country_id = 'CA';

--like
-- % - dowolny ci¹g znaków
-- _ - jeden znak
SELECT last_name FROM employees WHERE last_name LIKE '_o%';

-- escape character - oznacza, ¿e u¿yjemy % lub _ jako znaku a nie wildcard
SELECT last_name, job_id FROM EMPLOYEES WHERE job_id LIKE '%\_R%' ESCAPE '\';
SELECT last_name, job_id FROM EMPLOYEES WHERE job_id LIKE '%_R%';

--NULL / NOT NULL --null to wartoœæ pusta
SELECT last_name, manager_id FROM employees WHERE manager_id IS NULL;
SELECT last_name, commission_pct FROM employees WHERE commission_pct IS NOT NULL;

--operacje z NULLem zwracaj¹ null:
select NULL + 3 from dual;
select commission_pct * salary from employees;

--aby pozbyæ siê problemu nulli mo¿emy zastosowaæ funckjê NVL/NVL2
--NVL(wyra¿enie, które mo¿e mieæ NULL, je¿eli ma null to czym go zast¹pimy)
select NVL(NULL, 'tekst') as funkcja_nvl from dual;
SELECT last_name, NVL(commission_pct, 0) FROM employees WHERE department_id IN(80,90);
select employee_id, nvl(bonus, 0) from employees;
--NVL2(wyra¿enie, które mo¿e mieæ NULL, je¿eli nie jest NULL to czym je zast¹pimy, je¿eli ma null to czym go zast¹pimy)
select NVL2(NULL, 'nie bylo nulla',  'byl null') as funkcja_nvl from dual;
select NVL2(1, 'nie bylo nulla', 'byl null') as funkcja_nvl from dual;
SELECT last_name, salary, NVL2(commission_pct, salary + (salary * commission_pct), salary) AS income;
FROM employees WHERE department_id IN(80,90); 

--Warunki z³o¿one
--operatory logiczne AND, OR, NOT
/*TRUE AND FALSE = FALSE
TRUE AND TRUE = TRUE
FALSE AND FALSE = FALSE
TRUE OR FALSE = TRUE
TRUE OR TRUE = TRUE
FALSE OR FALSE = FALSE
NOT TRUE = FALSE
NOT FALSE = TRUE*/

--musz¹ byæ spe³nione obydwa warunki
SELECT last_name, department_id, salary FROM employees WHERE department_id > 50 AND salary > 12000;
SELECT last_name, hire_date, job_id FROM employees WHERE hire_date > '01-Jan-1998' AND job_id LIKE 'SA%';

--musi byæ spe³niony chocia¿ jeden warunek
SELECT department_name, manager_id, location_id FROM departments WHERE location_id = 2500 OR manager_id=124;

--nie mo¿e byæ spe³niony ten warunek
SELECT department_name, location_id FROM departments WHERE location_id NOT IN (1700,1800);
