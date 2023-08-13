/*
파일명 : ex14-DDL.sql

DDL(Data Definition Language) - 데이터 정의어
    데이터베이스 내의 구조 및 객체(테이블, 시퀀스 등)를 생성, 변경, 삭제하기 위해 사용되는 SQL문입니다.
*/

/*
CREATE TABLE문
    데이터를 저장할 테이블을 생성합니다.
    
    CREATE TABLE 테이블명 (
    컬럼명 컬럼타입
    );
    
*/

CREATE TABLE DEPT (
    DEPTNO NUMBER(6), -- 숫자 6자리까지
    DNAME VARCHAR2(200), -- 문자 200BYTE까지
    LOC VARCHAR2(200),
    CREATE_DATE DATE DEFAULT SYSDATE
    );
    
DESC DEPT;

/*
데이터 유형
    VARCHAR2(size) : 가변 길이 문자 데이터 (최대 4000byte까지 가능)
    NUMBER(p,s) : 가변 길이 숫자 데이터 (p는 숫자 자리, s는 소숫점 자리)
    CHAR(size) : 고정 길이 문자 (최대 2000byte까지 가능)
    DATE : 날짜 및 시간값
    CLOB : 문자 데이터 (최대 4GB까지 가능)
    BLOB : 바이너리 데이터(최대 4GB까지 가능, 파일을 저장)
    BFILE : 파일 위치와 메타데이터 저장(최대 4GB까지 가능)
*/

-- DEPARTMENTS 테이블의 데이터를 DEPT 테이블에 복사하기
INSERT INTO DEPT
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, SYSDATE
FROM DEPARTMENTS;

/*
CTAS는 "Create Table As Select"의 약자로,
데이터베이스에서 새로운 테이블을 생성하는 기법입니다.
이 기법은 기존 테이블에서 SELECT문을 사용하여 데이터를 조회한 후,
그 결과를 새로운 테이블로 생성하는 방법입니다.
*/

-- 테이블 복사하기 => 제약조건은 복사가 안된다.
CREATE TABLE DEPT2 AS SELECT * FROM DEPT;
DESC DEPT2;

SELECT * FROM DEPT2;

-- 테이블 구조만 복사하기(조건이 항상 거짓이 되는 편법 사용)
CREATE TABLE DEPT3 AS SELECT * FROM DEPT WHERE 1=2;

/*
ALTER문
    데이터베이스 객체 구조나 속성을 변경할 때 사용되는 SQL 명령문입니다.
*/

CREATE TABLE SIMPLE(num NUMBER);

SELECT * FROM SIMPLE;

-- 컬럼 추가하기
ALTER TABLE SIMPLE ADD(NAME VARCHAR2(3));

-- 컬럼 수정하기
ALTER TABLE SIMPLE MODIFY(NAME VARCHAR2(30));

-- 컬럼 삭제하기
ALTER TABLE SIMPLE DROP COLUMN NAME;

ALTER TABLE SIMPLE ADD(ADDR VARCHAR(50));
ALTER TABLE SIMPLE DROP(ADDR);

DESC SIMPLE;

-- DROP문 : 객체를 삭제할 때 사용되는 SQL 명령문입니다.
-- 테이블 삭제
DROP TABLE SIMPLE;

/*
제약조건(Constraint)
    테이블의 해당 컬럼에 원하지 않는 데이터를 입력/수정/삭제되는 것을 방지하기 위해
    테이블 생성 또는 변경시 설정하는 조건입니다.(저장된 데이터의 신뢰성을 높이기 위함)
    
    NOT NULL
        NULL로 입력이 되어서는 안되는 컬럼에 부여하는 조건으로
        컬럼 레벨에서만 부여할 수 있는 제약조건입니다.
    UNIQUE KEY(유일키)
        저장된 값이 중복되지 않고 오직 유일하게 유지되어야 할 때 사용하는 제약조건입니다.
        (NULL값이 허용된다.)
    PRIMARY KEY(대표키, 기본키)
        NOT NULL 조건과 UNIQUE KEY 조건을 합친 조건입니다.
    CHECK
        조건에 맞는 데이터만 입력되도록 조건을 부여하는 제약조건입니다.
    FOREIGN KEY(외래키, 참조키)
        부모 테이블의 PRIMARY KEY를 참조하는 컬럼에 붙이는 제약조건입니다.
*/

CREATE TABLE DEPT4(
    DEPTNO NUMBER(2) CONSTRAINT DEPT4_DEPTNO_PK PRIMARY KEY, -- 제약조건이름 DEPT4_DEPTNO_PK
    DNAME VARCHAR2(15) DEFAULT '영업부', -- 값을 정의하지 않았을 때 '영업부'가 들어간다.
    LOC CHAR(1) CONSTRAINT DEPT4_LOC_CK CHECK(LOC IN('1','2')) -- '1'과 '2'만 들어갈 수 있다.
);

SELECT * FROM DEPT4;

INSERT INTO DEPT4 (DEPTNO, LOC)
VALUES (3, '3');

-- 외래키를 만들기 위해서는 부모테이블 필요
-- 부모테이블 생성
CREATE TABLE DEPT5 (
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(15) NOT NULL
    );
    
-- 부모테이블 DEPT5를 참조하는 자식테이블
CREATE TABLE EMP(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL,
    DEPTNO NUMBER(2),
CONSTRAINT EMP_DEPT5_FK FOREIGN KEY(DEPTNO) 
    REFERENCES DEPT5(DEPTNO)
    );
    
SELECT * FROM DEPT5;

INSERT INTO DEPT5 (DEPTNO, DNAME) VALUES (1, '개발부');
INSERT INTO DEPT5 (DEPTNO, DNAME) VALUES (2, '기획부');
INSERT INTO DEPT5 (DEPTNO, DNAME) VALUES (3, '디자인');

COMMIT;

SELECT * FROM EMP;
INSERT INTO EMP (EMPNO, ENAME, DEPTNO) VALUES (1, '안준호', 1);
INSERT INTO EMP (EMPNO, ENAME, DEPTNO) VALUES (2, '조석봉', 3);

COMMIT;

DELETE FROM EMP WHERE EMPNO = 2;
ROLLBACK;

-- 자식레코드가 존재하여 삭제 실패
DELETE FROM DEPT5 WHERE DEPTNO = 1;

-- 제약조건 조회
SELECT * FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'EMP_DEPT5_FK';

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP';

-- 제약조건은 수정 불가능, 삭제만 가능합니다.
ALTER TABLE EMP DROP CONSTRAINT EMP_DEPT5_FK;

-- 제약조건 추가하기
ALTER TABLE EMP ADD(
    CONSTRAINT EMP_DEPT5_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT5(DEPTNO)
    );
    
SELECT * FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'SYS_C008360';