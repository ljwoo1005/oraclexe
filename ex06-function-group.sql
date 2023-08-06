/*
파일명 : ex06-function-group.sql
*/

-- 여러행(그룹) 함수

-- AVG() - 평균
-- MAX() - 최대값
-- MIN() - 최소값
-- SUM() - 합계
SELECT AVG(SALARY) AS avg_salary,
        MAX(SALARY) AS max_salary,
        MIN(SALARY) AS min_salary,
        SUM(SALARY) AS total_salary
FROM employees
WHERE JOB_ID LIKE '%REP%';

-- COUNT() 함수 - null 값이 아닌 모든 행의 개수를 반환합니다.
SELECT COUNT(*) AS total_employees
FROM employees
WHERE DEPARTMENT_ID = 50;

SELECT COUNT(COMMISSION_PCT) AS non_null_commission_count
FROM employees
WHERE DEPARTMENT_ID = 50; -- null값은 카운트가 되지 않아서 0이 나온다.

-- COUNT(DISTINCT expr)은 특정 표현식을 기준으로 중복을 제거한 행의 개수를 반환합니다.
SELECT COUNT(DISTINCT DEPARTMENT_ID) AS DISTINCT_DEPARTMENT_COUNT
FROM employees;

-- NVL() 함수를 활용하여 NULL값을 다른 값으로 대체한 후 AVG() 함수 사용
SELECT AVG(NVL(COMMISSION_PCT, 0)) AS AVG_COMMISSION
FROM employees;

/*
GROUP BY
    여러 행을 지정된 컬럼 기준으로 그룹화하여 집계 함수를 적용하기 위한 구문
    
HAVING
    GROUP BY와 함께 사용되며, 그룹화된 결과에 조건을 적용할 때 사용됩니다.
    
    WHERE - 개별행의 조건
    HAVING - 그룹의 조건
*/

-- 부서별 평균 급여를 구합니다.
SELECT DEPARTMENT_ID, AVG(SALARY) AS AVG_SALARY
FROM employees
GROUP BY DEPARTMENT_ID;

-- GROUP BY 절에서 여러 열을 기준으로 그룹화 합니다.
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY) AS TOTAL_SALARY
FROM employees
WHERE DEPARTMENT_ID > 40
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

-- HAVING 절 사용

-- 부서별 최대 급여가 10000보다 큰 부서를 찾습니다.
SELECT DEPARTMENT_ID, MAX(SALARY) AS MAX_SALARY
FROM employees
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 10000;

-- 직무별 총 급여가 13000보다 큰 직무를 찾습니다.
SELECT JOB_ID, SUM(SALARY) AS TOTAL_SALARY
FROM employees
WHERE JOB_ID NOT LIKE '%REP%'
GROUP BY JOB_ID
HAVING SUM(SALARY) > 10000
ORDER BY SUM(SALARY);

-- 그룹함수 중첩가능
SELECT MAX(AVG(SALARY)) AS MAX_AVG_SALARY
FROM employees
GROUP BY DEPARTMENT_ID;





