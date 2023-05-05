--1.Выведите всю информацию о регионах.
SELECT * FROM REGIONS r ;

--2. Выведите информацию о имени, id департамента, зарплате и фамилии для всех работников.
SELECT FIRST_NAME ,DEPARTMENT_ID ,SALARY , LAST_NAME FROM EMPLOYEES e ;

--3. Выведите информацию о id работника, электронной почте и дату, которая была за неделю до трудоустройства для всех работников. Столбец, который будет содержать дату назовите One week before hiredate .
SELECT EMPLOYEE_ID , EMAIL , HIRE_DATE - 7 AS One_week_before_hire_date FROM EMPLOYEES e ;

--4. Выведите информацию о работниках с их позициями в формате: Donald(SH_CLERK) . Назовите столбец our_employees .
SELECT FIRST_NAME || '(' || UPPER (JOB_ID)|| ')' AS our_employees FROM EMPLOYEES e ;

--5. Выведите список уникальных имён среди работников.
SELECT DISTINCT FIRST_NAME FROM EMPLOYEES e ;

--6. Выведите следующую информацию из таблицы jobs: 
--job_title, 
--выражение в формате: «min = 20080, max = 40000», где 20080 – это минимальная з/п, а 40000 – максимальная.
--Назовите этот столбец info.
--максимальную з/п и назовите столбец max,  новую з/п, которая будет называться new_salary и вычисляться по формуле: max_salary*2-2000.
SELECT JOB_TITLE , 'min= '|| MIN_SALARY || ', max= ' || MAX_SALARY AS info, MAX_SALARY AS max, (MAX_SALARY *2-2000) AS new_salary 
FROM jobs;

--7. Выведите на экран предложение «Peter's dog is very clever», используя одну из двух техник работы с одинарными кавычками.
select 'Peter''s dog is very clever' FROM dual;

--8. Выведите на экран предложение «Peter's dog is very clever», используя, отличную от предыдущего примера, технику работы с одинарными кавычками.
select q'<Peter's dog is very clever>' FROM dual;

--9. Выведите на экран количество минут в одном веке (1 год = 365.25 дней).
SELECT 60*24*365.5*100 FROM dual;


-------------- ДЗ-3 -------------


--1.Получите список всех сотрудников с именем David.
SELECT * FROM EMPLOYEES e WHERE FIRST_NAME = 'David';

--2. Получите список всех сотрудников, у которых job_id равен FI_ACCOUNT.
SELECT * FROM EMPLOYEES e WHERE JOB_ID = 'FI_ACCOUNT';

--3. Выведите информацию о имени, фамилии, з/п и номере департамента
--для сотрудников из 50го департамента с зарплатой, большей 4000.
SELECT FIRST_NAME ,LAST_NAME, SALARY, DEPARTMENT_ID FROM EMPLOYEES e WHERE DEPARTMENT_ID =50 AND SALARY > 4000;

--4.Получите список всех сотрудников, которые работают или в 20м, или в 30м департаменте.
SELECT * FROM EMPLOYEES e WHERE DEPARTMENT_ID IN (20,30);

--5. Получите список всех сотрудников, у которых вторая и последняя буква в имени равна 'a'.
SELECT * FROM EMPLOYEES e WHERE FIRST_NAME LIKE '_a%a';

--6. Получите список всех сотрудников из 50го и из 80го департамента, у
--которых есть бонус(комиссионные). Отсортируйте строки по email(возрастающий порядок), используя его порядковый номер.
SELECT * FROM EMPLOYEES e WHERE DEPARTMENT_ID IN (50,80) AND COMMISSION_PCT IS NOT NULL ORDER BY 4 ;

--7.Получите список всех сотрудников, у которых в имени содержатся минимум 2 буквы 'n'.
SELECT * FROM EMPLOYEES e WHERE FIRST_NAME LIKE '%n%n%' OR FIRST_NAME LIKE 'N%n%';

--8. Получить список всех сотрудников, у которых длина имени больше 4 букв. Отсортируйте строки по номеру департамента (убывающий
--порядок) так, чтобы значения “null” были в самом конце

select * FROM EMPLOYEES e WHERE LENGTH (FIRST_NAME)>4 ORDER BY DEPARTMENT_ID DESC NULLS LAST;
--или
select * FROM EMPLOYEES e WHERE FIRST_NAME LIKE '_____%' ORDER BY DEPARTMENT_ID DESC NULLS LAST;

--9. Получите список всех сотрудников, у которых зарплата находится в промежутке от 3000 до 7000 (включительно), нет бонуса
--(комиссионных) и job_id среди следующих вариантов: PU_CLERK, ST_MAN, ST_CLERK.
SELECT * FROM EMPLOYEES e WHERE SALARY > 3000 AND SALARY <= 7000 AND COMMISSION_PCT IS NULL AND JOB_ID IN ('PU_CLERK', 'ST_MAN','ST_CLERK');

