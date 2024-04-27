--do ³¹czenia tabel wed³ug klucza bêdziemy potrzebowaæ poleceñ join
--je¿eli dane których potrzebujemy przechowywane s¹ w wielu tabelach to joiny bêd¹ niezbêdne
--do joinów wykorzystujemy 2 klauzule: zgodne z ANSI i Oraclowe.

-- Where
select * from employees, departments 
where employees.department_id = departments.department_id;

-- Cross join - ³¹czy ka¿dy wiersz z ka¿dym czyli np. 1 tabela: 20 wierszy, 2 tabela: 20 wierszy, crosss join: 20x20
SELECT last_name, department_name
FROM employees CROSS JOIN departments;
Select * from employees,departments;

--INNER JOIN vs OUTER JOIN
--INNER JOIN - to co jest w A i B, czyli ³¹czy tylko niepuste klucze A i B. To co dotychczas poznaliœmy to INNER JOIN (oprócz iloczynu kartezjañskiego)
--LEFT OUTER JOIN - wszystko to co jest w A i niepuste klucze z B
--RIGHT OUTER JOIN - wszystko to co jest w B i niepuste klucze z A
--FULL OUTER JOIN - wszystko z A i B (puste i niepuste klucze)

--porównajmy
SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
INNER JOIN departments d ON (e.department_id = d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
LEFT OUTER JOIN departments d ON (e.department_id = d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
RIGHT OUTER JOIN departments d ON (e.department_id = d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e 
FULL OUTER JOIN departments d ON (e.department_id = d.department_id);

--alisowanie tabel - otrzymamy b³¹d bo SQL nie bêdzie wiedzia³ z której tabeli wzi¹æ department_id
SELECT last_name, e.job_id, department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND department_id = 80;
