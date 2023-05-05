--------ДЗ_6--------------

--1. Получить репорт по department_id с минимальной и максимальной зарплатой, с самой ранней и самой поздней датой прихода на работу и
--с количеством сотрудников. Сортировать по количеству сотрудников (по убыванию)
SELECT
DEPARTMENT_ID ,MAX(salary) , MIN(SALARY) , MAX(HIRE_DATE) , MIN(HIRE_DATE) , COUNT(*)
FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID
ORDER BY 6 DESC;

--2.Выведите информацию о первой букве имени сотрудника и количество имён, которые начинаются с этой буквы. Выводить строки для букв, где
--количество имён, начинающихся с неё больше 1. Сортировать по количеству.
SELECT SUBSTR(FIRST_NAME,1,1) AS letter, COUNT(*)
FROM EMPLOYEES e
GROUP BY SUBSTR(FIRST_NAME,1,1)
HAVING COUNT(*) >1
ORDER BY COUNT(*)
;

--3.Выведите id департамента, з/п и количество сотрудников, которые работают в одном и том же департаменте и получают одинаковую
--зарплату.
SELECT DEPARTMENT_ID , SALARY , COUNT(*)
FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID , SALARY ;

--4.Выведите день недели и количество сотрудников, которых приняли на работу в этот день.
SELECT TO_CHAR(HIRE_DATE,'day') , COUNT(*)
FROM EMPLOYEES e
GROUP BY TO_CHAR(HIRE_DATE,'day') ;

--5.Выведите id департаментов, в которых работает больше 30 сотрудников и сумма их з/п-т больше 300000.
SELECT DEPARTMENT_ID, COUNT(*) , SUM(SALARY)
FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)> 30 AND SUM(SALARY) >300000
;

--6.Из таблицы countries вывести все region_id, для которых сумма всех букв их стран больше 50ти.
SELECT REGION_ID , SUM( LENGTH(COUNTRY_NAME)) AS sum_letters
FROM COUNTRIES c
GROUP BY REGION_ID
HAVING SUM( LENGTH(COUNTRY_NAME)) > 50;

--7.Выведите информацию о job_id и округленную среднюю зарплату работников для каждого job_id.
SELECT JOB_ID, ROUND(AVG (SALARY)) AS middle_salary
FROM EMPLOYEES e
GROUP BY JOB_ID ;

--8.Получить список id департаментов, в которых работают сотрудники нескольких (>1) job_id.
SELECT DEPARTMENT_ID
FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID
HAVING count (DISTINCT JOB_ID)>1;

--9.Выведите информацию о department, job_id, максимальную и минимальную з/п для всех сочетаний department_id - job_id, где
--средняя з/п больше 10000.
SELECT DEPARTMENT_ID , JOB_ID , MAX(SALARY), MIN(SALARY)
FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID , JOB_ID 
HAVING AVG(salary) > 10000;

--10.Получить список manager_id, у которых средняя зарплата всех его подчиненных, не имеющих комиссионные, находится в промежутке от
--6000 до 9000.
SELECT MANAGER_ID, Round(AVG(salary) ) AS middle_salary
FROM EMPLOYEES e
WHERE COMMISSION_PCT IS NOT null
GROUP BY MANAGER_ID
HAVING Round(AVG(salary) ) BETWEEN 6000 AND 9000;

--11.Выведите округлённую до тысяч (не тысячных) максимальную зарплату среди всех средних зарплат по департаментам.
SELECT ROUND(MAX(avg(SALARY)),-3) AS round_salary
FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID ;


------ДЗ_7---------

--1.Выведите информацию о регионах и количестве сотрудников в каждом регионе.
SELECT r.REGION_NAME , COUNT(*) FROM REGIONS r LEFT JOIN COUNTRIES c ON r.REGION_ID =c.REGION_ID JOIN LOCATIONS l ON c.COUNTRY_ID =l.COUNTRY_ID JOIN DEPARTMENTS d ON l.LOCATION_ID =d.LOCATION_ID
JOIN EMPLOYEES e ON d.DEPARTMENT_ID =e.DEPARTMENT_ID
GROUP BY r.REGION_NAME ;

