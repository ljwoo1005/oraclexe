/*
���ϸ� : ex07-select-join.sql

JOIN    
    SQL���� �� �� �̻��� ���̺��� ���õ� ����� �����ϱ� ���� �����Դϴ�.
*/

/*
Natural Join
    �� ���̺��� ������ ������ �̸��� ��ġ�ϴ� ���� ������� �ڵ����� ���̺��� ������ �� �ֽ��ϴ�.
*/
SELECT DEPARTMENT_ID, DEPARTMENT_NAME,
        LOCATION_ID, CITY
FROM departments
NATURAL JOIN locations;

/*
USING ���� ����
    ��������� ������ �����ϰ��� �ϴ� ���� �����ݴϴ�.
*/
SELECT EMPLOYEE_ID, LAST_NAME, 
        LOCATION_ID, DEPARTMENT_ID
FROM employees JOIN departments
USING (DEPARTMENT_ID);

/*
ON ���� ����
    ON ���� ����Ͽ� ���� ������ �����մϴ�.
*/
SELECT e.EMPLOYEE_ID, e.LAST_NAME, e.DEPARTMENT_ID,
        d.DEPARTMENT_ID, d.LOCATION_ID
FROM employees e JOIN departments d
ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID);
-- ���� �Ʒ��� ���� ����. ���� ANSI ǥ��. ����Ŭ������ �ؿ����� ����
SELECT E.EMPLOYEE_ID, E.LAST_NAME,
    E.DEPARTMENT_ID, D.LOCATION_ID
FROM employees e, departments d
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID; -- where���� on���� �����

-- ON �� ����Ͽ� 3-Way ����
SELECT e.EMPLOYEE_ID, l.CITY, d.DEPARTMENT_NAME
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id; -- SELECT���� ������ �÷��� �� ������� �ʾƵ� �ȴ�. ���̺��� ���� ��ġ�� �÷��� �� ���� �����ϸ� ��.

-- ���ο� �߰� ���� ����
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID,
    D.DEPARTMENT_ID, D.LOCATION_ID
FROM employees E JOIN departments D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.MANAGER_ID = 149; -- AND�� ���� �߰�. WHERE�ε� �����ϴ�.

/*
���̺� ��ü ����
    ON ���� ����ϴ� Self Join
*/
SELECT WORKER.LAST_NAME WORKER_LAST_NAME, MANAGER.LAST_NAME MANAGER_LAST_NAME
FROM employees WORKER JOIN employees MANAGER
ON WORKER.MANAGER_ID = MANAGER.EMPLOYEE_ID;

/*
Monequijoin
    ��ȣ ������ �ܿ� �ٸ� �����ڸ� �����ϴ� ���� �����Դϴ�.
*/

CREATE TABLE JOB_GRADES (
GRADE_LEVEL CHAR(1),
LOWEST_SAL NUMBER(8,2) NOT NULL,
HIGHEST_SAL NUMBER(8,2) NOT NULL
);

ALTER TABLE JOB_GRADES
ADD CONSTRAINT JOBGRADES_GRADE_PK PRIMARY KEY (GRADE_LEVEL);

INSERT INTO JOB_GRADES VALUES ('A', 1000, 2999);
INSERT INTO JOB_GRADES VALUES ('B', 3000, 5999);
INSERT INTO JOB_GRADES VALUES ('C', 6000, 9999);
INSERT INTO JOB_GRADES VALUES ('D', 10000, 14999);
INSERT INTO JOB_GRADES VALUES ('E', 15000, 24999);
INSERT INTO JOB_GRADES VALUES ('F', 25000, 40000);