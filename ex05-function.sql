/*
���ϸ� : ex05-function.sql

�Լ�(Function)
    �Ű������� �޾� Ư�� ���(�۾�)�� �����ϰ� ����� ��ȯ�ϴ� ������ �Ǿ��ִ�.
    
�Լ� ����
    ������ �Լ� - ������ �Ű������� �޾� ����� ��ȯ
    ������(�׷�) �Լ� - ������ �Ű������� �޾� ����� ��ȯ
*/

-- ������ �Լ�

-- ��ҹ��� ��ȯ �Լ�
-- LOWER() �Լ� - ���ڿ��� �ҹ��ڷ� ��ȯ
SELECT EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID
FROM employees
WHERE LOWER(LAST_NAME) = 'higgins'; -- last_name ���̺��� �ҹ��ڷ� ��ȯ�Ͽ� ���ǰ� ����
-- �Լ��� 'higgins'�� ã�� �� ���� ������ ��. �׸�ŭ ���ҽ��� ��ƸԴ´�.

-- UPPER() �Լ� - ���ڿ��� �빮�ڷ� ��ȯ
SELECT UPPER('higgins') FROM dual;

-- INITCAP() �Լ� - ���ڿ��� ù ���ڸ� �빮�ڷ� ��ȯ
SELECT EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID
FROM employees
WHERE LAST_NAME = INITCAP('higgins'); -- �Լ� 1���� �����. ���� LOWER() �Լ����� ���ҽ� ������.

-- ���� ���� �Լ�
-- CONCAT() �Լ� - �� ���� �Ķ���� ���� �����մϴ�.
SELECT 'Hello' || 'World' FROM dual;
SELECT CONCAT('Hello', 'World') FROM dual;

-- SUBSTR() - ������ ������ ���ڿ��� �����մϴ�.
SELECT SUBSTR('HelloWorld', 1, 5) FROM dual;

-- LENGTH() - ���ڿ��� ���̸� ���� ������ ǥ���մϴ�.
SELECT LENGTH('HelloWorld') FROM dual;

-- INSTR() - ���ڿ����� ����� ������ ��ġ�� ã���ϴ�.
SELECT INSTR('HelloWorld', 'W') FROM dual;

-- LPAD() - ���ʺ��� ���ڽ����� ä�� ǥ������ ��ȯ�մϴ�.
SELECT LPAD('salary', 10, '*') FROM dual;

-- RPAD() - �����ʺ��� ���ڽ����� ä�� ǥ������ ��ȯ�մϴ�.
SELECT RPAD('salary', 10, '*') FROM dual;

-- REPLACE() - ���ڿ����� ������ ���ڸ� ġȯ�մϴ�.
SELECT REPLACE('JACK and JUE', 'J', 'BL') FROM dual;

-- TRIM() - ���ڿ����� ���� �Ǵ� ���� ���ڸ� �ڸ��ϴ�.
SELECT TRIM('H' FROM 'HelloWorld') FROM dual;

SELECT TRIM(' ' FROM ' HelloWorld ') FROM dual; -- �� ���� ���� ����. ���̽��� strip()����


-- ���� �Լ�
-- ROUND() - ������ �Ҽ��� �ڸ����� ���� �ݿø��մϴ�.
SELECT ROUND(45.926, 2) FROM dual;

-- TRUNC() - ������ �Ҽ��� �ڸ����� ���� �����մϴ�.
SELECT TRUNC(45.926, 2) FROM dual;

-- MOD() - ���� �������� ��ȯ�մϴ�.
SELECT MOD(1600, 300) FROM dual;

-- CEIL() - �־��� ���ڸ� �ø��Ͽ� ������ ��ȯ�մϴ�.
SELECT CEIL(45.2) FROM dual;


-- ��¥ �Լ�

-- SYSDATE - ���� ��¥�� �ð��� ���� �� �ִ� pseudo-column
SELECT SYSDATE FROM dual;

/*
��¥ ����
    ��¥�� ���ڸ� ���ϰų� ���� ��� ��¥ ���� ���մϴ�.
    �� ��¥ ������ �ϼ��� �˾Ƴ��� ���� ���⿬���� �մϴ�.
*/
SELECT LAST_NAME, (SYSDATE - HIRE_DATE) / 7 AS WEEKS
FROM employees
WHERE DEPARTMENT_ID = 90; -- �Ի� �� �� �ְ� ��������

