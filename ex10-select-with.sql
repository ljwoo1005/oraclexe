/*
파일명 : ex10-select-with.sql

WITH절
    WITH절은 서브쿼리 결과를 임시로 정의하고 사용할 수 있는 기능입니다.
    공통 테이블 표현식 CTE(Common Table Expression)
    
    주로 복잡한 쿼리를 간결하게 작성하거나 가독성을 높이는 데 활용됩니다.
*/

-- 부서별 평균 급여를 계산하는 쿼리
WITH AvgSalByDept AS ( -- 임시 테이블명
    SELECT 
        DEPARTMENT_ID,
        AVG(SALARY) AS AVG_SALARY
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
) -- 부서ID의 평균 급여를 조회하는 임시 테이블 생성. 파이썬의 def함수같은 느낌
SELECT D.DEPARTMENT_NAME, AvgSalByDept.AVG_SALARY
FROM DEPARTMENTS D
JOIN AvgSalByDept
ON D.DEPARTMENT_ID = AvgSalByDept.DEPARTMENT_ID -- DEPARTMENTS 테이블과 위의 임시테이블을 DEPARTMENT_ID로 JOIN
;
-- WITH절로 계층표현
WITH RecursiveCTE(id, name, manager_id, depth) as (
    SELECT EMPLOYEE_ID, LAST_NAME, MANAGER_ID, 0
    FROM EMPLOYEES
    WHERE MANAGER_ID IS NULL -- 최상위 매니저
    UNION ALL
    SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.MANAGER_ID, rc.DEPTH + 1
    FROM EMPLOYEES E
    INNER JOIN RecursiveCTE rc ON E.MANAGER_ID = rc.id
)
SELECT ID, NAME, MANAGER_ID, DEPTH
FROM RecursiveCTE
;