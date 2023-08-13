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

/*
UPDATE문
    테이블의 기존 값을 수정합니다.
    
[기본형식]
    UPDATE 테이블명
    SET 컬럼명1 = 수정값, 컬럼명2 = 수정값, ...
    WHERE 조건절(어떤 행을 수정할 것인가)
    
UPDATE문을 작성할 때에는 WHERE절이 포함되지 않으면 컬럼이 일괄변경된다.
따라서 일괄변경할 경우가 아니고선 항상 WHERE절을 작성할 수 있도록 주의해야 한다.
SELECT문을 통해 먼저 조회한 후 UPDATE문 작성
*/

CREATE TABLE COPY_EMP
AS SELECT * FROM EMPLOYEES WHERE 1 = 2;

INSERT INTO COPY_EMP 
SELECT * FROM EMPLOYEES;

COMMIT;

SELECT * FROM COPY_EMP;

-- 113번 회원 부서번호를 50번으로 변경
UPDATE COPY_EMP
SET DEPARTMENT_ID = 50
WHERE EMPLOYEE_ID = 113;

ROLLBACK;

-- WHERE절 없이 컬럼 일괄변경
UPDATE COPY_EMP
SET DEPARTMENT_ID = 110;

-- subquery를 이용한 UPDATE문
UPDATE COPY_EMP
SET DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                     FROM EMPLOYEES 
                     WHERE EMPLOYEE_ID = 100)
WHERE JOB_ID = (SELECT JOB_ID
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 200);

SELECT * FROM COPY_EMP WHERE JOB_ID = 'AD_ASST';

/*
DELETE문
    DELETE문을 사용하여 테이블에서 기존 행을 제거할 수 있습니다.

[기본형식]
    DELETE FROM 테이블명
    WHERE 조건절

삭제할 때 실수하지 않기 위해 삭제하기 전 SELECT문으로 조회해보자.
*/

-- 사원번호 200번인 사원 삭제
DELETE FROM COPY_EMP
WHERE EMPLOYEE_ID = 200;

SELECT * FROM COPY_EMP
WHERE EMPLOYEE_ID = 200;

ROLLBACK;

-- 테이블 전체 데이터 삭제
DELETE FROM COPY_EMP;

SELECT * FROM COPY_EMP;

/*
TRUNCATE문
    테이블을 빈 상태로, 테이블 구조 그대로 남겨둔 채 테이블에서 모든 행을 제거합니다.
    DML문이 아니라 DDL(데이터 정의어)문이므로 쉽게 언두할 수 없습니다.
*/

TRUNCATE TABLE COPY_EMP;
                
/*
트랜젝션(Transcation)
    데이터 처리의 한 단위입니다.
    오라클에서 발생하는 여러 개의 SQL 명령문을 
    하나의 논리적인 작업 단위로 처리하는데 이를 트랜젝션이라고 합니다.
    
    COMMIT : SQL문의 결과를 영구적으로 DB에 반영
    ROLLBACK : SQL문의 실행결과를 취소할 때 사용. 마지막으로 커밋했던 지점으로 되돌린다.
    SAVEPOINT : 트랜젝션의 한 지점에 표시하는 임시 저장점
*/

CREATE TABLE MEMBER(
    num NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    addr VARCHAR2(50)
    );
    
INSERT INTO MEMBER VALUES(1, '피카츄', '태초마을');
INSERT INTO MEMBER VALUES(2, '라이츄', '태초마을');
INSERT INTO MEMBER VALUES(3, '파이리', '태초마을');
INSERT INTO MEMBER VALUES(4, '꼬부기', '태초마을');
COMMIT;
ROLLBACK;
SELECT * FROM MEMBER;

-- SAVEPOINT
INSERT INTO MEMBER VALUES(5, '버터플', '태초마을');
SAVEPOINT mypoint;
INSERT INTO MEMBER VALUES(6, '야도란', '태초마을');
INSERT INTO MEMBER VALUES(7, '피존투', '태초마을');
INSERT INTO MEMBER VALUES(8, '또가스', '태초마을');
ROLLBACK TO mypoint;
COMMIT;

/*
SELECT문의 FOR UPDATE절
    FOR UPDATE는 특정 레코드를 잠금(LOCK) 처리하는 SQL구문입니다.
    LOCK을 해제하기 위해선 COMMIT이나 ROLLBACK을 해야 합니다.
*/
SELECT EMPLOYEE_ID, SALARY, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = 'SA_REP'
FOR UPDATE;

COMMIT;