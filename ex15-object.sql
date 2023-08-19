/*
파일명 : ex15-object.sql

데이터베이스 객체
    테이블 : 기본 저장단위이며 행으로 구성되어있습니다.
    뷰 : 하나 이상의 테이블에 있는 데이터의 부분 집합을 논리적으로 나타냅니다.(가상 테이블)
    시퀀스 : 일련의 숫자를 자동으로 생성해주는 객체입니다.
    인덱스 : 테이블의 데이터에 대한 빠른 검색을 지원해주는 색인 객체입니다.
    동의어 : 객체에 다른 이름을 부여합니다.
*/

-- 뷰 생성
CREATE VIEW EMPVU80 
AS SELECT EMPLOYEE_ID, LAST_NAME, SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 80; -- DEPARTMENT_ID가 80인 사원들의 쿼리를 가상의 테이블로 만듬

DESC EMPVU80;

SELECT * FROM EMPVU80;

-- alias 사용하여 뷰 생성
CREATE VIEW SALVU50
AS SELECT EMPLOYEE_ID AS ID_NUMBER, LAST_NAME NAME, SALARY*12 ANN_SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50;
    
SELECT * FROM SALVU50
WHERE ANN_SALARY >= 50000;

-- 뷰 수정
CREATE OR REPLACE VIEW EMPVU80 -- EMPVU80테이블이 없으면 생성, 있으면 밑 내용으로 수정
    (ID_NUMBER, NAME, SAL, DEPARTMENT_ID) -- 별칭을 위에 따로 작성
    AS SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME,
              SALARY, DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 80;
    
SELECT * FROM EMPVU80;

UPDATE EMPVU80 
SET DEPARTMENT_ID = 90
WHERE ID_NUMBER = 145; -- 뷰를 수정했더니 뷰에서 해당 데이터가 사라졌다.
                       -- 뷰가 수정되지 않고 실제 EMPLOYEES 테이블의 데이터가 수정되었기 때문이다.

SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID = 145;

ROLLBACK;

/*
복합 뷰 생성
    두 개 이상의 기본 테이블에 의해 정의된 뷰
*/
CREATE OR REPLACE VIEW DEPT_SUM_VU
    (NAME, MINSAL, MAXSAL, AVGSAL)
AS SELECT D.DEPARTMENT_NAME, MIN(E.SALARY),
          MAX(E.SALARY), AVG(E.SALARY)
    FROM EMPLOYEES E JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_NAME;

SELECT * FROM DEPT_SUM_VU;

/*
뷰 DML 작업 수행 규칙
    1. 행을 제거할 수 없는 경우
        - 그룹 함수가 있는 경우
        - GROUP BY 절로 감싸져있는 경우
        - DISTINCT 키워드가 적용된 경우
        - Pseudocolumn ROWNUM 키워드가 적용된 경우
    2. 뷰의 데이터를 수정할 수 없는 경우
        - 그룹 함수가 있는 경우
        - GROUP BY 절로 감싸져있는 경우
        - DISTINCT 키워드가 적용된 경우
        - Pseudocolumn ROWNUM 키워드가 적용된 경우
        - 표현식으로 정의되는 열(SALARY*12같은거)
    3. 뷰를 통해 데이터를 추가할 수 없는 경우    
        - 그룹 함수가 있는 경우
        - GROUP BY 절로 감싸져있는 경우
        - DISTINCT 키워드가 적용된 경우
        - Pseudocolumn ROWNUM 키워드가 적용된 경우
        - 표현식으로 정의되는 열(SALARY*12같은거)
        - 뷰에서 선택되지 않은 기본 테이블의 NOT NULL 열
*/

-- ROWNUM : 쿼리의 결과의 각 행에 순차적인 번호를 할당해준다.
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- DML 작업거부
CREATE OR REPLACE VIEW EMPVU10
    (EMPLOYEE_NUMBER, EMPLOYEE_NAME, JOB_TITLE)
AS SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 10
    WITH READ ONLY; -- SELECT만 가능, UPDATE 불가능
    
SELECT * FROM EMPVU10;

UPDATE EMPVU10 
SET EMPLOYEE_NAME = 'Whalen1'
WHERE EMPLOYEE_NUMBER = 200; -- SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

