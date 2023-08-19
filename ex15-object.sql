/*
���ϸ� : ex15-object.sql

�����ͺ��̽� ��ü
    ���̺� : �⺻ ��������̸� ������ �����Ǿ��ֽ��ϴ�.
    �� : �ϳ� �̻��� ���̺� �ִ� �������� �κ� ������ �������� ��Ÿ���ϴ�.(���� ���̺�)
    ������ : �Ϸ��� ���ڸ� �ڵ����� �������ִ� ��ü�Դϴ�.
    �ε��� : ���̺��� �����Ϳ� ���� ���� �˻��� �������ִ� ���� ��ü�Դϴ�.
    ���Ǿ� : ��ü�� �ٸ� �̸��� �ο��մϴ�.
*/

-- �� ����
CREATE VIEW EMPVU80 
AS SELECT EMPLOYEE_ID, LAST_NAME, SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 80; -- DEPARTMENT_ID�� 80�� ������� ������ ������ ���̺�� ����

DESC EMPVU80;

SELECT * FROM EMPVU80;

-- alias ����Ͽ� �� ����
CREATE VIEW SALVU50
AS SELECT EMPLOYEE_ID AS ID_NUMBER, LAST_NAME NAME, SALARY*12 ANN_SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50;
    
SELECT * FROM SALVU50
WHERE ANN_SALARY >= 50000;

-- �� ����
CREATE OR REPLACE VIEW EMPVU80 -- EMPVU80���̺��� ������ ����, ������ �� �������� ����
    (ID_NUMBER, NAME, SAL, DEPARTMENT_ID) -- ��Ī�� ���� ���� �ۼ�
    AS SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME,
              SALARY, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 80;
    
SELECT * FROM EMPVU80;

UPDATE EMPVU80 
SET DEPARTMENT_ID = 90
WHERE ID_NUMBER = 145; -- �並 �����ߴ��� �信�� �ش� �����Ͱ� �������.
                       -- �䰡 �������� �ʰ� ���� EMPLOYEES ���̺��� �����Ͱ� �����Ǿ��� �����̴�.

SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID = 145;

ROLLBACK;

/*
���� �� ����
    �� �� �̻��� �⺻ ���̺� ���� ���ǵ� ��
*/
CREATE OR REPLACE VIEW DEPT_SUM_VU
    (NAME, MINSAL, MAXSAL, AVGSAL)
AS SELECT D.DEPARTMENT_NAME, MIN(E.SALARY),
          MAX(E.SALARY), AVG(E.SALARY)
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_NAME;

SELECT * FROM DEPT_SUM_VU;

/*
�� DML �۾� ���� ��Ģ
    1. ���� ������ �� ���� ���
        - �׷� �Լ��� �ִ� ���
        - GROUP BY ���� �������ִ� ���
        - DISTINCT Ű���尡 ����� ���
        - Pseudocolumn ROWNUM Ű���尡 ����� ���
    2. ���� �����͸� ������ �� ���� ���
        - �׷� �Լ��� �ִ� ���
        - GROUP BY ���� �������ִ� ���
        - DISTINCT Ű���尡 ����� ���
        - Pseudocolumn ROWNUM Ű���尡 ����� ���
        - ǥ�������� ���ǵǴ� ��(SALARY*12������)
    3. �並 ���� �����͸� �߰��� �� ���� ���    
        - �׷� �Լ��� �ִ� ���
        - GROUP BY ���� �������ִ� ���
        - DISTINCT Ű���尡 ����� ���
        - Pseudocolumn ROWNUM Ű���尡 ����� ���
        - ǥ�������� ���ǵǴ� ��(SALARY*12������)
        - �信�� ���õ��� ���� �⺻ ���̺��� NOT NULL ��
*/

-- ROWNUM : ������ ����� �� �࿡ �������� ��ȣ�� �Ҵ����ش�.
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- DML �۾��ź�
CREATE OR REPLACE VIEW EMPVU10
    (EMPLOYEE_NUMBER, EMPLOYEE_NAME, JOB_TITLE)
AS SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 10
    WITH READ ONLY; -- SELECT�� ����, UPDATE �Ұ���
    
SELECT * FROM EMPVU10;

UPDATE EMPVU10 
SET EMPLOYEE_NAME = 'Whalen1'
WHERE EMPLOYEE_NUMBER = 200; -- SQL ����: ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.

