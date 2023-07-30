/*
���ϸ� : ex04-select-quiz.sql
*/

-- Q1. "employees" ���̺��� ��� �������� ��(last_name), �̸�(first_name) �� �޿�(salary)�� ��ȸ�ϼ���.
SELECT LAST_NAME, FIRST_NAME, SALARY
FROM employees;

-- Q2. "jobs" ���̺��� ��� �������� ���� ID(job_id)�� ������(job_title)�� ��ȸ�ϼ���.
SELECT JOB_ID, JOB_TITLE
FROM jobs;

-- Q3. "departments" ���̺��� ��� �μ����� �μ� ID(department_id)�� �μ���(departmemt_name)�� ��ȸ�ϼ���.
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM departments;

-- Q4. "locations" ���̺��� ��� �������� ���� ID(location_id)�� ����(city)�� ��ȸ�ϼ���.
SELECT LOCATION_ID, CITY
FROM locations;

-- Q5. "employees" ���̺��� �޿�(salary)�� 5000 �̻��� �������� �̸�(first_name)�� �޿�(salary)�� ��ȸ�ϼ���.
SELECT FIRST_NAME, SALARY
FROM employees
WHERE SALARY >= 5000;

-- Q6. "employees" ���̺��� �ٹ� ������(hire_date)�� 2005�� ������ �������� �̸�(first_name)�� �ٹ� ������(hire_date)�� ��ȸ�ϼ���.
SELECT FIRST_NAME, HIRE_DATE
FROM employees
WHERE HIRE_DATE >= '05/01/01';