/*
���ϸ� : ex06-function-group.sql
*/

-- ������(�׷�) �Լ�

-- AVG() - ���
-- MAX() - �ִ밪
-- MIN() - �ּҰ�
-- SUM() - �հ�
SELECT AVG(SALARY) AS avg_salary,
        MAX(SALARY) AS max_salary,
        MIN(SALARY) AS min_salary,
        SUM(SALARY) AS total_salary
FROM employees
WHERE JOB_ID LIKE '%REP%';

-- COUNT() �Լ� - null ���� �ƴ� ��� ���� ������ ��ȯ�մϴ�.
SELECT COUNT(*) AS total_employees
FROM employees
WHERE DEPARTMENT_ID = 50;

SELECT COUNT(COMMISSION_PCT) AS non_null_commission_count
FROM employees
WHERE DEPARTMENT_ID = 50; -- null���� ī��Ʈ�� ���� �ʾƼ� 0�� ���´�.