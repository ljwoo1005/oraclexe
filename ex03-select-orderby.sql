/*
���ϸ� : ex03-select-orderby.sql

ORDER BY ��
    ORDER BY ���� ����Ͽ� �˻��� ���� �����մϴ�.
        ASC : ��������, �⺻��
        DESC : ��������
    SELECT ���� �� �������� �ɴϴ�.
    
[SELECT �� �⺻����]
�д� ����
5       SELECT (DISTINCT) �÷���1, �÷���2, ...
1       FROM ���̺��
2       WHERE ������
3       GROUP BY �÷���
4       HAVING ������
6       ORDER BY �÷��� [ASC|DESC]
*/

SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, HIRE_DATE
FROM employees
ORDER BY HIRE_DATE;

-- �������� ����
SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, HIRE_DATE
FROM employees
ORDER BY HIRE_DATE DESC;

-- �� alias�� �������� ����

SELECT EMPLOYEE_ID, LAST_NAME, SALARY*12 ANNSAL
FROM employees
ORDER BY ANNSAL;

-- �� ���� ��ġ�� ����Ͽ� ����
SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, HIRE_DATE
FROM employees
ORDER BY 3;

-- ���� ���� �������� ����
SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, SALARY
FROM employees
ORDER BY DEPARTMENT_ID, SALARY DESC;