--2.Выведите детальную информацию о каждом сотруднике: имя, фамилия, название департамента, job_id, адрес, страна и регион.
SELECT e.FIRST_NAME , e.LAST_NAME , d.DEPARTMENT_NAME , e.JOB_ID , l.STREET_ADDRESS , c.COUNTRY_NAME , r.REGION_NAME 
FROM EMPLOYEES e LEFT outer JOIN DEPARTMENTS d ON e.DEPARTMENT_ID =d.DEPARTMENT_ID JOIN LOCATIONS l ON d.LOCATION_ID =l.LOCATION_ID
JOIN COUNTRIES c ON c.COUNTRY_ID =l.COUNTRY_ID JOIN REGIONS r ON c.REGION_ID =r.REGION_ID ;

--3.Выведите информацию о имени менеджеров которые имеют в подчинении больше 6ти сотрудников, а также выведите количество
--сотрудников, которые им подчиняются.
SELECT man.FIRST_NAME AS manager_name , COUNT(*) FROM EMPLOYEES e1 JOIN EMPLOYEES man ON e1.MANAGER_ID = man.EMPLOYEE_ID
GROUP BY man.FIRST_NAME
HAVING COUNT(*) >6 ;

--4.Выведите информацию о названии всех департаментов и о количестве работников, если в департаменте работают больше 30ти сотрудников.
--Используйте технологию «USING» для объединения по id департамента.
SELECT DEPARTMENT_NAME, COUNT(*) FROM DEPARTMENTS d JOIN EMPLOYEES e USING (DEPARTMENT_ID)
GROUP BY d.DEPARTMENT_NAME
HAVING count (*) >30;

--5.Выведите названия всех департаментов, в которых нет ни одного сотрудника.
SELECT d.DEPARTMENT_NAME FROM DEPARTMENTS d LEFT JOIN EMPLOYEES e USING (DEPARTMENT_id)
WHERE e.EMPLOYEE_ID IS null;

--6.Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2005ом году, но при это сами работники
--устроились на работу до 2005 года.
SELECT e1.* FROM EMPLOYEES e1 JOIN EMPLOYEES man ON e1.MANAGER_ID = man.EMPLOYEE_ID
WHERE TO_CHAR(man.HIRE_DATE, 'YYYY') = '2005' AND TO_CHAR(e1.HIRE_DATE, 'YYYY') < '2005';

--7.Выведите название страны и название региона этой страны, используя natural join.
SELECT c.COUNTRY_NAME , r.REGION_NAME FROM COUNTRIES c JOIN REGIONS r USING (REGION_ID);

--8.Выведите имена, фамилии и з/п сотрудников, которые получают меньше, чем (минимальная з/п по их специальности + 1000).
SELECT e.FIRST_NAME ,e.LAST_NAME , e.SALARY FROM EMPLOYEES e JOIN JOBS j ON e.JOB_ID = j.JOB_ID
WHERE e.SALARY < j.MIN_SALARY +1000;

--9.Выведите уникальные имена и фамилии сотрудников, названия стран, в которых они работают. Также выведите информацию о сотрудниках,
--о странах которых нет информации. А также выведите все страны, в которых нет сотрудников компании.
SELECT DISTINCT (e.FIRST_NAME), LAST_NAME , c.COUNTRY_NAME FROM EMPLOYEES e Full JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID FULL JOIN LOCATIONS l ON d.LOCATION_ID =l.LOCATION_ID
full JOIN COUNTRIES c ON l.COUNTRY_ID =c.COUNTRY_ID ;

--10.Выведите имена и фамилии всех сотрудников, а также названия стран, которые мы получаем при объединении работников со всеми
--странами без какой-либо логики.
SELECT e.FIRST_NAME , e.LAST_NAME , c.COUNTRY_NAME FROM EMPLOYEES e CROSS JOIN COUNTRIES c ;

