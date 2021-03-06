--a
SELECT LAST_NAME, SALARY, JOB_TITLE
FROM EMPLOYEES JOIN JOBS USING(JOB_ID);
--b
SELECT DEPARTMENT_NAME, COUNTRY_NAME
FROM DEPARTMENTS JOIN LOCATIONS
USING (LOCATION_ID)
JOIN COUNTRIES
USING (COUNTRY_ID);
--c
SELECT C.COUNTRY_NAME, COUNT(D.DEPARTMENT_ID) TOTAL_DEPARTMENTS
FROM COUNTRIES C LEFT JOIN LOCATIONS L ON(L.COUNTRY_ID = C.COUNTRY_ID) 
LEFT JOIN DEPARTMENTS D ON(D.LOCATION_ID = L.LOCATION_ID)
GROUP BY C.COUNTRY_ID, C.COUNTRY_NAME
ORDER BY TOTAL_DEPARTMENTS DESC;
--d
SELECT E.LAST_NAME, COUNT(JH.JOB_ID) TOTAL
FROM EMPLOYEES E LEFT JOIN JOB_HISTORY JH ON(JH.EMPLOYEE_ID = E.EMPLOYEE_ID)
GROUP BY E.EMPLOYEE_ID, E.LAST_NAME
ORDER BY TOTAL DESC;
--e
SELECT D.DEPARTMENT_NAME, J.JOB_TITLE, COUNT(E1.EMPLOYEE_ID) TOTAL
FROM (DEPARTMENTS D JOIN EMPLOYEES E1 ON(D.DEPARTMENT_ID = E1.DEPARTMENT_ID))
LEFT JOIN (JOBS J JOIN EMPLOYEES E2 ON(J.JOB_ID = E2.JOB_ID)) ON(E1.EMPLOYEE_ID = E2.EMPLOYEE_ID)
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME, J.JOB_ID, J.JOB_TITLE
ORDER BY TOTAL DESC;
--e ALTERNATIVE
SELECT D.DEPARTMENT_NAME, J.JOB_TITLE, COUNT(E1.EMPLOYEE_ID) TOTAL
FROM (DEPARTMENTS D LEFT JOIN EMPLOYEES E1 ON(D.DEPARTMENT_ID = E1.DEPARTMENT_ID)),
(JOBS J LEFT JOIN EMPLOYEES E2 ON(J.JOB_ID = E2.JOB_ID))
WHERE E1.EMPLOYEE_ID = E2.EMPLOYEE_ID OR E1.EMPLOYEE_ID IS NULL
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME, J.JOB_ID, J.JOB_TITLE
ORDER BY TOTAL DESC;
--f
SELECT E1.LAST_NAME, COUNT(E2.EMPLOYEE_ID) TOTAL
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2
ON(E1.HIRE_DATE < E2.HIRE_DATE)
GROUP BY E1.EMPLOYEE_ID, E1.LAST_NAME
ORDER BY TOTAL DESC;
--g
SELECT E1.LAST_NAME, COUNT(DISTINCT E2.EMPLOYEE_ID) TOTAL_BEFORE, COUNT(DISTINCT E3.EMPLOYEE_ID) TOTAL_AFTER
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2
ON(E1.HIRE_DATE < E2.HIRE_DATE) LEFT JOIN EMPLOYEES E3
ON(E1.HIRE_DATE > E3.HIRE_DATE)
GROUP BY E1.EMPLOYEE_ID, E1.LAST_NAME
ORDER BY TOTAL_BEFORE ASC, TOTAL_AFTER ASC;
--h
SELECT E1.LAST_NAME, COUNT(E2.EMPLOYEE_ID) TOTAL
FROM EMPLOYEES E1 JOIN EMPLOYEES E2
ON(E1.SALARY > E2.SALARY)
GROUP BY E1.EMPLOYEE_ID, E1.LAST_NAME
HAVING COUNT(E2.EMPLOYEE_ID) >= 3
ORDER BY TOTAL;
--i
SELECT E1.LAST_NAME, (COUNT(E2.EMPLOYEE_ID) + 1) RANK
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2
ON (E1.SALARY < E2.SALARY)
GROUP BY E1.EMPLOYEE_ID, E1.LAST_NAME
ORDER BY RANK ASC;
--j
SELECT DISTINCT E1.LAST_NAME, E1.SALARY
FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2
ON (E1.SALARY < E2.SALARY)
GROUP BY E1.EMPLOYEE_ID, E1.LAST_NAME, E1.SALARY
HAVING COUNT(DISTINCT E2.SALARY) < 3
ORDER BY E1.SALARY DESC;