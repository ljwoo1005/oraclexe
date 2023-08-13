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