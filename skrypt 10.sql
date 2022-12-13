/*Tworzenie tabeli
CREATE TABLE nazwa_tabeli (
    nazwa_kolumny_1 typ [CONSTRAINT definicja_wiêzów DEFAULT wyra¿enie domyœlne],
    nazwa_kolumny_2 typ [CONSTRAINT definicja_wiêzów DEFAULT wyra¿enie domyœlne],
)*/

CREATE TABLE employees_sa_rep (
    employee_id integer,
    first_name varchar2(30),
    last_name varchar2(32)
)

/*typy danych:
    varchar2(n)
    integer 
    number
    char
    date*/


/*wiêzy (warunki integralnoœci):
    CHECK - wartoœæ w kolumnie musi spe³niaæ okreœlony warunek,
    NOT NULL - wartoœæ w kolumnie musi byæ niepusta (not NULL),
    PRIMARY KEY - klucz g³ówny tabeli, sk³adaj¹cy siê z jednej lub wiêcej kolumn,
    FOREIGN KEY - klucz obcy tabeli,
    UNIQUE - w kolumnie musz¹ byæ sk³adowane tylko unikatowe wartoœci
*/

CREATE TABLE employees_sa_rep (
    employee_id integer PRIMARY KEY,
    first_name varchar2(30),
    last_name varchar2(32),
    salary integer CONSTRAINT check_salary CHECK (salary > 0),
    department_id number(5) CONSTRAINT fk_department_id REFERENCES departments(department_id));

--modyfikacja tabeli
ALTER TABLE nazwa tabeli ADD/MODIFY/DROP/ADD CONSTRAINT

ALTER TABLE employees_sa_rep ADD staz INTEGER DEFAULT 0; --nowa kolumna
ALTER TABLE employees_sa_rep MODIFY salary number(10); --zmiana typu
ALTER TABLE employees_sa_rep ADD CONSTRAINT last_name_check CHECK (length(last_name)>=2) --dodawanie wiêz³ów
ALTER TABLE employees_sa_rep DROP CONSTRAINT last_name_check --usuwanie wiêz³ów
ALTER TABLE employees_sa_rep DISABLE CONSTRAINT last_name_check; --wy³¹czanie wiêz³ów
ALTER TABLE employees_sa_rep ENABLE CONSTRAINT last_name_check; --w³¹czanie wiêz³ów

--usuwanie tabeli
DROP TABLE employees_sa_rep
