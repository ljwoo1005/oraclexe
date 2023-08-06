/*
���ϸ� : ex08-select-subquery.sql

SubQuery ����
    SELECT ���� ���ԵǴ� SELECT �� �Դϴ�.
*/

-- ���� �� subquery ����
SELECT LAST_NAME, SALARY
FROM employees
WHERE SALARY > ( SELECT SALARY FROM employees WHERE LAST_NAME = 'Abel' );

-- subquery���� �׷� �Լ� ���
SELECT LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY = (SELECT MIN(SALARY) FROM employees);

/*
���� �� subquery
    IN
        ����Ʈ�� ���� ����� ����
    ANY
        =, <>, >, <, >=, <= �����ڰ� �տ� �־�� �մϴ�.
        < ANY�� �ִ밪���� ������ �ǹ��մϴ�.
        > ANY�� �ּҰ����� ŭ�� �ǹ��մϴ�.
        = ANY�� IN�� �����ϴ�.
    ALL
        > ALL�� �ִ밪���� ŭ�� �ǹ��մϴ�.
        < ALL�� �ּҰ����� ������ �ǹ��մϴ�.
*/
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY < ANY(SELECT SALARY FROM employees WHERE JOB_ID = 'IT_PROG')
AND JOB_ID <> 'IT_PROG';

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY > ALL(SELECT SALARY FROM employees WHERE JOB_ID = 'IT_PROG')
AND JOB_ID <> 'IT_PROG';

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY IN(SELECT SALARY FROM employees WHERE JOB_ID = 'IT_PROG') -- �������� ��ȸ ��� �� �ϳ��� ��ġ�ϸ� ��ȸ
AND JOB_ID <> 'IT_PROG';

/*
EXISTS ������
    subquery���� �ּ��� �� ���� ���� ��ȯ�ϸ� TRUE�� �򰡵˴ϴ�.
    IN, ANY, ALL�̶� EXISTS �����ڰ� ���� ����� ��Ÿ���ٸ� EXISTS �����ڰ� ������ �� ����.
    EXISTS�� �������� ��ȸ �� �ϳ��� TRUE�� ��Ÿ���� �ٷ� ��ȸ�� �����.
*/
SELECT * FROM departments
WHERE NOT EXISTS
        (SELECT * FROM employees
         WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID); -- ����� ���� �μ��� ��ȸ
         
/*
subquery�� null ��
    ��ȯ�� �� �� �ϳ��� null ���̸� ��ü query�� ���� ��ȯ���� �ʽ��ϴ�.
    null ���� ���ϴ� ��� ������ ����� null�̱� �����Դϴ�.
*/
SELECT EMP.LAST_NAME
FROM employees EMP
WHERE EMP.EMPLOYEE_ID NOT IN
                        (SELECT MGR.MANAGER_ID
                        FROM employees MGR); -- IN�� ���� OR����, NOT IN�� ���� AND����. KING�� �Ŵ����� NULL�̱� ������ ���� ��ü�� �ȵȴ�.