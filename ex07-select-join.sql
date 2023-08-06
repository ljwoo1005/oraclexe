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

COMMIT;

SELECT * FROM JOB_GRADES;
*/

/*
Monequijoin
    ��ȣ ������ �ܿ� �ٸ� �����ڸ� �����ϴ� ���� �����Դϴ�.
*/
SELECT E.LAST_NAME, E.SALARY, J.GRADE_LEVEL
FROM employees E JOIN job_grades J
ON E.SALARY BETWEEN J.LOWEST_SAL AND J.HIGHEST_SAL;

/*
INNER JOIN�� OUTER JOIN
    INNER JOIN
        ��ġ���� �ʴ� ���� ��¿� ǥ�õ��� �ʽ��ϴ�.(������ �ش� �� ���)
    OUTER JOIN
        �� ���̺��� ���� ������� �ٸ� ���̺���� ������ ���� ����� �����Ͽ� ��ȯ�մϴ�.
*/

/*
LEFT OUTER JOIN
    DEPARTMENTS ���̺� �����Ǵ� ���� ���
    ���� ���̺��� EMPLOYEES ���̺��� ��� ���� �˻��մϴ�.
    (INNER JOIN�� ���� ��� �����Ǵ� �ุ�� ����Ѵ�.)
*/
SELECT E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM employees E
LEFT OUTER JOIN departments D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- ���� �Ʒ��� ���� ����. ���� ANSI ǥ��
SELECT E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM employees E, departments D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

/*
RIGHT OUTER JOIN
    EMPLOYEES ���̺� �����Ǵ� ���� ���
    ������ ���̺��� DEPARTMENTS ���̺��� ��� ���� �˻��մϴ�.
*/
SELECT E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM employees E
RIGHT OUTER JOIN departments D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

/*
FULL OUTER JOIN
    DEPARTMENTS, EMPLOYEES ���̺� �����Ǵ� ���� ���
    ���̺��� ��� ���� �˻��մϴ�.
*/
SELECT E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM employees E
FULL OUTER JOIN departments D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; 

/*
Cartesian Product
    ���� ������ �߸��ǰų� ������ ������ ��� 
    ����� ��� ���� ������ ǥ�õǴ� Cartesian Product�� ��Ÿ���ϴ�.
*/

/*
CROSS JOIN
    �� ���̺��� ���� ���� �����մϴ�.
*/
SELECT LAST_NAME, DEPARTMENT_NAME
FROM employees
CROSS JOIN departments;