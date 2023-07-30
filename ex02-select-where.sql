/*
파일명 : ex02-select-where.sql

선택을 사용하여 행 제한
    WHERE 절을 사용하여 반환되는 행을 제한합니다.
    
WHERE
    조건을 충족하는 행으로 query를 제한합니다.
    
    세가지 요소
    - 열 이름
    - 비교 조건
    - 열 이름, 상수 또는 값 리스트
*/

-- WHERE 절 사용

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID = 90;

/*
문자열 및 날짜
    문자열 및 날짜 값은 작은 따옴표로 묶습니다.
    문자 값은 대소문자를 구분하고 날짜 값은 형식을 구분합니다.
    
    데이터베이스에서 기본 날짜 표시형식은 DD-MM-RR
    SQL Develpoer에서는 날짜 표시형식이 RR-MM-DD
*/

SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID
FROM employees
WHERE LAST_NAME = 'Whalen';

SELECT LAST_NAME, HIRE_DATE
FROM employees
WHERE HIRE_DATE = '03/06/17';

/*
비교 연산자
    특정 표현식을 다른 값이나 표현식과 비교하는 조건에서 사용됩니다.
    
    =   같음
    >   보다 큼
    >=  보다 크거나 같음
    <   보다 작음
    <=  보다 작거나 같음
    <>  같지 않음
    BETWEEN ... AND ... 두 값 사이(경계값 포함)
    IN(set)             값 리스트 중 일치하는 값 검색
    LIKE                일치하는 문자 패턴 검색
    IS NULL             NULL 값인지 여부
*/
-- 비교 연산자 사용

SELECT LAST_NAME, SALARY
FROM employees
WHERE SALARY <= 3000;

-- BETWEEN 연산자를 사용하는 범위 조건

SELECT LAST_NAME, SALARY
FROM employees
WHERE SALARY BETWEEN 2500 AND 3500;
-- 위와 아래는 같은 기능
SELECT LAST_NAME, SALARY
FROM employees
WHERE SALARY >= 2500
AND SALARY <= 3500;

-- IN 연산자를 사용하는 멤버조건

SELECT EMPLOYEE_ID, LAST_NAME, SALARY, MANAGER_ID
FROM employees
WHERE MANAGER_ID IN (100, 101, 201);
-- 위와 아래는 같은 기능
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, MANAGER_ID
FROM employees
WHERE MANAGER_ID = 100
OR MANAGER_ID = 101
OR MANAGER_ID = 200;

/*
LIKE 연산자를 사용하여 패턴 일치
    LIKE 연산자를 사용하여 유효한 거맥 문자열 값의 대체 문자 검색을 수행합니다.
    검색 조건에는 리터럴 문자나 숫자가 포함될 수 있습니다.(대소문자 구분)
        - % : 0개 이상의 문자를 나타냅니다.
        - _ : 한 문자를 나타냅니다.
*/

SELECT FIRST_NAME
FROM employees
WHERE FIRST_NAME LIKE 'A%'; -- A로 시작하는 사원 전부 조회

-- 대체 문자 결합

SELECT LAST_NAME
FROM employees
WHERE LAST_NAME LIKE '_o%'; -- 두 번째 글자가 o인 사원 전부 조회

-- ESCAPE 식별자

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID
FROM employees
WHERE JOB_ID LIKE '%SA\_%' ESCAPE '\';

/*
NULL 조건 사용
    IS NULL 연산자로 NULL을 테스트합니다.
*/
SELECT LAST_NAME, MANAGER_ID
FROM employees
WHERE MANAGER_ID IS NULL; -- NULL은 = 가 아닌 IS 로 조회한다.

/*
논리 연산자를 사용하여 조건정의
    AND : 구성 요소 조건이 모두 참인 경우 TRUE 반환
    OR  : 구성 요소 조건 중 하나가 참인 경우 TRUE 반환
    NOT : 조건이 거짓인 경우 TRUE 반환
*/

-- AND 연산자 사용

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY >= 10000
AND JOB_ID LIKE '%MAN%';

-- OR 연산자 사용

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY >= 10000
OR JOB_ID LIKE '%MAN%';

-- NOT 연산자 사용
SELECT LAST_NAME, JOB_ID
FROM employees
WHERE JOB_ID NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');