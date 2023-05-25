/*Perspektywy:
Nie przechowuj¹ danych, przechowuj¹ zapytanie
Pozwalaj¹ na ukrycie zaawansowanego kodu pod perspektyw¹
Umo¿liwiaj¹ dostêp tylko do wybranych danych */

--CREATE OR REPLACE VIEW nazwa_perspektywy 
--AS podzapytanie

CREATE VIEW employees_view AS
select employee_id, manager_id, first_name, last_name from employees; 


CREATE VIEW pracownicy_departamenty AS
select department_name nazwa_departamentu, count(*) liczba_pracownikow 
from departments d inner join employees e 
on d.department_id = e.department_id 
group by department_name order by 2 desc;

create view pracownicy (nazwisko,pensja_roczna,data_zatr) --nazwy kolumn w perspektywie
as select last_name,salary*12,hire_date
from employees where salary<10000;

/*select * from dict where lower(table_name) like '%view%';

select * from user_views;

describe pracownicy;

create or replace view pracownicy (nazwisko,pensja_roczna,data_zatr) --nazwy kolumn w perspektywie
as select last_name,salary*12,hire_date
from employees where salary<12000; --modyfikacja widoku
*/
drop view employees_view;
drop view pracownicy;
drop view pracownicy_departamenty;
