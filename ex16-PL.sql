/*
���ϸ� : ex16-PL.sql

PL/SQL(Procedual Language extension to SQL)
    SQL�� Ȯ���� ������ ��� �Դϴ�.
    ���� SQL�� �ϳ��� ���(block)���� �����Ͽ� SQL�� ������ �� �ֽ��ϴ�.
    
���ν���(Procedure)
    �����ͺ��̽����� ���డ���� �ϳ� �̻��� SQL���� ��� 
    �ϳ��� ���� �۾������� ���� �����ͺ��̽� ��ü�Դϴ�.
    ���� ���� ��ɹ��� �Ѳ����� �����ؾ��� �� ���� ����մϴ�.
*/

/*
�͸� ���ν��� -- ��ȸ�� ���ν���. DB�� ������� �ʽ��ϴ�.
[�⺻����]
    DECLARE - ��������
    BEGIN - ó�� ���� ����
    EXCEPTION - ����ó��
    END - ó�� ���� ����
*/

-- �������� ����ϵ��� ����
SET SERVEROUTPUT ON;

-- ��ũ��Ʈ ��� �ð��� ����ϵ��� ����
SET TIMING ON;

DECLARE -- ���� ����
    V_STRD_DT       VARCHAR2(8);
    V_STRD_DEPTNO   NUMBER;
    V_DEPTNO        NUMBER;
    V_DNAME         VARCHAR2(50);
    V_LOC           VARCHAR2(50);
    V_RESULT_MSG    VARCHAR2(500) DEFAULT 'SUCCESS';
BEGIN -- ���� ����
    V_STRD_DT := TO_CHAR(SYSDATE, 'YYYYMMDD');
    V_STRD_DEPTNO := 10;

    SELECT T1.department_id
         , T1.department_name
         , T1.location_id
      INTO V_DEPTNO
         , V_DNAME
         , V_LOC
      FROM departments T1
     WHERE T1.department_id = V_STRD_DEPTNO;

    --��ȸ ��� ���� ����
    V_RESULT_MSG := 'RESULT > DEPTNO='||V_DEPTNO||', DNAME='||V_DNAME||', LOC='||V_LOC;
    --��ȸ ��� ���
    DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
EXCEPTION --���� ó��
    WHEN VALUE_ERROR THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], VALUE_ERROR_MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
    WHEN OTHERS THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
END;
/
-- �۾�����

/*
���ν���
[�⺻����]
CREATE OR REPLACE PRECEDURE ���ν��� �̸� (�Ķ����1, �Ķ����2 ...)
    IS �Ǵ� AS
        [�����]
    BEGIN
        [�����]
    [EXCEPTION]
        [EXCEPTION ó��]
    END;
    /
���ȣ �κ��� ���� ����
*/

CREATE OR REPLACE PROCEDURE PRINT_HELLO_PROC -- �Ű������� ������ () ���� ����
    IS -- ���ν��� ����
        MSG VARCHAR2(20) := 'hello world'; -- ���� �ʱⰪ ����
    BEGIN -- ���๮ ����
        DBMS_OUTPUT.PUT_LINE(MSG);
    END; 
/

EXEC PRINT_HELLO_PROC; -- EXEC : ���ν��� ���� Ű����

/*
IN �Ű�����
    ���� ���ν��� ������ ��
*/

CREATE TABLE EMP2 AS
SELECT EMPLOYEE_ID EMPNO, LAST_NAME NAME, SALARY, DEPARTMENT_ID DEPNO
FROM EMPLOYEES;

SELECT * FROM EMP2;

CREATE OR REPLACE PROCEDURE UPDATE_EMP_SALARY_PROC(eno IN NUMBER)
    IS 
    BEGIN
        UPDATE EMP2 SET 
        SALARY = SALARY * 1.1
        WHERE EMPNO = eno;
        COMMIT;
    END;
/
-- DML���� ���� �� Ŀ���� �ݵ�� ����� �Ѵ�.

SELECT * FROM EMP2
WHERE EMPNO = 115; -- SALARY 3100

EXEC UPDATE_EMP_SALARY_PROC(115); -- �����ϴϱ� SALARY 3410

/*
OUT �Ű�����
    ���ν����� ��ȯ���� �����Ƿ� OUT �Ű������� ���� ���� �� �ִ�.
    ������ �Ű������� ���
*/
CREATE OR REPLACE PROCEDURE find_emp_proc(v_eno IN NUMBER,
        v_fname OUT NVARCHAR2, v_lname OUT NVARCHAR2, v_sal OUT NUMBER)
IS 
    BEGIN
        SELECT first_name, last_name, salary
        INTO v_fname, v_lname, v_sal
        FROM employees WHERE employee_id = v_eno;
    END;
/
-- VARCHAR2(����Ʈ) NVARCHAR2(���ڱ���) ����
VARIABLE v_fname NVARCHAR2(25);
VARIABLE v_lname NVARCHAR2(25);
VARIABLE v_sal NUMBER;

EXECUTE find_emp_proc(115, :v_fname, :v_lname, :v_sal);
PRINT v_fname;
PRINT v_lname;
PRINT v_sal;

/*
IN OUT �Ű�����
    IN OUT ���ÿ� ����� �� �ִ� �Ű����� �Դϴ�.
*/

CREATE OR REPLACE PROCEDURE FIND_SAL(V_IO IN OUT NUMBER)
IS 
    BEGIN
    SELECT SALARY
    INTO V_IO
    FROM EMPLOYEES WHERE EMPLOYEE_ID = V_IO;
    END;
/

DECLARE
    V_IO NUMBER := 115;
    BEGIN
    DBMS_OUTPUT.PUT_LINE('ENO='||V_IO);
    FIND_SAL(V_IO);
    DBMS_OUTPUT.PUT_LINE('SALARY='||V_IO);
    END;
/

VAR V_IO NUMBER;
EXEC :V_IO := 115;
PRINT V_IO;
EXEC FIND_SAL(:V_IO);
PRINT V_IO;

/*
�Լ�(Function)
    Ư�� ��ɵ��� ���ȭ, ������ �� �ְ� ������ �������� �����ϰ� ���� �� �ֽ��ϴ�.
    RETURN���� ������ �������� ���� ����� �� �ֽ��ϴ�.
[�⺻����]
CREATE OR REPLACE FUNCTION �Լ��̸� (�Ķ����1, �Ķ����2 ...)
RETURN datatype - ��ȯ�Ǵ� ���� ����
    IS �Ǵ� AS - �����
    BEGIN
        [����� - PL/SQL ��]
    [EXCEPTION]
        [EXCEPTION ó��]
    RETURN ����;
    END;
/
*/
CREATE OR REPLACE FUNCTION FN_GET_DEPT_NAME(P_DEPT_NO NUMBER)
RETURN VARCHAR2
    IS
        V_TEST_NAME VARCHAR2(30);
    BEGIN
        SELECT DEPARTMENT_NAME
        INTO   V_TEST_NAME
        FROM   DEPARTMENTS
        WHERE  DEPARTMENT_ID = P_DEPT_NO;
        
    RETURN V_TEST_NAME;
    END;
/

SELECT FN_GET_DEPT_NAME(10) FROM DUAL;