--10.Получите список всех сотрудников у которых в имени содержится символ '%'.
SELECT * FROM EMPLOYEES e WHERE FIRST_NAME LIKE '%/%%' ESCAPE '/';

--11.Выведите информацию о job_id, имене и з/п для работников, рабочий id которых больше или равен 120 и job_id не равен IT_PROG.
--Отсортируйте строки по job_id (возрастающий порядок) и именам (убывающий порядок).
SELECT JOB_ID , FIRST_NAME,SALARY FROM EMPLOYEES e WHERE EMPLOYEE_ID >= 120 AND JOB_ID != 'IT_PROG'
ORDER BY JOB_ID , FIRST_NAME DESC ;


-----------ДЗ4------------

--1.Получите список всех сотрудников, у которых длина имени больше 10 букв.
SELECT * FROM EMPLOYEES e WHERE LENGTH (FIRST_NAME)>10;

--2.Получите список всех сотрудников, зарплата которых кратна 1000.
SELECT * FROM EMPLOYEES e WHERE MOD (SALARY,1000)=0;

--3.-Выведите телефонный номер и первое 3х значное число телефонного номера сотрудника, если его номер представлен в формате
--ХХХ.ХХХ.ХХХХ .
SELECT EMPLOYEE_ID , PHONE_NUMBER , Substr (PHONE_NUMBER,1,3) FROM EMPLOYEES e ;

--4.Получите список всех сотрудников, у которых последняя буква в имени равна 'm' и длина имени больше 5ти.
SELECT * FROM EMPLOYEES e WHERE FIRST_NAME LIKE '%m' AND LENGTH (FIRST_NAME)>5;

--5.Выведите дату следующей пятницы
SELECT NEXT_DAY(SYSDATE,5) FROM dual;

--6.Получите список всех сотрудников, которые работают в компании больше 12 лет и 6ти месяцев (150 месяцев).
SELECT * FROM EMPLOYEES e WHERE HIRE_DATE < ADD_MONTHS(SYSDATE,-150);

--7.Выведите телефонный номер, заменив в значении PHONE_NUMBER все '.' на '-'.
SELECT REPLACE (PHONE_NUMBER,'.','-') FROM EMPLOYEES e ;

--8.Выведите имя, email, job_id для всех работников в формате: STEVEN sking Ad_Pres
SELECT Upper (FIRST_NAME), lower (EMAIL), INITCAP(JOB_ID) FROM EMPLOYEES e ;

--9.Выведите информацию о имени работника и его з/п, не используя символ || , в таком виде: Steven24000
SELECT CONCAT(FIRST_NAME,SALARY) FROM EMPLOYEES e ;

--10.Выведите информацию о дате приёма сотрудника на работу, округлённой дате приёма на работу до месяца и первом дне года
--приёма на работу.
SELECT EMPLOYEE_ID ,HIRE_DATE , ROUND(HIRE_DATE, 'MM'), round (HIRE_DATE, 'YYYY') FROM EMPLOYEES e ;

--11.Выведите информацию о имени и фамилии всех работников. Имя должно состоять из 10 символов и если длина имени меньше 10, то
--дополняйте до 10 символов знаком $. Фамилия должна состоять из 15 символов и если длина фамилии меньше 15, то перед фамилией
--ставьте столько знаков ! сколько необходимо.
SELECT RPAD(FIRST_NAME,10, '$') , LPAD(LAST_NAME, 15, '!') FROM EMPLOYEES e ;

--12.Выведите имя сотрудника и позицию второй буквы ‘a’ в его имени.
SELECT FIRST_NAME , INSTR(FIRST_NAME,'a',1,2) FROM EMPLOYEES e ;

--13.Выведите на экран текст '!!!HELLO!! MY FRIEND!!!!!!!!' и тот же текст, но без символа восклицательный знак в начале и конце текста.
SELECT '!!!HELLO!! MY FRIEND!!!!!!!!', trim ('!' FROM '!!!HELLO!! MY FRIEND!!!!!!!!') FROM dual;

--14.Выведите информацию о:
--з/п работника,з/п умноженной на коэффициент 3.1415 ,
--округлённый до целого значения вариант увеличенной з/п-ты, целое количество тысяч из увеличенной з/п.
SELECT EMPLOYEE_ID , SALARY , SALARY *3.1415, round (SALARY *3.1415, 0), (TRUNC (SALARY *3.1415, -3))/1000 FROM EMPLOYEES e ;

--15.Выведите информацию о:
--дате приёма сотрудника на работу,
--дате, которая была через пол года, после принятия сотрудника на работу,
--дате последнего дня в месяце принятия сотрудника на работу
SELECT HIRE_DATE , ADD_MONTHS(HIRE_DATE,6), LAST_DAY(HIRE_DATE) FROM EMPLOYEES e ;


----------ДЗ5--------
--1.Выведите имя сотрудника, его з/п, а также уровень того, насколько у сотрудника хорошие условия :
SELECT FIRST_NAME , SALARY ,
CASE
WHEN salary < 10000 AND COMMISSION_PCT IS NULL THEN 'bad'
WHEN salary >= 10000 AND salary <15000 THEN 'normal'
ELSE 'good'
END AS "condition"
FROM EMPLOYEES e ;

