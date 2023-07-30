/*
���ϸ� : ex02-select-where.sql

������ ����Ͽ� �� ����
    WHERE ���� ����Ͽ� ��ȯ�Ǵ� ���� �����մϴ�.
    
WHERE
    ������ �����ϴ� ������ query�� �����մϴ�.
    
    ������ ���
    - �� �̸�
    - �� ����
    - �� �̸�, ��� �Ǵ� �� ����Ʈ
*/

-- WHERE �� ���

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID = 90;

/*
���ڿ� �� ��¥
    ���ڿ� �� ��¥ ���� ���� ����ǥ�� �����ϴ�.
    ���� ���� ��ҹ��ڸ� �����ϰ� ��¥ ���� ������ �����մϴ�.
    
    �����ͺ��̽����� �⺻ ��¥ ǥ�������� DD-MM-RR
    SQL Develpoer������ ��¥ ǥ�������� RR-MM-DD
*/

SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID
FROM employees
WHERE LAST_NAME = 'Whalen';

SELECT LAST_NAME, HIRE_DATE
FROM employees
WHERE HIRE_DATE = '03/06/17';

/*
�� ������
    Ư�� ǥ������ �ٸ� ���̳� ǥ���İ� ���ϴ� ���ǿ��� ���˴ϴ�.
    
    =   ����
    >   ���� ŭ
    >=  ���� ũ�ų� ����
    <   ���� ����
    <=  ���� �۰ų� ����
    <>  ���� ����
    BETWEEN ... AND ... �� �� ����(��谪 ����)
    IN(set)             �� ����Ʈ �� ��ġ�ϴ� �� �˻�
    LIKE                ��ġ�ϴ� ���� ���� �˻�
    IS NULL             NULL ������ ����
*/
-- �� ������ ���

SELECT LAST_NAME, SALARY
FROM employees
WHERE SALARY <= 3000;

-- BETWEEN �����ڸ� ����ϴ� ���� ����

SELECT LAST_NAME, SALARY
FROM employees
WHERE SALARY BETWEEN 2500 AND 3500;
-- ���� �Ʒ��� ���� ���
SELECT LAST_NAME, SALARY
FROM employees
WHERE SALARY >= 2500
AND SALARY <= 3500;

-- IN �����ڸ� ����ϴ� �������

SELECT EMPLOYEE_ID, LAST_NAME, SALARY, MANAGER_ID
FROM employees
WHERE MANAGER_ID IN (100, 101, 201);
-- ���� �Ʒ��� ���� ���
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, MANAGER_ID
FROM employees
WHERE MANAGER_ID = 100
OR MANAGER_ID = 101
OR MANAGER_ID = 200;

/*
LIKE �����ڸ� ����Ͽ� ���� ��ġ
    LIKE �����ڸ� ����Ͽ� ��ȿ�� �Ÿ� ���ڿ� ���� ��ü ���� �˻��� �����մϴ�.
    �˻� ���ǿ��� ���ͷ� ���ڳ� ���ڰ� ���Ե� �� �ֽ��ϴ�.(��ҹ��� ����)
        - % : 0�� �̻��� ���ڸ� ��Ÿ���ϴ�.
        - _ : �� ���ڸ� ��Ÿ���ϴ�.
*/

SELECT FIRST_NAME
FROM employees
WHERE FIRST_NAME LIKE 'A%'; -- A�� �����ϴ� ��� ���� ��ȸ

-- ��ü ���� ����

SELECT LAST_NAME
FROM employees
WHERE LAST_NAME LIKE '_o%'; -- �� ��° ���ڰ� o�� ��� ���� ��ȸ

-- ESCAPE �ĺ���

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID
FROM employees
WHERE JOB_ID LIKE '%SA\_%' ESCAPE '\';

/*
NULL ���� ���
    IS NULL �����ڷ� NULL�� �׽�Ʈ�մϴ�.
*/
SELECT LAST_NAME, MANAGER_ID
FROM employees
WHERE MANAGER_ID IS NULL; -- NULL�� = �� �ƴ� IS �� ��ȸ�Ѵ�.

/*
�� �����ڸ� ����Ͽ� ��������
    AND : ���� ��� ������ ��� ���� ��� TRUE ��ȯ
    OR  : ���� ��� ���� �� �ϳ��� ���� ��� TRUE ��ȯ
    NOT : ������ ������ ��� TRUE ��ȯ
*/

-- AND ������ ���

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY >= 10000
AND JOB_ID LIKE '%MAN%';

-- OR ������ ���

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY >= 10000
OR JOB_ID LIKE '%MAN%';

-- NOT ������ ���
SELECT LAST_NAME, JOB_ID
FROM employees
WHERE JOB_ID NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');