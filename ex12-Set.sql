/*
���ϸ� : ex12-Set.sql

���� ������
    ���� ���̺� �Ǵ� ������ ����� �����ϰ� �����ϴ� ������.
    SELECT ����Ʈ�� ǥ������ �÷� ������ ��ġ�ؾ� �մϴ�.
    ������ ������ ��ġ�ؾ� �մϴ�.
    
    UNION, UNION ALL, INTERSECT, MINUS
*/

-- UNION ������ : �� ���� ���� ����� ��ġ��, �ߺ��� ���� �����մϴ�.
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
UNION
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY;

-- UNION ALL ������ : �� ���� ���� ����� ��ġ��, �ߺ��� ���� �����Ͽ� ��� ��ȯ�մϴ�.
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
UNION ALL
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY
ORDER BY EMPLOYEE_ID;

-- INTERSECT ������ : �� ���� ���� ��� �߿��� ����� �ุ ��ȯ�մϴ�.
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
INTERSECT
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY;

-- MINUS ������ : ù ��° ���� ��� �߿��� �� ��° ���� ����� �������� �ʴ� �ุ �����մϴ�.
SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY;

-- !> ������ ���� ��ġ���Ѿ� �մϴ�.
-- �������� ���� �� ���̺��� Ư�� �÷����� UNION�Ͽ� ��������
SELECT LOCATION_ID, DEPARTMENT_NAME AS "Department", TO_CHAR(NULL) "Warehouse location"
FROM DEPARTMENTS
UNION
SELECT LOCATION_ID, TO_CHAR(NULL) AS "Department", STATE_PROVINCE
FROM LOCATIONS;

SELECT EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
UNION
SELECT EMPLOYEE_ID, JOB_ID, 0
FROM JOB_HISTORY;