--2.Используя функции, получите список всех сотрудников у которых в имени содержатся минимум 2 буквы 'a'.
SELECT * FROM EMPLOYEES e
WHERE INSTR(FIRST_NAME, 'a',1,2) >=1;

--3.Получите ВТОРОЕ слово из имени департамента, для техдепартаментов, у которых название состоит больше, чем из одного слова.
SELECT DEPARTMENT_NAME , SUBSTR(DEPARTMENT_NAME, INSTR(DEPARTMENT_NAME, ' ',1) ) AS VtoroeSlovo FROM DEPARTMENTS d
WHERE INSTR(DEPARTMENT_NAME, ' ',1)>=1 ;

--4.Получите имена сотрудников без первой и последней буквы в имени
SELECT FIRST_NAME , SUBSTR(FIRST_NAME,2, LENGTH(FIRST_NAME)-2)
FROM EMPLOYEES e ;

--5.Получите список всех сотрудников, у которых в значении job_id после знака '_' как минимум 3 символа, но при этом это значение после '_' не
--равно 'CLERK'.
SELECT * FROM EMPLOYEES e
WHERE JOB_ID LIKE '__?____%' ESCAPE '?' AND JOB_ID NOT like '%_CLERK%';
--ИЛИ
SELECT * FROM EMPLOYEES e
WHERE LENGTH (SUBSTR(JOB_ID, INSTR(JOB_ID, '_')+1))>=3
AND SUBSTR(JOB_ID, iNSTR(JOB_ID, '_')+1) != 'CLERK';

--6.Получите список всех сотрудников, которые пришли на работу в первый день любого месяца.
SELECT * FROM EMPLOYEES e
WHERE TO_CHAR(HIRE_DATE,'DD') = '01' ;

--7.Получите список всех сотрудников, которые пришли на работу в 2008ом году.
SELECT * FROM EMPLOYEES e
WHERE TO_CHAR(HIRE_DATE,'YYYY') = '2008';

--8.Покажите завтрашнюю дату в формате: Tomorrow is Second day of January
SELECT TO_CHAR((SYSDATE+1),'fm"tomorow is " DDspth "day of" Month') info
FROM DUAL;

--9.Выведите имя сотрудника и дату его прихода на работу в формате:21st of June, 200
SELECT FIRST_NAME , TO_char (HIRE_DATE, 'fmddth "of" Month, YYYY') AS HIRE_DATE
FROM EMPLOYEES e ;

--10.Получите список работников с увеличенными зарплатами на 20%. Зарплату показать в формате: $28,800.00
SELECT e.*, TO_CHAR (e.SALARY *1.2, '$99,999.00') FROM EMPLOYEES e ;

--11. Получить актуальную дату (нынешнюю), + секунда, + минута, + час, +день, + месяц, + год. (Всё это по отдельности прибавляется к
--актуальной дате).
SELECT SYSDATE AS now,
SYSDATE +1 / (24*60*60) as plus_SECOND,
sysdate +1 /24/60 AS plus_minute,
SYSDATE +1 /24 AS plus_hour,
SYSDATE +1 AS plus_day,
Add_months(SYSDATE,1) AS plus_month,
ADD_MONTHS(SYSDATE,12) AS plus_year
FROM dual;

--12.Выведите имя сотрудника, его з/п и новую з/п, которая равна старой плюс это значение текста «$12,345.55».
SELECT FIRST_NAME , SALARY , (SALARY + TO_NUMBER('$12,345.55', '$99,999.99')) AS new_salary FROM EMPLOYEES e ;

--13.Выведите имя сотрудника, день его трудоустройства, а такжеколичество месяцев между днём его трудоустройства и датой, которую
--необходимо получить из текста «SEP, 18:45:00 18 2009».
SELECT FIRST_NAME , HIRE_DATE ,
TRUNC (MONTHS_BETWEEN(TO_DATE('Sep, 18:45:00 18 2009', 'Mon, HH24:MI:SS DD YYYY'), HIRE_DATE),0 ) AS month_count
FROM EMPLOYEES e ;

--14.Выведите имя сотрудника, его з/п, а также полную з/п (salary +commission_pct(%)) в формате: $24,000.00 .
SELECT FIRST_NAME , SALARY , TO_CHAR (SALARY + SALARY *(NVL(COMMISSION_PCT,0)), '$999,999.99') AS full_salary
FROM EMPLOYEES e ;

--15.Выведите имя сотрудника, его фамилию, а также выражение «different length», если длина имени не равна длине фамилии
--или выражение «same length», если длина имени равна длине фамилии. Не используйте conditional functions.
SELECT FIRST_NAME , LAST_NAME,
NVL2 ( (NULLIF (LENGTH (FIRST_NAME), LENGTH (LAST_NAME))), 'diffrent_length', 'same_length' ) as equality
FROM EMPLOYEES e ;

































