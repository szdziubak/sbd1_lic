--Podzapytania

--Podzapytania - zapytanie wewnêtrzne wykorzystywane przez zapytanie g³ówne
--podzapytania umieszczamy w nawiasach
--nie mo¿e zawieraæ ORDER BY

/*
Typy podzapytañ:
- jednowierszowe - zwracaj¹ jeden wiersz, u¿yjemy >, =, <, <>, <=
- wielowierszowe - zwracaj¹ wiele wierszy, u¿yjemy IN, ANY, ALL
*/

--podzapytania jednowierszowe
SELECT first_name, last_name, hire_date
FROM employees WHERE hire_date > (SELECT hire_date
FROM employees WHERE last_name = 'Vargas');

SELECT last_name FROM employees
WHERE department_id = (SELECT department_id
FROM employees WHERE last_name = 'Grant'); --podzapytanie zwraca NULL

SELECT last_name, job_id, department_id
FROM employees
WHERE department_id = 
(SELECT department_id --nie wiemy który department_id ma marketing wiêc tworzymy podzapytanie
FROM departments
WHERE department_name = 'Marketing')
ORDER BY job_id;


SELECT last_name, job_id, salary, department_id
FROM employees
WHERE job_id = 
(SELECT job_id
FROM employees 
WHERE employee_id = 141) --jeden warunek
AND department_id = 
(SELECT department_id
FROM departments 
WHERE location_id = 1500); --drugi warunek

--z funkcjami grupuj¹cymi
SELECT last_name, salary
FROM employees
WHERE salary < 
(SELECT AVG(salary) --pracownicy zarabiaj¹cy poni¿ej œredniej
FROM employees);

--departamenty z pensj¹ wy¿sz¹ ni¿ minimalna dla departamentów
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
(SELECT MIN(salary)
FROM employees
WHERE department_id = 50);


--podzapytania wielowierszowe
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90); --lata zatrudnienia wœród lat zatrudnienia ludzi z departamentu 90

--ANY - co najmniej jedna wartoœæ
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY --rok musi byæ mniejszy ni¿ co najmneij jeden rok spoœród pracowników z departamentu 90
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);


--ALL - wszystkie wartoœci
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ALL --rok musi byæ mniejszy ni¿ wszystkie wartoœci
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

--Dla ANY i IN je¿eli w podzapytaniu mamy NULL to zapytanie g³ówne zwróci wiersze które bêd¹ pasowa³y do nienullowych wartoœci
--Dla ALL je¿eli w podzapytaniu mamy NULL to podzapytanie nie zwróci nic wiêc zapytanie g³ówne równie¿ nic nie zwróci
SELECT last_name, employee_id
FROM employees
WHERE employee_id IN
(SELECT manager_id
FROM employees);

SELECT last_name, employee_id
FROM employees
WHERE employee_id <= ALL
(SELECT manager_id
FROM employees);

--podzapytania wielowierszowe z funkcj¹ grupuj¹c¹
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
(SELECT salary
FROM employees
WHERE department_id IN (10,20))
ORDER BY department_id;

/*--podzapytania z wieloma kolumnami
SELECT employee_id, manager_id, department_id
FROM employees
WHERE(manager_id,department_id) IN
(SELECT manager_id,department_id
FROM employees
WHERE employee_id IN (149,174))
AND employee_id NOT IN (149,174);

--odpowiednik tego wy¿ej:
SELECT employee_id,
manager_id, 
department_id
FROM employees
WHERE manager_id IN 
(SELECT manager_id
FROM employees
WHERE employee_id IN 
(149,174))
AND department_id IN 
(SELECT department_id
FROM employees
WHERE employee_id IN 
(149,174))
AND employee_id NOT IN(149,174);*/
