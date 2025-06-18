Here are the PL/SQL programs and functions to accomplish the tasks you've outlined:

### 1. Check if a Number is Even or Odd
```sql
DECLARE
    num NUMBER := 10; -- Change this number to test
BEGIN
    IF MOD(num, 2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is Even.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(num || ' is Odd.');
    END IF;
END;
/
```

### 2. Check if a Number is Prime
```sql
DECLARE
    num NUMBER := 29; -- Change this number to test
    is_prime BOOLEAN := TRUE;
BEGIN
    IF num < 2 THEN
        is_prime := FALSE;
    ELSE
        FOR i IN 2..FLOOR(SQRT(num)) LOOP
            IF MOD(num, i) = 0 THEN
                is_prime := FALSE;
                EXIT;
            END IF;
        END LOOP;
    END IF;

    IF is_prime THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is Prime.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(num || ' is Not Prime.');
    END IF;
END;
/
```

### 3. Check if a Number is an Armstrong Number
```sql
DECLARE
    num NUMBER := 153; -- Change this number to test
    sum NUMBER := 0;
    temp NUMBER := num;
    digit_count NUMBER := LENGTH(num);
BEGIN
    WHILE temp > 0 LOOP
        sum := sum + POWER(MOD(temp, 10), digit_count);
        temp := FLOOR(temp / 10);
    END LOOP;

    IF sum = num THEN
        DBMS_OUTPUT.PUT_LINE(num || ' is an Armstrong Number.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(num || ' is Not an Armstrong Number.');
    END IF;
END;
/
```

### 4. Calculate Net Salary of an Employee
```sql
DECLARE
    emp_no NUMBER := 1; -- Change this to the employee number you want to check
    salary NUMBER;
    da NUMBER;
    hra NUMBER;
    net_salary NUMBER;
BEGIN
    SELECT SALARY INTO salary FROM EMPLOYEE_132 WHERE ENO = emp_no;

    IF salary IS NOT NULL THEN
        da := salary * 0.50;
        hra := salary * 0.15;
        net_salary := salary + da + hra;
        DBMS_OUTPUT.PUT_LINE('Net Salary of Employee ' || emp_no || ' is: ' || net_salary);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee not found.');
    END IF;
END;
/
```

### 5. Calculate Area of a Circle and Store in Table
```sql
CREATE TABLE CIRCLE (
    RADIUS NUMBER,
    AREA NUMBER,
    DIAMETER NUMBER
);

DECLARE
    radius NUMBER;
    area NUMBER;
BEGIN
    FOR radius IN 3..7 LOOP
        area := 3.14 * radius * radius;
        INSERT INTO CIRCLE (RADIUS, AREA) VALUES (radius, area);
    END LOOP;
    COMMIT;
END;
/

-- Update Diameter Column
UPDATE CIRCLE SET DIAMETER = 2 * RADIUS;
COMMIT;

-- Print Number of Records Using Explicit Cursor
DECLARE
    CURSOR c_circle IS SELECT * FROM CIRCLE;
    record_count NUMBER := 0;
BEGIN
    FOR rec IN c_circle LOOP
        record_count := record_count + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Number of records in CIRCLE table: ' || record_count);
END;
/
```

### 6. Function to Return Maximum of Three Numbers
```sql
CREATE OR REPLACE FUNCTION max_of_three(a NUMBER, b NUMBER, c NUMBER) RETURN NUMBER IS
BEGIN
    RETURN GREATEST(a, b, c);
END;
/
```

### 7. Function to Return Net Salary of an Employee
```sql
CREATE OR REPLACE FUNCTION get_net_salary(emp_no NUMBER) RETURN NUMBER IS
    salary NUMBER;
    da NUMBER;
    hra NUMBER;
    net_salary NUMBER;
BEGIN
    SELECT SALARY INTO salary FROM EMPLOYEE_132 WHERE ENO = emp_no;

    IF salary IS NOT NULL THEN
        da := salary * 0.50;
        hra := salary * 0.15;
        net_salary := salary + da + hra;
        RETURN net_salary;
    ELSE
        RETURN -1; -- Return -1 if employee not found
    END IF;
END;
/
```

### 8. Procedure to Calculate Sum of Two Numbers
```sql
CREATE OR REPLACE PROCEDURE sum_of_two_numbers(a NUMBER, b NUMBER) IS
    total NUMBER;
BEGIN
    total := a + b;
    DBMS_OUTPUT.PUT_LINE('Sum of ' || a || ' and ' || b || ' is: ' || total);
END;
/
```

### 9. Procedure to Return Net Salary and Department of an Employee
```sql
CREATE OR REPLACE PROCEDURE get_net_salary_and_dept(emp_no NUMBER) IS
    salary NUMBER;
    da NUMBER;
    hra NUMBER;
    net_salary NUMBER;
    dept_no NUMBER;
BEGIN
    SELECT SALARY, DNO INTO salary, dept_no FROM EMPLOYEE_132 WHERE ENO = emp_no;

    IF salary IS NOT NULL THEN
        da := salary * 0.50;
        hra := salary * 0.15;
        net_salary := salary + da + hra;
        DBMS_OUTPUT.PUT_LINE('Net Salary of Employee ' || emp_no || ' is: ' || net_salary);
        DBMS_OUTPUT.PUT_LINE('Department Number: ' || dept_no);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee not found.');
    END IF;
END;
/
```

### Summary
- The above PL/SQL blocks and functions cover the requirements you specified.
- Make sure to execute these blocks in an Oracle database environment where you have the necessary privileges.
- Use `DBMS_OUTPUT.PUT_LINE` to print output