--11.Выведите информацию о регионах и количестве сотрудников в каждом регионе.используя Oracle Join синтаксис.
SELECT r.REGION_NAME , COUNT(*)
FROM EMPLOYEES e , DEPARTMENTS d , LOCATIONS l , COUNTRIES c ,REGIONS r
WHERE (e.DEPARTMENT_ID=d.DEPARTMENT_ID AND d.LOCATION_ID= l.LOCATION_ID AND l.COUNTRY_ID= c.COUNTRY_ID AND c.REGION_ID= r.REGION_ID)
GROUP BY r.REGION_NAME ;

--12.Выведите названия всех департаментов, в которых нет ни одного сотрудника. используя Oracle Join синтаксис.
SELECT d.DEPARTMENT_NAME
FROM DEPARTMENTS d , EMPLOYEES e
WHERE e.DEPARTMENT_ID (+) =d.DEPARTMENT_ID and
e.EMPLOYEE_ID IS null;



-------ДЗ_8--------

--1.Выведите всю информацию о сотрудниках, с самым длинным именем.
SELECT * FROM EMPLOYEES e
WHERE LENGTH (FIRST_NAME) = (SELECT max (LENGTH(FIRST_NAME))FROM EMPLOYEES e);

--2.Выведите всю информацию о сотрудниках, с зарплатой большей средней зарплаты всех сотрудников.
SELECT * FROM EMPLOYEES e WHERE e.SALARY >
(SELECT avg (e.SALARY) FROM EMPLOYEES e );

--3.Получить город/города, где сотрудники в сумме зарабатывают меньше всего.
SELECT CITY, SUM (salary) FROM LOCATIONS l
JOIN DEPARTMENTS d ON l.LOCATION_ID =d.LOCATION_ID JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY CITY
HAVING SUM (salary)=
(SELECT min(sum (salary) ) FROM
LOCATIONS l
JOIN DEPARTMENTS d ON l.LOCATION_ID =d.LOCATION_ID JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY city);

--4.Выведите всю информацию о сотрудниках, у которых менеджер получает зарплату больше 15000.
select * FROM EMPLOYEES e WHERE MANAGER_ID in
(SELECT MANAGER_ID FROM EMPLOYEES e WHERE salary > 15000);

--5.Выведите всю информацию о департаментах, в которых нет ни одного сотрудника.
SELECT * FROM DEPARTMENTS d
WHERE DEPARTMENT_ID NOT IN (SELECT DISTINCT (DEPARTMENT_ID) FROM EMPLOYEES e WHERE DEPARTMENT_ID IS NOT null);

--6.Выведите всю информацию о сотрудниках, которые не являются менеджерами.
SELECT * FROM EMPLOYEES e
WHERE EMPLOYEE_ID NOT in
(SELECT DISTINCT (e.MANAGER_ID) FROM EMPLOYEES e WHERE MANAGER_ID IS NOT null );

--7.Выведите всю информацию о менеджерах, которые имеют в подчинении больше 6ти сотрудников.
SELECT * FROM EMPLOYEES e
WHERE
(SELECT count (*)
FROM EMPLOYEES WHERE MANAGER_ID = e.EMPLOYEE_ID ) >6 ;

--8.Выведите всю информацию о сотрудниках, которые работают в департаменте с названием IT
SELECT * FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID =d.DEPARTMENT_ID
WHERE DEPARTMENT_NAME = 'IT';
--ИЛИ
SELECT * FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID =
(SELECT DEPARTMENT_ID FROM DEPARTMENTS d
WHERE DEPARTMENT_NAME = 'IT');

--9.Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2005ом году, но при это сами работники
--устроились на работу до 2005 года.
SELECT * FROM EMPLOYEES e
WHERE TO_CHAR(HIRE_DATE, 'YYYY') < '2005'
AND MANAGER_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES e WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005');

