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

-- COUNT(DISTINCT expr)�� Ư�� ǥ������ �������� �ߺ��� ������ ���� ������ ��ȯ�մϴ�.
SELECT COUNT(DISTINCT DEPARTMENT_ID) AS DISTINCT_DEPARTMENT_COUNT
FROM employees;

-- NVL() �Լ��� Ȱ���Ͽ� NULL���� �ٸ� ������ ��ü�� �� AVG() �Լ� ���
SELECT AVG(NVL(COMMISSION_PCT, 0)) AS AVG_COMMISSION
FROM employees;

/*
GROUP BY
    ���� ���� ������ �÷� �������� �׷�ȭ�Ͽ� ���� �Լ��� �����ϱ� ���� ����
    
HAVING
    GROUP BY�� �Բ� ���Ǹ�, �׷�ȭ�� ����� ������ ������ �� ���˴ϴ�.
    
    WHERE - �������� ����
    HAVING - �׷��� ����
*/

-- �μ��� ��� �޿��� ���մϴ�.
SELECT DEPARTMENT_ID, AVG(SALARY) AS AVG_SALARY
FROM employees
GROUP BY DEPARTMENT_ID;

-- GROUP BY ������ ���� ���� �������� �׷�ȭ �մϴ�.
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY) AS TOTAL_SALARY
FROM employees
WHERE DEPARTMENT_ID > 40
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

-- HAVING �� ���

-- �μ��� �ִ� �޿��� 10000���� ū �μ��� ã���ϴ�.
SELECT DEPARTMENT_ID, MAX(SALARY) AS MAX_SALARY
FROM employees
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 10000;

-- ������ �� �޿��� 13000���� ū ������ ã���ϴ�.
SELECT JOB_ID, SUM(SALARY) AS TOTAL_SALARY
FROM employees
WHERE JOB_ID NOT LIKE '%REP%'
GROUP BY JOB_ID
HAVING SUM(SALARY) > 10000
ORDER BY SUM(SALARY);

-- �׷��Լ� ��ø����
SELECT MAX(AVG(SALARY)) AS MAX_AVG_SALARY
FROM employees
GROUP BY DEPARTMENT_ID;