/*
��¥ ���� �Լ�
    MONTHS_BETWEEN(date1, date2) : �� ��¥ ���� �� ���� ����մϴ�.
    ADD_MONTHS(date, n) : ��¥�� n������ �߰��մϴ�.
    NEXT_DAY(date, day_of_week) : ������ ��¥�� �������� �־��� ������ ������ ��¥�� ����մϴ�.
                                (1:�Ͽ��� ~ 7:�����)
    LAST_DAY(date) : �־��� ���� ������ ��¥�� ��ȯ�մϴ�.
    ROUND(date, format) : ��¥�� ������ �������� �ݿø��մϴ�.
    TRUNC(date, format) : ��¥�� ������ �������� �����մϴ�.
*/    
SELECT MONTHS_BETWEEN(TO_DATE('2017-12-22', 'YYYY-MM-DD'), TO_DATE('2017-05-22', 'YYYY-MM-DD')) FROM dual;
SELECT ADD_MONTHS(TO_DATE('2022-12-16', 'YYYY-MM-DD'), 1) FROM dual;
SELECT NEXT_DAY(TO_DATE('2023-08-05', 'YYYY-MM-DD'), 7) FROM dual;
SELECT LAST_DAY(SYSDATE) FROM dual;
SELECT ROUND(TO_DATE('2023-08-16', 'YYYY-MM-DD'), 'MONTH') FROM dual;
SELECT TRUNC(SYSDATE, 'MONTH') FROM dual;