/*
WITH CHECK OPTION
    �信 ���� ������ �����۾� ����
    ���ǿ� �ش�ǰԸ� ������ ����
*/

CREATE OR REPLACE VIEW HIGH_SALARY_EMPLOYEE_VU
AS SELECT * FROM EMPLOYEES WHERE SALARY > 10000
WITH CHECK OPTION CONSTRAINT HIGH_SALARY_EMPLOYEE_CK;

SELECT * FROM HIGH_SALARY_EMPLOYEE_VU;

UPDATE HIGH_SALARY_EMPLOYEE_VU
SET SALARY = 2400
WHERE EMPLOYEE_ID = 100; -- ORA-01402: ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
                         -- ������ SALARY�� 10000 �ʰ��̱� ������ SALARY���� �� ���Ϸ� ����� �� ����.

UPDATE HIGH_SALARY_EMPLOYEE_VU
SET SALARY = 26000
WHERE EMPLOYEE_ID = 100;

-- �� ����
DROP VIEW HIGH_SALARY_EMPLOYEE_VU;

/*
������(Sequence)
    �������� ���� ���� �ڵ����� �������Ѽ� ���� �����ϴ� ��ü�Դϴ�.
    ä���� �� ���� ����Ѵ�.
*/

CREATE SEQUENCE MY_SEQ
        INCREMENT BY 1      -- ������(1�� ����)
        START WITH 1        -- ���۰�
        MINVALUE 1          -- �ּҰ�
        MAXVALUE 99999999   -- �ִ밪
        NOCYCLE             -- �ִ밪 ���޽� ���ۺ��� �ݺ� ����
        CACHE 20            -- �̸� ��ȣ�� �޸𸮿� ����
        ORDER;              -- ��û ������� ���� ����

SELECT MY_SEQ.NEXTVAL FROM DUAL; -- MY_SEQ.NEXTVAL ������ �� ���� ���ڰ� 1�� �þ

-- ���� ������ �� Ȯ��
SELECT MY_SEQ.CURRVAL FROM DUAL; -- �����ص� ���ڰ� �þ�� ����

-- ������ ����
DROP SEQUENCE MY_SEQ;

SELECT * FROM DEPT3;

INSERT INTO DEPT3 VALUES(MY_SEQ.NEXTVAL, 'A', 1, SYSDATE);
INSERT INTO DEPT3 VALUES(MY_SEQ.NEXTVAL, 'B', 2, SYSDATE);
INSERT INTO DEPT3 VALUES(MY_SEQ.NEXTVAL, 'C', 3, SYSDATE);

/*
�ε���(INDEX)
    �����ͺ��̽����� �����͸� ������ �˻��ϱ� ���� Ư�� ��(�Ǵ� ���� ����)�� 
    �����Ͽ� �����ϴ� ������, ������ ��ȸ ������ ����Ű�µ� ���˴ϴ�.

    PK - ���̺� ���� �� �ڵ����� �ε��� ������ �˴ϴ�.
*/

SELECT * FROM EMPLOYEES
WHERE LAST_NAME = 'King';

SELECT LAST_NAME, ROWID FROM EMPLOYEES
ORDER BY LAST_NAME; -- ROWID : ���� �����Ͱ� ����Ǿ��ִ� ������ �ּҰ�

-- EMPLOYEES ���̺��� LAST_NAME ���� ���� �ε��� ����
CREATE INDEX EMP_LAST_NAME_IDX
    ON EMPLOYEES(LAST_NAME);
    
-- �ε��� ����
DROP INDEX EMP_LAST_NAME_IDX;

/*
���Ǿ�(SYNONYM)
    ���Ǿ �����Ͽ� ��ü�� ��ü �̸��� �ο��� �� �ֽ��ϴ�.
*/

-- ���Ǿ� ����
CREATE SYNONYM D_SUM
FOR DEPT_SUM_VU;

SELECT * FROM DEPT_SUM_VU;

SELECT * FROM D_SUM;

-- ���Ǿ� ����
DROP SYNONYM D_SUM;

/*
ROWID : ROW ������ ���̵�
        �����ͺ��̽� ���ο��� ���� ������ ��ġ�� ��Ÿ���ϴ�.
ROWNUM : ������ ����� �� �࿡ �������� ��ȣ�� �Ҵ����ش�.
*/

SELECT ROWNUM, ROWID, EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES;

