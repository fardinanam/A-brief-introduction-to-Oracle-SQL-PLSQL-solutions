(SELECT FIRST_NAME, LAST_NAME K_NAME FROM EMPLOYEES WHERE LAST_NAME like 'K%')
MINUS
(SELECT FIRST_NAME, LAST_NAME K_NAME FROM EMPLOYEES WHERE FIRST_NAME like 'S%');

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE 'K%' 
AND FIRST_NAME NOT IN
	(SELECT FIRST_NAME
	 FROM EMPLOYEES
	 WHERE FIRST_NAME like 'S%');

SELECT MAX(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 
	(SELECT DISTINCT JOB_ID
		FROM JOBS
		WHERE JOB_TITLE = 'Accountant');
	 
 SELECT LAST_NAME, SALARY
 FROM EMPLOYEES 
 WHERE SALARY > ALL
	(SELECT SALARY
	FROM EMPLOYEES
	WHERE JOB_ID = 
		(SELECT DISTINCT JOB_ID
		FROM JOBS
		WHERE JOB_TITLE = 'Accountant'));
		
SELECT FIRST_NAME || ' ' || LAST_NAME AS name 
FROM EMPLOYEES
WHERE SALARY = 
	(SELECT MAX(SALARY)
	FROM EMPLOYEES);
	
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) >= ALL(SELECT AVG(SALARY)
												FROM EMPLOYEES
												GROUP BY JOB_ID);

SELECT FIRST_NAME || ' ' || LAST_NAME AS name, JOB_ID 
FROM EMPLOYEES S
WHERE SALARY > 
	(SELECT AVG(SALARY)
	FROM EMPLOYEES T
	WHERE S.JOB_ID = T.JOB_ID);
	
SELECT JOB_ID, avg_salary
FROM (SELECT JOB_ID, avg(SALARY) avg_salary
			FROM EMPLOYEES
			GROUP BY JOB_ID) AS job_avg(JOB_ID, avg_salary)
WHERE AVG(SALARY) >= 9000;

SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE JOB_ID <> 'IT_PROG'
AND SALARY < ANY (SELECT SALARY
									FROM EMPLOYEES
									WHERE JOB_ID <> 'IT_PROG'
									);