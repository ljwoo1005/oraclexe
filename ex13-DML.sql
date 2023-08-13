/*
���ϸ� : ex13-DML.sql

DML(Data Manipulation Language
    DB���� �����͸� �����ϰ� ó���ϴ� SQL
    
    INSERT�� : ���̺� ���ο� ���ڵ� ����
    UPDATE�� : ���̺� ���� ���ڵ带 ����(������Ʈ) �ϴµ� ���
    DELETE�� : ���̺��� Ư�� ���ڵ带 ����
    
    SELECT�� DML�� ���Ե� �� ������, ���� DQL(Data Query Language)�� �з��Ѵ�.
*/

/*
INSERT��
[�⺻����]
    INSERT INTO ���̺�� (�÷���1, �÷���2, ...)
    VALUES(��1, ��2, ...); -> ���� �÷� ������ ��Ī�ؼ� �� �ۼ�
    
    �Ǵ�
    
    INSERT INTO ���̺�� (�÷���1, �÷���2, ...) subquery;
    -> �μ�Ʈ�� �÷��� ���������� ������ Ÿ���� ����� �Ѵ�.
*/
SELECT * FROM DEPARTMENTS;

INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (280, 'Public Relations', 100, 1700);

COMMIT; -- DML ����� ���������� DB�� �ݿ�

-- NULL ���� ���� �� ����
-- �� ����
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME)
VALUES (290, 'Purchasing');

ROLLBACK; -- DML���� �������� ����� ��

-- NULL Ű���� ����
INSERT INTO DEPARTMENTS -- �÷����� ��°�� ������ ������ ���̺��� ���� ��� �÷��� �����ϴ� ���� �־���Ѵ�.
VALUES (300, 'Finance', NULL, NULL);

/*
INSERT subquery
*/
CREATE TABLE SALES_REPS
AS (
    SELECT EMPLOYEE_ID ID, LAST_NAME NAME, SALARY, COMMISSION_PCT
    FROM EMPLOYEES
    WHERE 1 = 2
    )
;

SELECT * FROM SALES_REPS;

-- JOB_ID�� REP�� ���Ե� ���
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID LIKE '%REP%'
;

INSERT INTO SALES_REPS(ID, NAME, SALARY, COMMISSION_PCT)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID LIKE '%REP%'
;

COMMIT;

SELECT * FROM SALES_REPS;

/*
UPDATE��
    ���̺��� ���� ���� �����մϴ�.
    
[�⺻����]
    UPDATE ���̺��
    SET �÷���1 = ������, �÷���2 = ������, ...
    WHERE ������(� ���� ������ ���ΰ�)
    
UPDATE���� �ۼ��� ������ WHERE���� ���Ե��� ������ �÷��� �ϰ�����ȴ�.
���� �ϰ������� ��찡 �ƴϰ� �׻� WHERE���� �ۼ��� �� �ֵ��� �����ؾ� �Ѵ�.
SELECT���� ���� ���� ��ȸ�� �� UPDATE�� �ۼ�
*/

CREATE TABLE COPY_EMP
AS SELECT * FROM EMPLOYEES WHERE 1 = 2;

INSERT INTO COPY_EMP 
SELECT * FROM EMPLOYEES;

COMMIT;

SELECT * FROM COPY_EMP;

-- 113�� ȸ�� �μ���ȣ�� 50������ ����
UPDATE COPY_EMP
SET DEPARTMENT_ID = 50
WHERE EMPLOYEE_ID = 113;

ROLLBACK;

-- WHERE�� ���� �÷� �ϰ�����
UPDATE COPY_EMP
SET DEPARTMENT_ID = 110;

-- subquery�� �̿��� UPDATE��
UPDATE COPY_EMP
SET DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                     FROM EMPLOYEES 
                     WHERE EMPLOYEE_ID = 100)
WHERE JOB_ID = (SELECT JOB_ID
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 200);

SELECT * FROM COPY_EMP WHERE JOB_ID = 'AD_ASST';

/*
DELETE��
    DELETE���� ����Ͽ� ���̺��� ���� ���� ������ �� �ֽ��ϴ�.

[�⺻����]
    DELETE FROM ���̺��
    WHERE ������

������ �� �Ǽ����� �ʱ� ���� �����ϱ� �� SELECT������ ��ȸ�غ���.
*/

-- �����ȣ 200���� ��� ����
DELETE FROM COPY_EMP
WHERE EMPLOYEE_ID = 200;

SELECT * FROM COPY_EMP
WHERE EMPLOYEE_ID = 200;

ROLLBACK;

-- ���̺� ��ü ������ ����
DELETE FROM COPY_EMP;

SELECT * FROM COPY_EMP;

/*
TRUNCATE��
    ���̺��� �� ���·�, ���̺� ���� �״�� ���ܵ� ä ���̺��� ��� ���� �����մϴ�.
    DML���� �ƴ϶� DDL(������ ���Ǿ�)���̹Ƿ� ���� ����� �� �����ϴ�.
*/

TRUNCATE TABLE COPY_EMP;
                
/*
Ʈ������(Transcation)
    ������ ó���� �� �����Դϴ�.
    ����Ŭ���� �߻��ϴ� ���� ���� SQL ��ɹ��� 
    �ϳ��� ������ �۾� ������ ó���ϴµ� �̸� Ʈ�������̶�� �մϴ�.
    
    COMMIT : SQL���� ����� ���������� DB�� �ݿ�
    ROLLBACK : SQL���� �������� ����� �� ���. ���������� Ŀ���ߴ� �������� �ǵ�����.
    SAVEPOINT : Ʈ�������� �� ������ ǥ���ϴ� �ӽ� ������
*/

CREATE TABLE MEMBER(
    num NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    addr VARCHAR2(50)
    );
    
INSERT INTO MEMBER VALUES(1, '��ī��', '���ʸ���');
INSERT INTO MEMBER VALUES(2, '������', '���ʸ���');
INSERT INTO MEMBER VALUES(3, '���̸�', '���ʸ���');
INSERT INTO MEMBER VALUES(4, '���α�', '���ʸ���');
COMMIT;
ROLLBACK;
SELECT * FROM MEMBER;

-- SAVEPOINT
INSERT INTO MEMBER VALUES(5, '������', '���ʸ���');
SAVEPOINT mypoint;
INSERT INTO MEMBER VALUES(6, '�ߵ���', '���ʸ���');
INSERT INTO MEMBER VALUES(7, '������', '���ʸ���');
INSERT INTO MEMBER VALUES(8, '�ǰ���', '���ʸ���');
ROLLBACK TO mypoint;
COMMIT;

/*
SELECT���� FOR UPDATE��
    FOR UPDATE�� Ư�� ���ڵ带 ���(LOCK) ó���ϴ� SQL�����Դϴ�.
    LOCK�� �����ϱ� ���ؼ� COMMIT�̳� ROLLBACK�� �ؾ� �մϴ�.
*/
SELECT EMPLOYEE_ID, SALARY, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = 'SA_REP'
FOR UPDATE;

COMMIT;