--a
SELECT LAST_NAME, SALARY
FROM EMPLOYEES E1
WHERE (SELECT COUNT(*)
			 FROM EMPLOYEES E2
			 WHERE E1.SALARY > E2.SALARY) 
			 >= 3;
	
--b	
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS	
WHERE DEPARTMENT_ID 
IN (SELECT DEPARTMENT_ID
		FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID
		HAVING AVG(SALARY) > ALL (SELECT MIN(SALARY)
															FROM EMPLOYEES
															GROUP BY DEPARTMENT_ID));
--b alternate
SELECT DEPARTMENT_NAME
FROM (SELECT DEPARTMENT_NAME, SALARY, DEPARTMENT_ID
			FROM EMPLOYEES JOIN DEPARTMENTS USING(DEPARTMENT_ID))
GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME
HAVING AVG(SALARY) > ALL(SELECT MIN(SALARY)
												FROM EMPLOYEES
												GROUP BY DEPARTMENT_ID);															
--c
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
												FROM EMPLOYEES E1
												GROUP BY E1.DEPARTMENT_ID
												HAVING COUNT(EMPLOYEE_ID) = (SELECT MAX(NOOFEMP)
																										 FROM (SELECT COUNT(EMPLOYEE_ID) NOOFEMP
																													 FROM EMPLOYEES E2
																													 GROUP BY DEPARTMENT_ID)));
--c alternate
SELECT DEPARTMENT_NAME
FROM (SELECT DEPARTMENT_NAME, DEPARTMENT_ID, EMPLOYEE_ID
			FROM EMPLOYEES JOIN DEPARTMENTS USING(DEPARTMENT_ID))
GROUP BY DEPARTMENT_ID, DEPARTMENT_NAME
HAVING COUNT(EMPLOYEE_ID) = (SELECT MAX(NOOFEMP)
														 FROM (SELECT COUNT(EMPLOYEE_ID) NOOFEMP
																	 FROM EMPLOYEES E2
																	 GROUP BY DEPARTMENT_ID));
--d
SELECT LAST_NAME
FROM (SELECT LAST_NAME, EMPLOYEE_ID
			FROM JOB_HISTORY JOIN EMPLOYEES
			USING(EMPLOYEE_ID))
GROUP BY EMPLOYEE_ID, LAST_NAME
HAVING COUNT(EMPLOYEE_ID) > 1;
--e
SELECT E1.LAST_NAME, D.MIN_SALARY, D.MAX_SALARY
FROM EMPLOYEES E1, (SELECT DEPARTMENT_ID, MIN(SALARY) MIN_SALARY, MAX(SALARY) MAX_SALARY
										FROM EMPLOYEES
										GROUP BY DEPARTMENT_ID) D
WHERE E1.DEPARTMENT_ID = D.DEPARTMENT_ID;
--f
SELECT LAST_NAME
FROM EMPLOYEES E1
WHERE SALARY = (SELECT MAX(SALARY)
								FROM EMPLOYEES E2
								WHERE E1.JOB_ID = E2.JOB_ID);