-- 1. Create AUDIT table for tracking deletions and updates on EMPLOYEE_132
CREATE TABLE AUDIT (
    EMP_NO NUMBER(2),
    NAME VARCHAR2(15),
    DEPT_NO NUMBER(2),
    OPERATION VARCHAR2(10),
    USER_ID VARCHAR2(30),
    OP_DATE DATE
);

-- 2. Create trigger on EMPLOYEE_132 to audit DELETE and UPDATE operations
CREATE OR REPLACE TRIGGER trg_audit_employee_132
BEFORE DELETE OR UPDATE ON EMPLOYEE_132
FOR EACH ROW
BEGIN
    INSERT INTO AUDIT (EMP_NO, NAME, DEPT_NO, OPERATION, USER_ID, OP_DATE)
    VALUES (
        :OLD.ENO,
        :OLD.ENAME,
        :OLD.DNO,
        CASE
            WHEN DELETING THEN 'DELETE'
            WHEN UPDATING THEN 'UPDATE'
        END,
        USER,
        SYSDATE
    );
END;
/

-- 3. Create a new user with password and default profile limits
-- Connect as admin user (e.g., SYSTEM) before running below:
CREATE USER employee_user_132 IDENTIFIED BY StrongPassword123
PROFILE DEFAULT;

-- 4. Grant Connect role with admin option
GRANT CONNECT TO employee_user_132 WITH ADMIN OPTION;

-- 5. Grant Resource role and necessary system privileges
GRANT RESOURCE TO employee_user_132;
GRANT CREATE TABLE TO employee_user_132;
GRANT CREATE VIEW TO employee_user_132;
GRANT CREATE PROCEDURE TO employee_user_132;
GRANT CREATE SEQUENCE TO employee_user_132;
GRANT CREATE TRIGGER TO employee_user_132;
GRANT ALTER ANY TABLE TO employee_user_132;
GRANT INSERT ANY TABLE TO employee_user_132;
GRANT DELETE ANY TABLE TO employee_user_132;
GRANT UPDATE ANY TABLE TO employee_user_132;
GRANT SELECT ANY TABLE TO employee_user_132;
GRANT GRANT ANY PRIVILEGE TO employee_user_132;

-- 6. Connect as the new user (run outside this script in sqlplus or SQL Developer):
-- CONNECT employee_user_132/StrongPassword123;

-- 7. Create Employee table under the new user schema
CREATE TABLE Employee (
    Eno NUMBER(2) PRIMARY KEY,
    EName VARCHAR2(15)
);

-- 8. Insert 3 records into Employee table
INSERT INTO Employee (Eno, EName) VALUES (1, 'Alice');
INSERT INTO Employee (Eno, EName) VALUES (2, 'Bob');
INSERT INTO Employee (Eno, EName) VALUES (3, 'Carol');

COMMIT;

-- 9. Create a unique index on column Eno in Employee table
CREATE UNIQUE INDEX idx_employee_eno ON Employee(Eno);
