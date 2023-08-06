/*
파일명 : ex08-select-subquery.sql

SubQuery 구문
    SELECT 문에 포함되는 SELECT 문 입니다.
*/

-- 단일 행 subquery 실행
SELECT LAST_NAME, SALARY
FROM employees
WHERE SALARY > ( SELECT SALARY FROM employees WHERE LAST_NAME = 'Abel' );

-- subquery에서 그룹 함수 사용
SELECT LAST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY = (SELECT MIN(SALARY) FROM employees);

/*
여러 행 subquery
    IN
        리스트의 임의 멤버와 같음
    ANY
        =, <>, >, <, >=, <= 연산자가 앞에 있어야 합니다.
        < ANY는 최대값보다 작음을 의미합니다.
        > ANY는 최소값보다 큼을 의미합니다.
        = ANY는 IN과 같습니다.
    ALL
        > ALL은 최대값보다 큼을 의미합니다.
        < ALL은 최소값보다 작음을 의미합니다.
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
WHERE SALARY IN(SELECT SALARY FROM employees WHERE JOB_ID = 'IT_PROG') -- 서브쿼리 조회 결과 중 하나라도 일치하면 조회
AND JOB_ID <> 'IT_PROG';

/*
EXISTS 연산자
    subquery에서 최소한 한 개의 행을 반환하면 TRUE로 평가됩니다.
    IN, ANY, ALL이랑 EXISTS 연산자가 같은 결과를 나타낸다면 EXISTS 연산자가 성능이 더 좋다.
    EXISTS는 서브쿼리 조회 중 하나라도 TRUE가 나타나면 바로 조회를 멈춘다.
*/
SELECT * FROM departments
WHERE NOT EXISTS
        (SELECT * FROM employees
         WHERE EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID); -- 사원이 없는 부서만 조회
         
/*
subquery의 null 값
    반환된 값 중 하나가 null 값이면 전체 query가 행을 반환하지 않습니다.
    null 값을 비교하는 모든 조건은 결과가 null이기 때문입니다.
*/
SELECT EMP.LAST_NAME
FROM employees EMP
WHERE EMP.EMPLOYEE_ID NOT IN
                        (SELECT MGR.MANAGER_ID
                        FROM employees MGR); -- IN일 때는 OR조건, NOT IN일 때는 AND조건. KING의 매니저는 NULL이기 때문에 연산 자체가 안된다.