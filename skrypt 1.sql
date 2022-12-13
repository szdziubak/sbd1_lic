/*
SQL*PLUS
cmd: u¿ytkownik/has³o@nazwa_hosta
*/

--poni¿szych komend u¿yjemy w SQL*PLUS

--SET LINESIZE - jaka bêdzie maksymalna d³ugoœæ wyœwietlanej linii - po tej d³ugoœci tekst bêdzie zawijany
SET LINESIZE 20
select * from employees;

--SET PAGESIZE --definiuje liczbe wierszy na stronie - jedna strona to nag³ówki i ustalona liczba wierszy, kolejna to nag³ówki i kolejne wiersze itd
SET PAGESIZE 30
select * from employees;


--SET ECHO ON/OFF - w³¹cza/wy³¹cza wyœwietlanie instrukcji SQL i poleceñ skryptu
SET ECHO ON
select * from employees;

SET ECHO OFF
select * from employees;

--Omówmy tabele, z których bêdziemy korzystaæ podczas zajêæ
select * from employees;
describe employees;

select * from departments;
describe departments;

