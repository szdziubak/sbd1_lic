--Transakcje
/*
Wspó³bie¿noœæ - jednoczeœnie mog¹ byæ dokonywane wiele odczytów i zapisów.
ACID:
A - Atomowoœæ - transakcje s¹ niepodzielne, albo wykonywane s¹ wszystkie operacje w ramach transakcji albo ¿adna.
C - Spójnoœæ - stan bazy przed i po operacji powinien byæ spójny - poprawny, wszystkie warunki na³o¿one na bazê danych musz¹ byæ spe³nione.
I - Izolacja - transakcje nie powinny wzajemnie przeszkadzaæ sobie w dzia³aniu. 
D - Trwa³oœæ - niepodatnoœæ na awarie.
Transakcja to ci¹g operacji do wspólnego niepodzielnego wykonania.
*/
--wszystkie operacje DML (Insert, Update, Delete) maj¹ niejawny COMMIT, poniewa¿ ka¿da operacja musi zostaæ zatwierdzona - transakcje domyœlne

--Przyk³ad transakcji - wykonywanie przelewu
COMMIT; --zatwierdŸ transakcjê
ROLLBACK; --wycofaj transakcjê
SAVEPOINT savepoint1; --punkty zachowania
ROLLBACK TO SAVEPOINT savepoint1; --wycofujemy transakcje do okreœlonego momentu

CREATE TABLE copy_employees
AS (SELECT * FROM employees); 


--przyk³ad transakcji:
select * from copy_employees;
UPDATE copy_employees set salary = salary*1.2;
select * from copy_employees;
SAVEPOINT save1;
UPDATE copy_employees set salary = salary*1.1;
select * from copy_employees;
ROLLBACK TO SAVEPOINT save1;
select * from copy_employees;
ROLLBACK; --wycofuje ca³¹ transakcje
select * from copy_employees;

drop table copy_employees;

--wiêcej np. tutaj: https://mst.mimuw.edu.pl/lecture.php?lecture=bad&part=Ch7