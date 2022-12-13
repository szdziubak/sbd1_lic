--funkcje grupuj¹ce (wielowierszowe): SUM, AVG, COUNT, MAX, MIN, STDDEV, VARIANCE
SELECT MAX(salary)
FROM employees;

SELECT AVG(salary) from employees where department_id = 90;
SELECT to_char(ROUND(AVG(salary),1), '$99,999.99') from employees where department_id = 90;
SELECT MAX(salary), MIN(salary), MIN(employee_id)
FROM employees WHERE department_id = 60;

--funkcje gupuj¹ce ignoruj¹ NULLe, nie mog¹ byæ u¿yte w klauzuli where
SELECT COUNT(job_id) FROM employees; --tylu mamy pracowników
SELECT COUNT(commission_pct) FROM employees; --tyle jest niepustych wartoœci commission_pct
SELECT COUNT(*) FROM employees WHERE hire_date < '01-Jan-1996'; --zliczanie wszystkich wierszy

--DISTINCT - unikalne wartoœci
SELECT DISTINCT job_id FROM employees;
SELECT COUNT (DISTINCT job_id) FROM employees; --zliczenie unikalnych job_id
SELECT DISTINCT job_id, department_id FROM employees; --unikalne wartoœci z 2 kolumn

SELECT SUM(salary) FROM employees WHERE department_id = 90;
--vs
SELECT SUM(DISTINCT salary) FROM employees WHERE department_id = 90;

SELECT AVG(NVL(commission_pct, 0)) FROM employees;
--vs
SELECT AVG(commission_pct) FROM employees;


--group by - grupuje bo jakiejs wartosci
SELECT department_id, AVG(salary) FROM employees
GROUP BY department_id ORDER BY department_id; 

SELECT MAX(salary) FROM employees GROUP BY department_id;
SELECT department_id, MAX(salary) FROM employees GROUP BY department_id;
SELECT job_id, last_name, AVG(salary) FROM employees GROUP BY job_id; --b³¹d, wszystkie kolumny uwzglêdnione w select powinny byæ u¿yte w group by
SELECT department_id, MAX(salary) FROM employees WHERE last_name != 'King' GROUP BY department_id;
SELECT max(avg(salary)) FROM employees GROUP by department_id; --zagnie¿dzenia

--having
SELECT department_id,MAX(salary) FROM employees
GROUP BY department_id HAVING COUNT(*)>1 ORDER BY department_id; --wiêcej ni¿ 1 pracownik w departamencie
