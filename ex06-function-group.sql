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