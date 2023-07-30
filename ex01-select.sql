/*
���ϸ� : ex01-select.sql

SQL (Structured Query Language) - ������ ���� ���
    ������ �����ͺ��̽� �ý��ۿ��� �ڷḦ ���� �� ó���ϱ� ���� ����� ���
    
SELECT ��
    �����ͺ��̽����� ���� �˻� ��ɾ�
*/

-- ��� �� ���� : *
SELECT *
FROM departments;

-- Ư�� �� ���� (�������� Projection)
SELECT department_id, location_id
FROM departments;

/*
�����
    ��������ڸ� ����Ͽ� ����/��¥ ������ ǥ���� �ۼ�
    
    + ���ϱ�
    - ����
    * ���ϱ�
    / ������
    
*/

-- ��� ������ ���
SELECT LAST_NAME, SALARY, SALARY + 300
FROM employees;

/*
������ �켱����
    ���ϱ�� ������� ���ϱ� ���⺸�� ���� ����
*/

SELECT LAST_NAME, SALARY, 12*SALARY+100
FROM employees;

SELECT LAST_NAME, SALARY, 12*(SALARY+100)
FROM employees;

/*
������� Null ��
    null ���� �����ϴ� ������� null�� ���
*/

SELECT LAST_NAME, 12*SALARY*COMMISSION_PCT, SALARY, COMMISSION_PCT
FROM employees;

/*
�� alias ����
    �� �Ӹ����� �̸��� �ٲߴϴ�.
    �� �̸� �ٷ� �ڿ� ���ɴϴ�. (�� �̸��� alias ���̿� ���� ������ asŰ���尡 �� �� �ֽ��ϴ�.)
    �����̳� Ư�����ڸ� �����ϰų� ��ҹ��ڸ� �����ϴ� ��� ū ����ǥ�� �ʿ��մϴ�.
*/

SELECT LAST_NAME AS NAME, COMMISSION_PCT COMM, SALARY * 10 AS �޿�10��
FROM employees;

SELECT LAST_NAME "Name", SALARY*12 "Annual Salary"
FROM employees;

/*
���� ������
    ���̳� ���ڿ��� �ٸ� ���� �����մϴ�.
    �� ���� ���μ�(||)���� ��Ÿ���ϴ�.
    ��� ���� ���� ǥ������ �ۼ��մϴ�.
*/

SELECT LAST_NAME||JOB_ID AS "Employees", LAST_NAME, JOB_ID
FROM employees;

/*
���ͷ� ���ڿ�
    ���ͷ��� SELECT ���� ���Ե� ����, ���� �Ǵ� ��¥�Դϴ�.
    ��¥ �� ���� ���ͷ� ���� ���� ����ǥ�� ����� �մϴ�.
    �� ���ڿ��� ��ȯ�Ǵ� �� �࿡ �� �� ��µ˴ϴ�.
*/

SELECT LAST_NAME || ' is a ' || JOB_ID AS "Employee Details"
FROM employees;

/*
��ü �ο� ������
    �ڽ��� ����ǥ �����ڸ� �����մϴ�.
    �����ڸ� ���Ƿ� �����մϴ�.
    ������ �� ��뼺�� �����մϴ�.
*/

SELECT DEPARTMENT_NAME || q'[ Department's Manager Id : ]' || MANAGER_ID
AS "Department and Manager"
FROM departments;

/*
�ߺ���
    �⺻������ Query ������� �ߺ� ���� ������ ��� ���� ǥ�õ˴ϴ�.
    
DISTINCT
    ������� �ߺ��� ����
*/

SELECT DEPARTMENT_ID
FROM employees;

-- �ߺ� ����

SELECT DISTINCT DEPARTMENT_ID
FROM employees;

/*
���̺� ����ǥ��
    DESCRIBE ����� ����Ͽ� ���̺� ������ ǥ���մϴ�.
*/

DESCRIBE employees;
DESC employees;


