--Konkatencja - ³¹czenie ci¹gów znaków
select 'Ala' || ' ma ' || 'kota' from dual;
SELECT department_id || department_name FROM departments;
SELECT department_id ||' '||department_name FROM departments;
SELECT CONCAT('Hello', 'World') FROM DUAL;
SELECT CONCAT(first_name, last_name) FROM employees;
SELECT CONCAT(CONCAT(first_name, '     '), last_name) FROM employees;

--Aliasy kolumn
SELECT department_id ||' '|| department_name AS " Department Info " FROM departments;
SELECT first_name ||' '|| last_name AS "Employee Name" FROM employees;
SELECT last_name || ' has a monthly salary of ' || salary || ' dollars.' AS Pay FROM employees;
SELECT last_name ||' has a '|| 1 ||' year salary of '|| salary*12 || ' dollars.' AS Pay FROM employees;

--DESC - opis tabeli
DESC employees;
DESCRIBE employees; --to samo

--sortowanie
--ORDER BY
--domyœlne sortowanie to ascending: 
    --od najstarszego do najnowszego 
    --od najmniejszego do najwiêkszego
    --od a do z
    --Nulle bêd¹ ostatnie

SELECT last_name, hire_date FROM employees ORDER BY hire_date;
--sortowanie malej¹co
SELECT last_name, hire_date FROM employees ORDER BY hire_date DESC;
--sortowanie z aliasami
SELECT last_name, hire_date AS "Date Started" FROM employees ORDER BY "Date Started";
SELECT last_name, hire_date DateStarted FROM employees ORDER BY DateStarted ;
--sortowanie po kolumnie której nie ma w select
SELECT employee_id, first_name FROM employees WHERE employee_id < 105 ORDER BY last_name;

/*
Kolejnoœæ wykonywania:
FROM
WHERE
SELECT
ORDER BY
*/

--sortowanie po wielu kolumnach
SELECT department_id, last_name FROM employees WHERE department_id <= 50 ORDER BY department_id, last_name;
SELECT department_id, last_name FROM employees WHERE department_id <= 50 ORDER BY department_id DESC, last_name;
