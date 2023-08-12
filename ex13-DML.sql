/*
파일명 : ex13-DML.sql

DML(Data Manipulation Language
    DB에서 데이터를 조작하고 처리하는 SQL
    
    INSERT문 : 테이블에 새로운 레코드 삽입
    UPDATE문 : 테이블에 기존 레코드를 갱신(업데이트) 하는데 사용
    DELETE문 : 테이블에서 특정 레코드를 삭제
    
    SELECT는 DML에 포함될 수 있지만, 보통 DQL(Data Query Language)로 분류한다.
*/

/*
INSERT문
[기본형식]
    INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
    VALUES(값1, 값2, ...); -> 위의 컬럼 개수와 매칭해서 값 작성
    
    또는
    
    INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...) subquery;
    -> 인서트할 컬럼과 서브쿼리와 데이터 타입을 맞춰야 한다.
*/
SELECT * FROM DEPARTMENTS;

INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (280, 'Public Relations', 100, 1700);

COMMIT; -- DML 결과를 영구적으로 DB에 반영

-- NULL 값을 가진 행 삽입
-- 열 생략
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME)
VALUES (290, 'Purchasing');

ROLLBACK; -- DML문의 실행결과를 취소할 때

-- NULL 키워드 지정
INSERT INTO DEPARTMENTS -- 컬럼명을 통째로 생략할 때에는 테이블이 가진 모든 컬럼에 대응하는 값을 넣어야한다.
VALUES (300, 'Finance', NULL, NULL);

/*
INSERT subquery
*/
CREATE TABLE SALES_REPS
AS (
    SELECT EMPLOYEE_ID ID, LAST_NAME NAME, SALARY, COMMISSION_PCT
    FROM EMPLOYEES
    WHERE 1 = 2
    )
;

SELECT * FROM SALES_REPS;

-- JOB_ID가 REP가 포함된 사원
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID LIKE '%REP%'
;

INSERT INTO SALES_REPS(ID, NAME, SALARY, COMMISSION_PCT)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID LIKE '%REP%'
;

COMMIT;

SELECT * FROM SALES_REPS;