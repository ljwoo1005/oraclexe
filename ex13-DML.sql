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