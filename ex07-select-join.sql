/*
파일명 : ex07-select-join.sql

JOIN    
    SQL에서 두 개 이상의 테이블에서 관련된 행들을 결합하기 위한 연산입니다.
*/

/*
Natural Join
    두 테이블에서 데이터 유형과 이름이 일치하는 열을 기반으로 자동으로 테이블을 조인할 수 있습니다.
*/
SELECT DEPARTMENT_ID, DEPARTMENT_NAME,
        LOCATION_ID, CITY
FROM departments
NATURAL JOIN locations;

/*
USING 절로 조인
    명시적으로 결합을 수행하고자 하는 열을 정해줍니다.
*/
SELECT EMPLOYEE_ID, LAST_NAME, 
        LOCATION_ID, DEPARTMENT_ID
FROM employees JOIN departments
USING (DEPARTMENT_ID);

/*
ON 절로 조인
    ON 절을 사용하여 조인 조건을 지정합니다.
*/
SELECT e.EMPLOYEE_ID, e.LAST_NAME, e.DEPARTMENT_ID,
        d.DEPARTMENT_ID, d.LOCATION_ID
FROM employees e JOIN departments d
ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID);
-- 위와 아래는 같은 내용. 위가 ANSI 표준. 오라클에서는 밑에꺼가 가능
SELECT E.EMPLOYEE_ID, E.LAST_NAME,
    E.DEPARTMENT_ID, D.LOCATION_ID
FROM employees e, departments d
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID; -- where절이 on절을 대신함

-- ON 절 사용하여 3-Way 조인
SELECT e.EMPLOYEE_ID, l.CITY, d.DEPARTMENT_NAME
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id; -- SELECT에서 조인할 컬럼을 꼭 명시하진 않아도 된다. 테이블끼리 서로 겹치는 컬럼만 잘 보고 조인하면 됨.

-- 조인에 추가 조건 적용
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.DEPARTMENT_ID,
    D.DEPARTMENT_ID, D.LOCATION_ID
FROM employees E JOIN departments D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.MANAGER_ID = 149; -- AND로 조건 추가. WHERE로도 가능하다.

/*
테이블 자체 조인
    ON 절을 사용하는 Self Join
*/
SELECT WORKER.LAST_NAME WORKER_LAST_NAME, MANAGER.LAST_NAME MANAGER_LAST_NAME
FROM employees WORKER JOIN employees MANAGER
ON WORKER.MANAGER_ID = MANAGER.EMPLOYEE_ID;

/*
Monequijoin
    등호 연산자 외에 다른 연산자를 포함하는 조인 조건입니다.
*/

CREATE TABLE JOB_GRADES (
GRADE_LEVEL CHAR(1),
LOWEST_SAL NUMBER(8,2) NOT NULL,
HIGHEST_SAL NUMBER(8,2) NOT NULL
);

ALTER TABLE JOB_GRADES
ADD CONSTRAINT JOBGRADES_GRADE_PK PRIMARY KEY (GRADE_LEVEL);

INSERT INTO JOB_GRADES VALUES ('A', 1000, 2999);
INSERT INTO JOB_GRADES VALUES ('B', 3000, 5999);
INSERT INTO JOB_GRADES VALUES ('C', 6000, 9999);
INSERT INTO JOB_GRADES VALUES ('D', 10000, 14999);
INSERT INTO JOB_GRADES VALUES ('E', 15000, 24999);
INSERT INTO JOB_GRADES VALUES ('F', 25000, 40000);