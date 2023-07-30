/*
파일명 : ex03-select-orderby.sql

ORDER BY 절
    ORDER BY 절을 사용하여 검색된 행을 정렬합니다.
        ASC : 오름차순, 기본값
        DESC : 내림차순
    SELECT 문의 맨 마지막에 옵니다.
    
[SELECT 문 기본형식]
읽는 순서
5       SELECT (DISTINCT) 컬럼명1, 컬럼명2, ...
1       FROM 테이블명
2       WHERE 조건절
3       GROUP BY 컬럼명
4       HAVING 조건절
6       ORDER BY 컬럼명 [ASC|DESC]
*/

SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, HIRE_DATE
FROM employees
ORDER BY HIRE_DATE;

-- 내림차순 정렬
SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, HIRE_DATE
FROM employees
ORDER BY HIRE_DATE DESC;

-- 열 alias를 기준으로 정렬

SELECT EMPLOYEE_ID, LAST_NAME, SALARY*12 ANNSAL
FROM employees
ORDER BY ANNSAL;

-- 열 숫자 위치를 사용하여 정렬
SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, HIRE_DATE
FROM employees
ORDER BY 3;

-- 여러 열을 기준으로 정렬
SELECT LAST_NAME, JOB_ID, DEPARTMENT_ID, SALARY
FROM employees
ORDER BY DEPARTMENT_ID, SALARY DESC;