SELECT * FROM COUNTRIES c ;
SELECT * FROM LOCATIONS l ;
--1.Перепишите и запустите данный statemenet для создания таблицы locations2, которая будет содержать такие же столбцы, что и locations:
CREATE TABLE locations2 AS (SELECT * FROM locations WHERE 1=2);
SELECT * FROM LOCATIONS2;

--2.Добавьте в таблицу locations2 2 строки с информацией о id локации, адресе, городе, id страны. Пусть данные строки относятся к стране 
--Италия.
INSERT INTO locations2 (Location_id, STREET_ADDRESS, CITY, COUNTRY_ID)
VALUES (3300, 'Florianska 91', 'Roma','IT');
INSERT INTO locations2 (Location_id, STREET_ADDRESS, CITY, COUNTRY_ID)
VALUES (3400, 'Florianska 92', 'Florence','IT');

--3.Совершите commit.
COMMIT;

--4.Добавьте в таблицу locations2 ещё 2 строки, не используя перечисления имён столбцов, в которые заносится информация. Пусть 
--данные строки относятся к стране Франция. При написании значений, где возможно, используйте функции.
INSERT INTO locations2 
VALUES (3500,'Street1', '22007', Initcap ('paris'), Initcap ('central park') , Upper ('FR'));
INSERT INTO locations2 
VALUES (3600, 'Street2', '22008', Initcap ('paris'),Initcap ('great squere') ,Upper ('FR'));

--5.Совершите commit.
COMMIT;

--6. Добавьте в таблицу locations2 строки из таблицы locations, в которых длина значения столбца state_province больше 9.
INSERT INTO LOCATIONS2 
(SELECT * FROM LOCATIONS l WHERE LENGTH(state_province) >9);

--7.Совершите commit.
COMMIT;

--8.Перепишите и запустите данный statemenet для создания таблицы locations4europe, которая будет содержать такие же столбцы, что и 
--locations:
CREATE TABLE locations4europe AS (SELECT * FROM locations WHERE 1=2);
SELECT * FROM locations4europe;

--9.Одним statement-ом добавьте в таблицу locations2 всю информацию для всех строк из таблицы locations, а в таблицу locations4europe
--добавьте информацию о id локации, адресе, городе, id страны толькодля тех строк из таблицы locations, где города находятся в Европе.
INSERT ALL 
WHEN 1=1 THEN 
INTO LOCATIONS2 
VALUES (LOCATION_ID, STREET_ADDRESS,POSTAL_CODE,CITY,STATE_PROVINCE,COUNTRY_ID)
WHEN country_id IN 
(SELECT COUNTRY_ID FROM COUNTRIES c JOIN REGIONS r ON c.REGION_ID =r.REGION_ID  WHERE r.REGION_NAME = 'Europe' )
 then
INTO LOCATIONS4EUROPE (LOCATION_ID, STREET_ADDRESS,CITY,COUNTRY_ID)
 VALUES (LOCATION_ID, STREET_ADDRESS,CITY,COUNTRY_ID)
 SELECT * FROM LOCATIONS l ;

--10.Совершите commit.
COMMIT;
--11.В таблице locations2 измените почтовый код на любое значение в тех строках, где сейчас нет информации о почтовом коде.
UPDATE LOCATIONS2 
SET POSTAL_CODE = '11111'
WHERE POSTAL_CODE IS NULL;

--12.Совершите rollback.
ROLLBACK;

--13.В таблице locations2 измените почтовый код в тех строках, где сейчас 
--нет информации о почтовом коде. Новое значение должно быть кодом из таблицы locations для строки с id 2600.
UPDATE LOCATIONS2 
SET POSTAL_CODE =
(SELECT POSTAL_CODE FROM LOCATIONS l WHERE LOCATION_ID=2600)
 WHERE 
POSTAL_CODE IS NULL;

--14.Совершите commit.
COMMIT;

--15.Удалите строки из таблицы locations2, где id страны «IT».
DELETE FROM LOCATIONS2 l 
WHERE COUNTRY_ID = 'IT';

--16.Создайте первый savepoint.
SAVEPOINT s1;

--17.В таблице locations2 измените адрес в тех строках, где id локации больше 2500. Новое значение должно быть «Sezam st. 18»
UPDATE LOCATIONS 
SET STREET_ADDRESS = 'Sezam st. 18'
WHERE LOCATION_ID > 2500;

--18.Создайте второй savepoint.
SAVEPOINT s2;

--19.Удалите строки из таблицы locations2, где адрес равен «Sezam st. 18».
DELETE FROM LOCATIONS2 l 
WHERE STREET_ADDRESS ='Sezam st. 18';

--20.Откатите изменения до первого savepoint.
ROLLBACK TO SAVEPOINT s1;

--21.Совершите commit.
COMMIT;


-----------ДЗ_11----------
--1. Создать таблицу friends с помощью subquery так, чтобы она после создания содержала значения следующих столбцов из таблицы 
--employees: employee_id, first_name, last_name для тех строк, где имеются комиссионные. Столбцы в таблице friends должны называться 
--id, name, surname .
CREATE TABLE frinds (id, name, surname) AS 
(SELECT EMPLOYEE_ID ,FIRST_NAME , LAST_NAME  FROM EMPLOYEES e WHERE COMMISSION_PCT IS NOT null);
SELECT * FROM frinds;