--10.Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в январе любого года, и длина job_title этих
--сотрудников больше 15ти символов
SELECT * FROM EMPLOYEES e
where MANAGER_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES e2
WHERE TO_CHAr (HIRE_DATE, 'MM' ) = '01')
and
(select LENGTH (j.JOB_TITLE) FROM JOBS j WHERE JOB_ID=e.JOB_ID) >15;


---------ДЗ_9-----------

--1.Выведите в одном репорте информацию о суммах з/п групп,объединённых по id менеджера, по job_id, по id департамента. Репорт
--должен содержать 4 столбца: id менеджера, job_id, id департамента,суммированная з/п
SELECT e.MANAGER_ID , TO_NUMBER(null) AS dep, to_char (null) AS josb, sum (SALARY) FROM EMPLOYEES e
GROUP BY e.MANAGER_ID
UNION ALL
SELECT TO_NUMBER (null), e.DEPARTMENT_ID ,to_char (null), sum (SALARY) FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID
UNION ALL
SELECT TO_NUMBER (null) , TO_NUMBER(null), e.JOB_ID , sum (SALARY) FROM EMPLOYEES e
GROUP BY e.JOB_ID ;

--2.Выведите id тех департаментов, где работает менеджер № 100 и не работают менеджеры № 145, 201.
SELECT e.DEPARTMENT_ID FROM EMPLOYEES e
WHERE MANAGER_ID =100
minus
SELECT e.DEPARTMENT_ID FROM EMPLOYEES e
WHERE MANAGER_ID =145 or MANAGER_ID =201;

--3.Используя SET операторы и не используя логические операторы, выведите уникальную информацию о именах, фамилиях и з/п
--сотрудников, второй символ в именах которых буква «а», и фамилия содержит букву «s» вне зависимости от регистра. Отсортируйте
--результат по з/п по убыванию.
SELECT e.FIRST_NAME , e.LAST_NAME , SALARY FROM EMPLOYEES e
WHERE e.FIRST_NAME LIKE '_a%'
INTERSECT
SELECT e.FIRST_NAME , e.LAST_NAME , SALARY FROM EMPLOYEES e
WHERE UPPER( e.LAST_NAME ) LIKE '%S%'
ORDER BY SALARY DESC ;

--4.Используя SET операторы и не используя логические операторы, выведите информацию о id локаций, почтовом коде и городе для
--локаций, которые находятся в Италии или Германии. А также для локаций, почтовый код которых содержит цифру «9».
SELECT l.LOCATION_ID , l.POSTAL_CODE ,l.CITY FROM LOCATIONS l JOIN COUNTRIES c ON l.COUNTRY_ID = c.COUNTRY_ID
WHERE c.COUNTRY_id IN (SELECT c.COUNTRY_id FROM COUNTRIES c WHERE c.COUNTRY_NAME IN ( 'Italy' ,'Germany'))
UNION all
SELECT l.LOCATION_ID , l.POSTAL_CODE ,l.CITY FROM LOCATIONS l
WHERE l.POSTAL_CODE LIKE '%9%';

--5.Используя SET операторы и не используя логические операторы, выведите всю уникальную информацию для стран, длина имён
--которых больше 8 символов. А также для стран, которые находятся не в европейском регионе. Столбцы аутпута должны называться id, country,
--region. Аутпут отсортируйте по названию стран по убывающей.
SELECT c.COUNTRY_ID AS ID,c.COUNTRY_NAME AS country ,c.REGION_ID AS region FROM COUNTRIES c
WHERE LENGTH (c.COUNTRY_NAME)> 8
UNION
SELECT c.COUNTRY_ID ,c.COUNTRY_NAME ,c.REGION_ID FROM COUNTRIES c JOIN REGIONS r ON r.REGION_ID =c.REGION_ID
WHERE r.REGION_ID != (SELECT r.REGION_ID FROM REGIONS r WHERE r.REGION_NAME = 'Europe')
ORDER BY country DESC;







































