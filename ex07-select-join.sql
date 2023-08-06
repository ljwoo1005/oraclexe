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

COMMIT;

SELECT * FROM JOB_GRADES;
*/

/*
Monequijoin
    등호 연산자 외에 다른 연산자를 포함하는 조인 조건입니다.
*/
SELECT E.LAST_NAME, E.SALARY, J.GRADE_LEVEL
FROM employees E JOIN job_grades J
ON E.SALARY BETWEEN J.LOWEST_SAL AND J.HIGHEST_SAL;

/*
INNER JOIN과 OUTER JOIN
    INNER JOIN
        일치하지 않는 행은 출력에 표시되지 않습니다.(교집합 해당 행 출력)
    OUTER JOIN
        한 테이블의 행을 기반으로 다른 테이블과의 연결이 없는 행까지 포함하여 반환합니다.
*/

/*
LEFT OUTER JOIN
    DEPARTMENTS 테이블에 대응되는 행이 없어도
    왼쪽 테이블인 EMPLOYEES 테이블의 모든 행을 검색합니다.
    (INNER JOIN은 양쪽 모두 대응되는 행만을 출력한다.)
*/
SELECT E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM employees E
LEFT OUTER JOIN departments D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- 위와 아래는 같은 내용. 위가 ANSI 표준
SELECT E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM employees E, departments D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

/*
RIGHT OUTER JOIN
    EMPLOYEES 테이블에 대응되는 행이 없어도
    오른쪽 테이블인 DEPARTMENTS 테이블의 모든 행을 검색합니다.
*/
SELECT E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM employees E
RIGHT OUTER JOIN departments D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

/*
FULL OUTER JOIN
    DEPARTMENTS, EMPLOYEES 테이블에 대응되는 행이 없어도
    테이블의 모든 행을 검색합니다.
*/
SELECT E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM employees E
FULL OUTER JOIN departments D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID; 

/*
Cartesian Product
    조인 조건이 잘못되거나 완전히 생략된 경우 
    결과가 모든 행의 조합이 표시되는 Cartesian Product로 나타냅니다.
*/

/*
CROSS JOIN
    두 테이블의 교차 곱을 생성합니다.
*/
SELECT LAST_NAME, DEPARTMENT_NAME
FROM employees
CROSS JOIN departments;