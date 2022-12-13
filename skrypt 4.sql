--Funkcje
--jednowierszowe - jeden wiersz na wejœciu, jeden na wyjœciu np. formatowanie tekstu
--wielowierszowe - wiele wierszy na wejœciu, jeden na wyjœciu np. œrednia

--funkcje tekstowe
SELECT last_name FROM employees WHERE LOWER(last_name) = 'abel';

SELECT last_name FROM employees WHERE UPPER(last_name) = 'ABEL';

SELECT last_name FROM employees WHERE INITCAP(last_name) = 'Abel';

SELECT SUBSTR('HelloWorld', 1, 5) FROM DUAL;
SELECT SUBSTR('HelloWorld', 6) FROM DUAL;
SELECT SUBSTR(last_name, 1, 3) FROM employees;

SELECT LENGTH('HelloWorld') FROM DUAL;
SELECT LENGTH(last_name) FROM employees;

SELECT LPAD('HelloWorld', 15, '-') FROM DUAL; --z lewej uzupe³nia do 15 znaków
SELECT LPAD(last_name, 10, '*') FROM employees; --z lewej uzupe³nia do 10 znaków

SELECT RPAD('HelloWorld', 15, '-') FROM DUAL; --uzupe³nia z prawej
SELECT RPAD(last_name, 10, '*') FROM employees; --uzupe³nia z prawej

SELECT REPLACE('JACK and JUE', 'J', 'BL') FROM DUAL; --zamienia J na BL w JACK and JUE
SELECT REPLACE('JACK and JUE', 'J') FROM DUAL; --zamienia J na nic
SELECT REPLACE(last_name, 'a', '*') FROM employees; 

SELECT TRANSLATE('TAJNA WIADOMOŒÆ', 'A¥BCÆDEFGHIJKLMNOÓPRSŒTUWXYZ¯', 'CÆDEFGHIJKLMNOÓPRSŒTUWXYZ¯AQB') from dual; --konwertuje A na C, ¥ na Æ, B na E itd, n-ty znak z pierwszego ci¹gu na n-ty wyraz drugiego
SELECT TRANSLATE(first_name, 'A¥BCÆDEFGHIJKLMNOÓPRSŒTUWXYZ¯', 'CÆDEFGHIJKLMNOÓPRSŒTUWXYZ¯AQB') from employees; 

--Funkcje numeryczne wykonuj¹ obliczenia
select ROUND(45.926, 2) from dual; --zaokroglenie do 2 miejsc
select ROUND(45.926, -1) from dual; --zaokraglenie do -1 miejsca
select round((salary*(1+nvl(commission_pct, 0))+nvl(bonus, 0))*0.185,-1) as premia_œwi¹teczna from employees;
select TRUNC (45.926, 2) from dual --obcina nie zaokr¹gla
select TRUNC (45.926) from dual;
select mod(3,2) from dual; --operator modulo, reszta z dzielenia
SELECT ABS(-1) from dual;
SELECT CEIL(1.222) from dual; --2
SELECT FLOOR(1.222) from dual; --1
SELECT GREATEST(1,2,3,4) from dual; --4
SELECT LEAST(1,2,3,4) from dual; --1
SELECT POWER(2,3) from dual; --8
SELECT SQRT(5) from dual; --2,236, 5^(1/2)

--Funkcje dat przetwarzaj¹ daty i czas

SELECT SYSDATE FROM dual; --dzisiejsza data

SELECT last_name, hire_date + 60 FROM employees; --+60 dni

SELECT employee_id, (sysdate - hire_date)/365 
AS "Tenure in last job" FROM employees; --iloœæ lat pracy

SELECT last_name, hire_date FROM employees
WHERE MONTHS_BETWEEN (SYSDATE, hire_date) > 240; --iloœæ miesiêcy pomiêdzy datami

SELECT ADD_MONTHS (SYSDATE, 12) AS "Next Year" FROM dual; --dodaje 12 miesiecy do biezacej daty