/*
��ȯ �Լ�
    TO_CHAR() �Լ� - ��¥ �Ǵ� ���ڸ� ���ڿ��� ��ȯ
        YYYY - ��ü ������ ���ڷ� ��Ÿ���ϴ�.
        YEAR - ���� ö�ڷ� ǥ��� ������ ��ȯ�մϴ�.
        MM - ���� 2�ڸ� ���� ���� ��ȯ�մϴ�.
        MONTH - ��ü �� �̸��� ��ȯ�մϴ�.
        MON - ���� 3�ڸ� �� ��ȯ�մϴ�.
        DY - 3�ڸ� ���� �� ��ȯ�մϴ�.
        DAY - ������ ��ü �̸��� ��ȯ�մϴ�.
        DD - ���� ��(1-31)�� ���� �������� ��ȯ�մϴ�.
        HH, HH12, HH24 - 1�ϵ��� �ð� �Ǵ� ���� �ð�(1-12) �Ǵ� ���� �ð�(0-23)�� ��ȯ�մϴ�.
        MI - ��(0-59)�� ��ȯ�մϴ�.
        SS - ��(0-59)�� ��ȯ�մϴ�.
        FF - �и�������(0-999)�� ��ȯ�մϴ�.
        AM �Ǵ� PM - ����/���ĸ� ��Ÿ���� �ڿ��� ǥ�ø� ��ȯ�մϴ�.
        A.M. �Ǵ� P.M. - ����/���ĸ� ��Ÿ���� ��ħǥ�� �ִ� �ڿ��� ǥ�ø� ��ȯ�մϴ�.
*/
SELECT LAST_NAME, TO_CHAR(HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') AS HIREDATE
FROM employees;

-- TIMESTAMP - ��¥ ���� + �и���������� ��ȯ
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS.FF2') FROM dual;

/*
TO_CHAR() �Լ��� ���ڿ� ����� ��
    9 - ���ڷ� ��Ÿ���ϴ�.
    0 - 0�� ǥ�õǵ��� ������ �����մϴ�.
    $ - �ε� �޷� ��ȣ�� ��ġ�մϴ�.
    L - �ε� ���� ��ȭ ��ȣ�� ����մϴ�.
    . - �Ҽ����� ����մϴ�.
    , - õ���� ǥ���ڷ� ��ǥ�� ����մϴ�.
*/
SELECT TO_CHAR(SALARY, 'L99,999.00') SALARY
FROM employees
WHERE LAST_NAME = 'Ernst';

-- TO_DATE() �Լ� - ���ڿ��� DATE Ÿ������ ��ȯ
SELECT LAST_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM employees
WHERE HIRE_DATE < TO_DATE('2005-01-01', 'YYYY-MM-DD');

/*
�Լ� ��ø
    ���� �� �Լ��� ��� �����ε� ��ø�� �� �ֽ��ϴ�.
    ��ø�� �Լ��� ���� ���� �������� ���� ���� ������ �򰡵˴ϴ�.
*/
SELECT LAST_NAME, UPPER(CONCAT(SUBSTR(LAST_NAME, 1, 8), '_US'))
FROM employees
WHERE DEPARTMENT_ID = 60;

-- NVL() �Լ� - null ���� ���� ������ ������ ��ȯ�մϴ�. (null�� ������ �ȵ� �� ���)
SELECT LAST_NAME, SALARY, NVL(COMMISSION_PCT, 0), (SALARY * 12) AS Y_SAL,
        (SALARY * 12) + (SALARY * 12 * NVL(COMMISSION_PCT, 0)) AS AN_SAL
FROM employees;

-- NVL2() �Լ�
-- ù ��° ǥ������ �˻��մϴ�. ù ��° ǥ������ null�� �ƴϸ� �� ��° ǥ������ ��ȯ�մϴ�.
-- ù ��° ǥ������ null�̸� �� ��° ǥ������ ��ȯ�մϴ�.
SELECT LAST_NAME, SALARY, COMMISSION_PCT,
        NVL2(COMMISSION_PCT, 'SAL+COMM', 'SAL') AS income
FROM employees
WHERE DEPARTMENT_ID IN (50, 80);

-- NULLIF() �Լ�
-- �� ǥ������ ���ϰ� ������ null�� ��ȯ�ϰ� �ٸ��� expr1�� ��ȯ�մϴ�.
-- �׷��� expr1�� ���� ���ͷ� NULL�� ������ �� �����ϴ�.
SELECT FIRST_NAME, LENGTH(FIRST_NAME) AS expr1,
        LAST_NAME, LENGTH(LAST_NAME) AS expr2,
        NULLIF(LENGTH(FIRST_NAME), LENGTH(LAST_NAME)) AS result
FROM employees;

-- COALESCE() �Լ�
-- ����Ʈ���� null�� �ƴ� ù ��° ǥ������ ��ȯ�մϴ�. ù ��°�� null�� �ƴϸ� �� ��°��, �� ��°�� null�� �ƴϸ�  �� ��°�� ...
SELECT LAST_NAME, EMPLOYEE_ID,
        COALESCE(TO_CHAR(COMMISSION_PCT), TO_CHAR(MANAGER_ID), 'No commission and no manager')
FROM employees;

-- ���Ǻ� ǥ����
/*
CASE ��
    IF-THEN-ELSE �� �۾��� �����Ͽ� ���Ǻ� ��ȸ�� ������� �����ϵ��� �մϴ�.
*/
SELECT LAST_NAME, JOB_ID, SALARY,
        CASE JOB_ID
            WHEN 'IT_PROG' THEN 1.10 * SALARY
            WHEN 'ST_CLERK' THEN 1.15 * SALARY
            WHEN 'SA_REP' THEN 1.20 * SALARY
            ELSE SALARY
        END AS REVISED_SALARY
FROM employees;

-- DECODE() �Լ�
-- CASE �İ� ������ �۾��� �����մϴ�.
SELECT LAST_NAME, JOB_ID, SALARY,
        DECODE(JOB_ID, 'IT_FROG', 1.10 * SALARY,
                        'ST_CLERK', 1.15 * SALARY,
                        'SA_REP', 1.20 * SALARY,
                        SALARY) AS REVISED_SALARY
FROM employees;
/*
JOB_ID���� 'IT_FROG'�� �ش��� ��� 'IT_FROG', 1.10 * SALARY�� ��ȯ,
'ST_CLERK'�� �ش��� ��� 1.15 * SALARY�� ��ȯ,
'SA_REP'�� �ش��� ��� 1.20 * SALARY�� ��ȯ,
��� �ش����� ���� ��� SALARY�� ��ȯ�Ѵ�.
*/