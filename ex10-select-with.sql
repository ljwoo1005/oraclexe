/*
���ϸ� : ex10-select-with.sql

WITH��
    WITH���� �������� ����� �ӽ÷� �����ϰ� ����� �� �ִ� ����Դϴ�.
    ���� ���̺� ǥ���� CTE(Common Table Expression)
    
    �ַ� ������ ������ �����ϰ� �ۼ��ϰų� �������� ���̴� �� Ȱ��˴ϴ�.
*/

-- �μ��� ��� �޿��� ����ϴ� ����
WITH AvgSalByDept AS ( -- �ӽ� ���̺��
    SELECT 
        DEPARTMENT_ID,
        AVG(SALARY) AS AVG_SALARY
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
) -- �μ�ID�� ��� �޿��� ��ȸ�ϴ� �ӽ� ���̺� ����. ���̽��� def�Լ����� ����
SELECT D.DEPARTMENT_NAME, AvgSalByDept.AVG_SALARY
FROM DEPARTMENTS D
JOIN AvgSalByDept
ON D.DEPARTMENT_ID = AvgSalByDept.DEPARTMENT_ID -- DEPARTMENTS ���̺�� ���� �ӽ����̺��� DEPARTMENT_ID�� JOIN
;
-- WITH���� ����ǥ��
WITH RecursiveCTE(id, name, manager_id, depth) as (
    SELECT EMPLOYEE_ID, LAST_NAME, MANAGER_ID, 0
    FROM EMPLOYEES
    WHERE MANAGER_ID IS NULL -- �ֻ��� �Ŵ���
    UNION ALL
    SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.MANAGER_ID, rc.DEPTH + 1
    FROM EMPLOYEES E
    INNER JOIN RecursiveCTE rc ON E.MANAGER_ID = rc.id
)
SELECT ID, NAME, MANAGER_ID, DEPTH
FROM RecursiveCTE
;