SELECT NEXT_DAY (SYSDATE, 'Saturday') AS "Next Saturday" FROM dual; --wyswietla nastepna sobote

SELECT LAST_DAY (SYSDATE) AS "End of the Month" FROM dual; --ostatni dzieñ miesi¹ca

SELECT hire_date, ROUND(hire_date, 'Month')
FROM employees WHERE department_id = 50; --zaokr¹gla do pe³nego miesi¹ca

SELECT hire_date, ROUND(hire_date, 'Year')
FROM employees WHERE department_id = 50; --zaokr¹gla do lat

SELECT employee_id, hire_date, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS TENURE,
ADD_MONTHS (hire_date, 6) AS REVIEW, NEXT_DAY(hire_date, 'FRIDAY'), LAST_DAY(hire_date)
FROM employees WHERE MONTHS_BETWEEN (SYSDATE, hire_date) > 36;

select TRUNC(to_date('13-DEC-22'), 'YEAR') from dual;

--Funkcje konwertuj¹ce konwertuj¹ wartoœæ z jednego typu na inny
/* typy danych w Oracle:
VARCHAR2 - tekst o zmiennej d³ugoœci
CHAR - tekst o sta³ej d³ugoœci
NUMBER - dane numeryczne o zmiennej d³ugoœci
DATE - daty */
/*
YYYY     Full year in numbers
YEAR     Year spelled out 
MM      Two-digit value for month
MONTH    Full name of the month
MON      Three-letter abbreviation of the month
DY      Three-letter abbreviation of the day of the week
DAY     Full name of the day of the week
DD      Numeric day of the month
DDspth   FOURTEENTH
Ddspth   Fourteenth
ddspth      fourteenth
DDD or DD or D      Day of year, month or week
HH24:MI:SS AM   15:45:32 PM
DD "of" MONTH   12 of October
*/
--TO_CHAR(dane, 'format model')
SELECT TO_CHAR(hire_date, 'Month dd, YYYY') FROM employees;
SELECT TO_CHAR(hire_date, 'Month ddth, YYYY') FROM employees;
SELECT TO_CHAR(hire_date, 'Day ddthsp Mon, YYYY') FROM employees;
SELECT TO_CHAR(SYSDATE, 'hh:mm') FROM dual;
SELECT TO_CHAR(SYSDATE, 'hh:mm pm') FROM dual;
SELECT TO_CHAR(SYSDATE, 'hh:mm:ss pm') FROM dual;
SELECT TO_CHAR(salary, '$99,999') AS "Salary" FROM employees;

--TO_NUMBER(character string, 'format model')
SELECT TO_NUMBER('5,320', '9,999') AS "Number" FROM dual;
SELECT last_name, TO_NUMBER(bonus, '9999') AS "Bonus" FROM employees WHERE department_id = 80;

--TO_DATE('character string', 'format model')
SELECT TO_DATE('May10,1989', 'MonDD,YYYY') AS "Convert" FROM DUAL;



--Funckje polimorficzne
--CASE - odpowiednik if then 
/*
CASE expr WHEN comparison_expr1 THEN return_expr1
[WHEN comparison_expr2 THEN return_expr2
WHEN comparison_exprn THEN return_exprn
ELSE else_expr]
END*/
SELECT last_name, 
CASE department_id
WHEN 90 THEN 'Management'
WHEN 80 THEN 'Sales'
WHEN 60 THEN 'It'
ELSE 'Other dept.'
END AS "Department"
FROM employees;

select employees.*, 
case when manager_ID is NULL THEN 'Szef'
else 'Pracownik' end as struktura 
 from employees;

--DECODE - podobna funkcjonalnoœæ co CASE
/*
DECODE(columnl|expression, search1, result1 
[, search2, result2,...,]
[, default])
*/
SELECT last_name, 
DECODE(department_id, 
90, 'Management',
80, 'Sales', 
60, 'It',
'Other dept.')
AS "Department"
FROM employees;

select employees.*,
decode(manager_ID, NULL, 'Szef', 'Pracownik') as struktura
from employees;