

### SQL Queries

a. **Display the employee name, department name, and project location of all employees.**
```sql
SELECT e.ENAME AS employee_name, d.DNAME AS department_name, p.PLOCATION AS project_location
FROM EMPLOYEE_132 e
JOIN DEPARTMENT_132 d ON e.DNO = d.DNO
JOIN WORK_132 w ON e.ENO = w.ENO
JOIN PROJECT_132 p ON w.PNO = p.PNO;
```

b. **Display the employee name, project name, and working hours of all employees.**
```sql
SELECT e.ENAME AS employee_name, p.PNAME AS project_name, w.WORKING_HRS AS working_hours
FROM EMPLOYEE_132 e
JOIN WORK_132 w ON e.ENO = w.ENO
JOIN PROJECT_132 p ON w.PNO = p.PNO;
```

c. **Display names of all employees who work more than 28 hours.**
```sql
SELECT e.ENAME AS employee_name
FROM EMPLOYEE_132 e
JOIN WORK_132 w ON e.ENO = w.ENO
WHERE w.WORKING_HRS > 28;
```

d. **Display the name of all employees who work in ‘Kolkata’ or ‘Mumbai’.**
```sql
SELECT e.ENAME AS employee_name
FROM EMPLOYEE_132 e
JOIN WORK_132 w ON e.ENO = w.ENO
JOIN PROJECT_132 p ON w.PNO = p.PNO
WHERE p.PLOCATION IN ('KOLKATA', 'MUMBAI');
```

e. **Display the name of the employee who works in the same location as that of ‘Shyamal’.**
```sql
SELECT e1.ENAME AS employee_name
FROM EMPLOYEE_132 e1
JOIN WORK_132 w1 ON e1.ENO = w1.ENO
JOIN PROJECT_132 p1 ON w1.PNO = p1.PNO
WHERE p1.PLOCATION = (
    SELECT p2.PLOCATION
    FROM EMPLOYEE_132 e2
    JOIN WORK_132 w2 ON e2.ENO = w2.ENO
    JOIN PROJECT_132 p2 ON w2.PNO = p2.PNO
    WHERE e2.ENAME = 'SHYAMAL'
);
```

f. **List the names of employees who are working on more than one project.**
```sql
SELECT e.ENAME AS employee_name
FROM EMPLOYEE_132 e
JOIN WORK_132 w ON e.ENO = w.ENO
GROUP BY e.ENAME
HAVING COUNT(DISTINCT w.PNO) > 1;
```

g. **Write a query to select the first two rows from the employee table.**
```sql
SELECT *
FROM EMPLOYEE_132
WHERE ROWNUM <= 2;
```

h. **Write a query to select the last two rows from the employee table.**
```sql
SELECT *
FROM (
    SELECT *
    FROM EMPLOYEE_132
    ORDER BY ENO DESC
)
WHERE ROWNUM <= 2
ORDER BY ENO ASC;
```

i. **Retrieve the maximum and minimum salary for each department.**
```sql
SELECT d.DNAME AS department_name, MAX(e.SALARY) AS max_salary, MIN(e.SALARY) AS min_salary
FROM EMPLOYEE_132 e
JOIN DEPARTMENT_132 d ON e.DNO = d.DNO
GROUP BY d.DNAME;
```

j. **Display the employee name and their respective manager's name.**
```sql
SELECT e.ENAME AS employee_name, m.ENAME AS manager_name
FROM EMPLOYEE_132 e
LEFT JOIN EMPLOYEE_132 m ON e.MANAGER_NO = m.ENO;
```

k. **Display the name of the employee who is earning the second maximum salary.**
```sql
SELECT ENAME
FROM EMPLOYEE_132
WHERE SALARY = (
    SELECT MAX(SALARY)
    FROM EMPLOYEE_132
    WHERE SALARY < (SELECT MAX(SALARY) FROM EMPLOYEE_132)
);
```

l. **Display the name of the employee who is earning the nth highest salary.**
```sql
SELECT ENAME
FROM EMPLOYEE_132
WHERE SALARY = (
    SELECT DISTINCT SALARY
    FROM EMPLOYEE_132
    ORDER BY SALARY DESC
    OFFSET n-1 ROWS FETCH NEXT 1 ROWS ONLY
);
```

m. **Display the names of the employees whose salary is greater than the salary of all the employees whose manager number is 2.**
```sql
SELECT e.ENAME
FROM EMPLOYEE_132 e
WHERE e.SALARY > ALL (
    SELECT e2.SALARY
    FROM EMPLOYEE_132 e2
    WHERE e2.MANAGER_NO = 2
);
```

n. **Get the details of all employees whose salary is lesser than the average salary of the employees.**
```sql
SELECT *
FROM EMPLOYEE_132
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEE_132);
```

o. **Drop the primary key from the Work table.**
```sql
ALTER TABLE WORK_132 DROP PRIMARY KEY;
```

p. **Insert two duplicate rows in the Work table.**
```sql
INSERT INTO WORK_132 (ENO, PNO, WORKING_HRS)
SELECT ENO, PNO, WORKING_HRS
FROM WORK_132
WHERE ROWNUM <= 1; -- Adjust as necessary to select the desired row
```

q. **Delete duplicate rows from the Work table.**
```sql
DELETE FROM WORK_132
WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM WORK_132
    GROUP BY ENO, PNO, WORKING_HRS
);
```

r. **Create a view that will show department name and total salary. The name of the view will be account.**
```sql
CREATE VIEW account AS
SELECT d.DNAME AS department_name, SUM(e.SALARY) AS total_salary
FROM EMPLOYEE_132 e
JOIN DEPARTMENT_132 d ON e.DNO = d.DNO
GROUP BY d.DNAME;
```

s. **Select the department names having total salary greater than 45000.**
i) **Using result view**
```sql
SELECT department_name
FROM account
WHERE total_salary > 45000;
```
ii) **Using the employee table.**
```sql
SELECT d.DNAME AS department_name
FROM EMPLOYEE_132 e
JOIN DEPARTMENT_132 d ON e.DNO = d.DNO
GROUP BY d.DNAME
HAVING SUM(e.SALARY) > 45000;
```

t. **Write a query to retrieve Employee names from the Employee table and output will look like: Mr. A.**
```sql
SELECT 'Mr. ' || ENAME AS formatted_name
FROM EMPLOYEE_132;
```