--2.Добавить в таблицу friends новый столбец email .
ALTER TABLE FRINDS 
ADD (email varchar (30));

--3.Изменить столбец email так, чтобы его значение по умолчанию было «no email».
ALTER TABLE FRINDS 
MODIFY (email varchar (30) DEFAULT 'no email' );

--4.Проверить добавлением новой строки, работает ли дефолтное значение столбца email.
INSERT INTO FRINDS (id,name,surname)
VALUES (180,'Igor','Pyl');
SELECT * FROM frinds;

--5.Изменить название столбца с id на friends_id
ALTER TABLE FRINDS 
RENAME COLUMN ID TO friend_id;

--6.Удалить таблицу friends.
DROP TABLE FRINDS ;

--7.Создать таблицу friends со следующими столбцами: id, name, surname, email, salary, city, birthday. У столбцов salary и birthday должны быть 
--значения по умолчанию.
CREATE  TABLE friends (
id integer, 
name varchar2 (20), 
surname varchar2 (20),
email varchar2 (20) , 
salary number DEFAULT 5000, 
city varchar2 (20), 
birthday DATE DEFAULT (sysdate)
);

--8.Добавить 1 строку в таблицу friends со всеми значениями.
INSERT INTO FRIENDS 
VALUES (1,'Inna', 'Pup', 'innapup@tut.by', 6000, 'Minsk', to_date ('18-05-1987', 'DD-MM-YYYY'));

--9. Добавить 1 строку в таблицу friends со всеми значениями кроме salary и birthday.
INSERT INTO FRIENDS (id,name,surname, email, city)
VALUES (2, 'Igor','Pup', 'igorpup@tut.by', 'Siedlce');

--10. Совершить commit.
COMMIT;
SELECT * FROM FRIENDS f ;

--11.Удалить столбец salary.
ALTER TABLE FRIENDS 
DROP COLUMN SALARY;

--12.Сделать столбец email неиспользуемым (unused).
ALTER TABLE FRIENDS 
SET Unused COLUMN EMAIL;

--13.Сделать столбец birthday неиспользуемым (unused).
ALTER TABLE FRIENDS 
SET unused COLUMN birthday;

--14.Удалить из таблицы friends неиспользуемые столбцы
ALTER TABLE FRIENDS 
DROP unused columns;

--15.Сделать таблицу friends пригодной только для чтения.
ALTER TABLE FRIENDS 
READ ONLY;

--16.Проверить предыдущее действие любой DML командой.
INSERT INTO FRIENDS (id, name,surname,city)
VALUES (3, 'Lera','Pup','Minsk');

--17. Опустошить таблицу friends.
TRUNCATE TABLE FRIENDS ;
--НЕЛЬЗЯ Т.К. ТАБЛИЦА READ ONLY

--18. Удалить таблицу friends.
DROP TABLE FRIENDS ;


-------------------------------ДЗ_11_часть2------------------------------
--1.Создать таблицу address со следующими столбцами: id, country, city. При создании таблицы создайте на inline уровне unique constraint с 
--именем ad_id_un на столбец id.
CREATE table address (
id int CONSTRAINT ad_id_un UNIQUE ,
country varchar(20),
city varchar(20) );

--2.Создать таблицу friends со следующими столбцами: id, name, email, address_id, birthday. При создании таблицы создайте на inline уровне
--foreign key constraint на столбец address_id, который ссылается на столбец id из таблицы address, используйте опцию «on delete set null».
--Также при создании таблицы создайте на table уровне check constraintдля проверки того, что длина имени должна быть больше 3-х.
create table friends (
id int,
name_f varchar(20),
email varchar(20),
address_id int references address (id) on delete set null ,
birthday date,
check (Length (name_f)  >3 )
);

--3.Создайте уникальный индекс на столбец id из таблицы friends.
create unique index in1 on friends (id);

--4.С помощью функционала «add» команды «alter table» создайте constraint primary key с названием fr_id_pk на столбец id из таблицы 
--friends.
alter table friends add constraint fr_id_pk primary key (id);

--5.Создайте индекс с названием fr_email_in на столбец email из таблицы friends.
create index fr_email_in on friends (email);
drop index fr_email_in;
--6.С помощью функционала «modify» команды «alter table» создайте
--constraint not null с названием fr_email_nn на столбец email из таблицы friends.
alter table friends modify
(email constraint fr_email_nn  not null);

--7.Удалите таблицу friends.
drop table friends;
--8. Удалите таблицу address.
drop table address;



----------------------ДЗ_11part3------------
--1.Создать таблицу emp1000 с помощью subquery так, чтобы она после создания содержала значения следующих столбцов из таблицы 
--employees: first_name, last_name, salary, department_id.

create table emp1000 as select first_name, last_name, salary, department_id from EMPLOYEES e ;

--2.Создать view v1000 на основе select-а, который объединяет таблицы emp1000 и departments по столбцу department_id. View должен
--содержать следующие столбцы: first_name, last_name, salary, department_name, city .

CREATE VIEW v1000 
AS SELECT e.first_name, e.last_name, e.salary, d.department_name 
FROM EMP1000 e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID =e.DEPARTMENT_ID ;
