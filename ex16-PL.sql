/*
파일명 : ex16-PL.sql

PL/SQL(Procedual Language extension to SQL)
    SQL을 확장한 절차적 언어 입니다.
    여러 SQL을 하나의 블록(block)으로 구성하여 SQL을 제어할 수 있습니다.
    
프로시저(Procedure)
    데이터베이스에서 실행가능한 하나 이상의 SQL문을 묶어서 
    하나의 논리적 작업단위로 만든 데이터베이스 객체입니다.
    보통 여러 명령문을 한꺼번에 실행해야할 때 자주 사용합니다.
*/

/*
익명 프로시저 -- 일회용 프로시저. DB에 저장되지 않습니다.
[기본구조]
    DECLARE - 변수정의
    BEGIN - 처리 로직 시작
    EXCEPTION - 예외처리
    END - 처리 로직 종료
*/

-- 실행결과를 출력하도록 설정
SET SERVEROUTPUT ON;

-- 스크립트 경과 시간을 출력하도록 설정
SET TIMING ON;

DECLARE -- 변수 정의
    V_STRD_DT       VARCHAR2(8);
    V_STRD_DEPTNO   NUMBER;
    V_DEPTNO        NUMBER;
    V_DNAME         VARCHAR2(50);
    V_LOC           VARCHAR2(50);
    V_RESULT_MSG    VARCHAR2(500) DEFAULT 'SUCCESS';
BEGIN -- 로직 시작
    V_STRD_DT := TO_CHAR(SYSDATE, 'YYYYMMDD');
    V_STRD_DEPTNO := 10;

    SELECT T1.department_id
         , T1.department_name
         , T1.location_id
      INTO V_DEPTNO
         , V_DNAME
         , V_LOC
      FROM departments T1
     WHERE T1.department_id = V_STRD_DEPTNO;

    --조회 결과 변수 설정
    V_RESULT_MSG := 'RESULT > DEPTNO='||V_DEPTNO||', DNAME='||V_DNAME||', LOC='||V_LOC;
    --조회 결과 출력
    DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
EXCEPTION --예외 처리
    WHEN VALUE_ERROR THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], VALUE_ERROR_MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
    WHEN OTHERS THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
END;
/
-- 작업종료

/*
프로시저
[기본구조]
CREATE OR REPLACE PRECEDURE 프로시저 이름 (파라미터1, 파라미터2 ...)
    IS 또는 AS
        [선언부]
    BEGIN
        [실행부]
    [EXCEPTION]
        [EXCEPTION 처리]
    END;
    /
대괄호 부분은 생략 가능
*/

CREATE OR REPLACE PROCEDURE PRINT_HELLO_PROC -- 매개변수가 없으면 () 생략 가능
    IS -- 프로시저 시작
        MSG VARCHAR2(20) := 'hello world'; -- 변수 초기값 선언
    BEGIN -- 실행문 시작
        DBMS_OUTPUT.PUT_LINE(MSG);
    END; 
/

EXEC PRINT_HELLO_PROC; -- EXEC : 프로시저 실행 키워드

/*
IN 매개변수
    값이 프로시저 안으로 들어감
*/

CREATE TABLE EMP2 AS
SELECT EMPLOYEE_ID EMPNO, LAST_NAME NAME, SALARY, DEPARTMENT_ID DEPNO
FROM EMPLOYEES;

SELECT * FROM EMP2;

CREATE OR REPLACE PROCEDURE UPDATE_EMP_SALARY_PROC(eno IN NUMBER)
    IS 
    BEGIN
        UPDATE EMP2 SET 
        SALARY = SALARY * 1.1
        WHERE EMPNO = eno;
        COMMIT;
    END;
/
-- DML문을 넣을 땐 커밋을 반드시 해줘야 한다.

SELECT * FROM EMP2
WHERE EMPNO = 115; -- SALARY 3100

EXEC UPDATE_EMP_SALARY_PROC(115); -- 실행하니까 SALARY 3410

/*
OUT 매개변수
    프로시저의 반환값이 없으므로 OUT 매개변수로 값을 받을 수 있다.
    참조형 매개변수와 비슷
*/
CREATE OR REPLACE PROCEDURE find_emp_proc(v_eno IN NUMBER,
        v_fname OUT NVARCHAR2, v_lname OUT NVARCHAR2, v_sal OUT NUMBER)
IS 
    BEGIN
        SELECT first_name, last_name, salary
        INTO v_fname, v_lname, v_sal
        FROM employees WHERE employee_id = v_eno;
    END;
/
-- VARCHAR2(바이트) NVARCHAR2(문자길이) 차이
VARIABLE v_fname NVARCHAR2(25);
VARIABLE v_lname NVARCHAR2(25);
VARIABLE v_sal NUMBER;

EXECUTE find_emp_proc(115, :v_fname, :v_lname, :v_sal);
PRINT v_fname;
PRINT v_lname;
PRINT v_sal;

/*
IN OUT 매개변수
    IN OUT 동시에 사용할 수 있는 매개변수 입니다.
*/

CREATE OR REPLACE PROCEDURE FIND_SAL(V_IO IN OUT NUMBER)
IS 
    BEGIN
    SELECT SALARY
    INTO V_IO
    FROM EMPLOYEES WHERE EMPLOYEE_ID = V_IO;
    END;
/

DECLARE
    V_IO NUMBER := 115;
    BEGIN
    DBMS_OUTPUT.PUT_LINE('ENO='||V_IO);
    FIND_SAL(V_IO);
    DBMS_OUTPUT.PUT_LINE('SALARY='||V_IO);
    END;
/

VAR V_IO NUMBER;
EXEC :V_IO := 115;
PRINT V_IO;
EXEC FIND_SAL(:V_IO);
PRINT V_IO;

/*
함수(Function)
    특정 기능들을 모듈화, 재사용할 수 있게 복잡한 쿼리문을 간결하게 만들 수 있습니다.
    RETURN값을 가지며 쿼리문에 직접 사용할 수 있습니다.
[기본구조]
CREATE OR REPLACE FUNCTION 함수이름 (파라미터1, 파라미터2 ...)
RETURN datatype - 반환되는 값의 유형
    IS 또는 AS - 선언부
    BEGIN
        [실행부 - PL/SQL 블럭]
    [EXCEPTION]
        [EXCEPTION 처리]
    RETURN 변수;
    END;
/
*/
CREATE OR REPLACE FUNCTION FN_GET_DEPT_NAME(P_DEPT_NO NUMBER)
RETURN VARCHAR2
    IS
        V_TEST_NAME VARCHAR2(30);
    BEGIN
        SELECT DEPARTMENT_NAME
        INTO   V_TEST_NAME
        FROM   DEPARTMENTS
        WHERE  DEPARTMENT_ID = P_DEPT_NO;
        
    RETURN V_TEST_NAME;
    END;
/

SELECT FN_GET_DEPT_NAME(10) FROM DUAL;