/*
WITH CHECK OPTION
    뷰에 대한 데이터 변경작업 제한
    조건에 해당되게만 수정이 가능
*/

CREATE OR REPLACE VIEW HIGH_SALARY_EMPLOYEE_VU
AS SELECT * FROM EMPLOYEES WHERE SALARY > 10000
WITH CHECK OPTION CONSTRAINT HIGH_SALARY_EMPLOYEE_CK;

SELECT * FROM HIGH_SALARY_EMPLOYEE_VU;

UPDATE HIGH_SALARY_EMPLOYEE_VU
SET SALARY = 2400
WHERE EMPLOYEE_ID = 100; -- ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
                         -- 조건이 SALARY가 10000 초과이기 때문에 SALARY값이 그 이하로 변경될 수 없다.

UPDATE HIGH_SALARY_EMPLOYEE_VU
SET SALARY = 26000
WHERE EMPLOYEE_ID = 100;

-- 뷰 제거
DROP VIEW HIGH_SALARY_EMPLOYEE_VU;

/*
시퀀스(Sequence)
    연속적인 숫자 값을 자동으로 증감시켜서 값을 리턴하는 객체입니다.
    채번할 때 많이 사용한다.
*/

CREATE SEQUENCE MY_SEQ
        INCREMENT BY 1      -- 증가값(1씩 증가)
        START WITH 1        -- 시작값
        MINVALUE 1          -- 최소값
        MAXVALUE 99999999   -- 최대값
        NOCYCLE             -- 최대값 도달시 시작부터 반복 안함
        CACHE 20            -- 미리 번호를 메모리에 생성
        ORDER;              -- 요청 순서대로 값을 생성

SELECT MY_SEQ.NEXTVAL FROM DUAL; -- MY_SEQ.NEXTVAL 실행할 때 마다 숫자가 1씩 늘어남

-- 현재 시퀀스 값 확인
SELECT MY_SEQ.CURRVAL FROM DUAL; -- 실행해도 숫자가 늘어나지 않음

-- 시퀀스 삭제
DROP SEQUENCE MY_SEQ;

SELECT * FROM DEPT3;

INSERT INTO DEPT3 VALUES(MY_SEQ.NEXTVAL, 'A', 1, SYSDATE);
INSERT INTO DEPT3 VALUES(MY_SEQ.NEXTVAL, 'B', 2, SYSDATE);
INSERT INTO DEPT3 VALUES(MY_SEQ.NEXTVAL, 'C', 3, SYSDATE);

/*
인덱스(INDEX)
    데이터베이스에서 데이터를 빠르게 검색하기 위해 특정 열(또는 열의 조합)을 
    정렬하여 저장하는 구조로, 데이터 조회 성능을 향상시키는데 사용됩니다.

    PK - 테이블 생성 시 자동으로 인덱스 생성이 됩니다.
*/

SELECT * FROM EMPLOYEES
WHERE LAST_NAME = 'King';

SELECT LAST_NAME, ROWID FROM EMPLOYEES
ORDER BY LAST_NAME; -- ROWID : 실제 데이터가 저장되어있는 물리적 주소값

-- EMPLOYEES 테이블의 LAST_NAME 열에 대한 인덱스 생성
CREATE INDEX EMP_LAST_NAME_IDX
    ON EMPLOYEES(LAST_NAME);
    
-- 인덱스 제거
DROP INDEX EMP_LAST_NAME_IDX;

/*
동의어(SYNONYM)
    동의어를 생성하여 객체에 대체 이름을 부여할 수 있습니다.
*/

-- 동의어 생성
CREATE SYNONYM D_SUM
FOR DEPT_SUM_VU;

SELECT * FROM DEPT_SUM_VU;

SELECT * FROM D_SUM;

-- 동의어 제거
DROP SYNONYM D_SUM;

/*
ROWID : ROW 고유의 아이디
        데이터베이스 내부에서 행의 물리적 위치를 나타냅니다.
ROWNUM : 쿼리의 결과의 각 행에 순차적인 번호를 할당해준다.
*/

SELECT ROWNUM, ROWID, EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES;

