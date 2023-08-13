/*
���ϸ� : ex14-DDL.sql

DDL(Data Definition Language) - ������ ���Ǿ�
    �����ͺ��̽� ���� ���� �� ��ü(���̺�, ������ ��)�� ����, ����, �����ϱ� ���� ���Ǵ� SQL���Դϴ�.
*/

/*
CREATE TABLE��
    �����͸� ������ ���̺��� �����մϴ�.
    
    CREATE TABLE ���̺�� (
    �÷��� �÷�Ÿ��
    );
    
*/

CREATE TABLE DEPT (
    DEPTNO NUMBER(6), -- ���� 6�ڸ�����
    DNAME VARCHAR2(200), -- ���� 200BYTE����
    LOC VARCHAR2(200),
    CREATE_DATE DATE DEFAULT SYSDATE
    );
    
DESC DEPT;

/*
������ ����
    VARCHAR2(size) : ���� ���� ���� ������ (�ִ� 4000byte���� ����)
    NUMBER(p,s) : ���� ���� ���� ������ (p�� ���� �ڸ�, s�� �Ҽ��� �ڸ�)
    CHAR(size) : ���� ���� ���� (�ִ� 2000byte���� ����)
    DATE : ��¥ �� �ð���
    CLOB : ���� ������ (�ִ� 4GB���� ����)
    BLOB : ���̳ʸ� ������(�ִ� 4GB���� ����, ������ ����)
    BFILE : ���� ��ġ�� ��Ÿ������ ����(�ִ� 4GB���� ����)
*/

-- DEPARTMENTS ���̺��� �����͸� DEPT ���̺� �����ϱ�
INSERT INTO DEPT
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, SYSDATE
FROM DEPARTMENTS;

/*
CTAS�� "Create Table As Select"�� ���ڷ�,
�����ͺ��̽����� ���ο� ���̺��� �����ϴ� ����Դϴ�.
�� ����� ���� ���̺��� SELECT���� ����Ͽ� �����͸� ��ȸ�� ��,
�� ����� ���ο� ���̺�� �����ϴ� ����Դϴ�.
*/

-- ���̺� �����ϱ� => ���������� ���簡 �ȵȴ�.
CREATE TABLE DEPT2 AS SELECT * FROM DEPT;
DESC DEPT2;

SELECT * FROM DEPT2;

-- ���̺� ������ �����ϱ�(������ �׻� ������ �Ǵ� ��� ���)
CREATE TABLE DEPT3 AS SELECT * FROM DEPT WHERE 1=2;

/*
ALTER��
    �����ͺ��̽� ��ü ������ �Ӽ��� ������ �� ���Ǵ� SQL ��ɹ��Դϴ�.
*/

CREATE TABLE SIMPLE(num NUMBER);

SELECT * FROM SIMPLE;

-- �÷� �߰��ϱ�
ALTER TABLE SIMPLE ADD(NAME VARCHAR2(3));

-- �÷� �����ϱ�
ALTER TABLE SIMPLE MODIFY(NAME VARCHAR2(30));

-- �÷� �����ϱ�
ALTER TABLE SIMPLE DROP COLUMN NAME;

ALTER TABLE SIMPLE ADD(ADDR VARCHAR(50));
ALTER TABLE SIMPLE DROP(ADDR);

DESC SIMPLE;

-- DROP�� : ��ü�� ������ �� ���Ǵ� SQL ��ɹ��Դϴ�.
-- ���̺� ����
DROP TABLE SIMPLE;

/*
��������(Constraint)
    ���̺��� �ش� �÷��� ������ �ʴ� �����͸� �Է�/����/�����Ǵ� ���� �����ϱ� ����
    ���̺� ���� �Ǵ� ����� �����ϴ� �����Դϴ�.(����� �������� �ŷڼ��� ���̱� ����)
    
    NOT NULL
        NULL�� �Է��� �Ǿ�� �ȵǴ� �÷��� �ο��ϴ� ��������
        �÷� ���������� �ο��� �� �ִ� ���������Դϴ�.
    UNIQUE KEY(����Ű)
        ����� ���� �ߺ����� �ʰ� ���� �����ϰ� �����Ǿ�� �� �� ����ϴ� ���������Դϴ�.
        (NULL���� ���ȴ�.)
    PRIMARY KEY(��ǥŰ, �⺻Ű)
        NOT NULL ���ǰ� UNIQUE KEY ������ ��ģ �����Դϴ�.
    CHECK
        ���ǿ� �´� �����͸� �Էµǵ��� ������ �ο��ϴ� ���������Դϴ�.
    FOREIGN KEY(�ܷ�Ű, ����Ű)
        �θ� ���̺��� PRIMARY KEY�� �����ϴ� �÷��� ���̴� ���������Դϴ�.
*/

CREATE TABLE DEPT4(
    DEPTNO NUMBER(2) CONSTRAINT DEPT4_DEPTNO_PK PRIMARY KEY, -- ���������̸� DEPT4_DEPTNO_PK
    DNAME VARCHAR2(15) DEFAULT '������', -- ���� �������� �ʾ��� �� '������'�� ����.
    LOC CHAR(1) CONSTRAINT DEPT4_LOC_CK CHECK(LOC IN('1','2')) -- '1'�� '2'�� �� �� �ִ�.
);

SELECT * FROM DEPT4;

INSERT INTO DEPT4 (DEPTNO, LOC)
VALUES (3, '3');

-- �ܷ�Ű�� ����� ���ؼ��� �θ����̺� �ʿ�
-- �θ����̺� ����
CREATE TABLE DEPT5 (
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(15) NOT NULL
    );
    
-- �θ����̺� DEPT5�� �����ϴ� �ڽ����̺�
CREATE TABLE EMP(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(15) NOT NULL,
    DEPTNO NUMBER(2),
CONSTRAINT EMP_DEPT5_FK FOREIGN KEY(DEPTNO) 
    REFERENCES DEPT5(DEPTNO)
    );
    
SELECT * FROM DEPT5;

INSERT INTO DEPT5 (DEPTNO, DNAME) VALUES (1, '���ߺ�');
INSERT INTO DEPT5 (DEPTNO, DNAME) VALUES (2, '��ȹ��');
INSERT INTO DEPT5 (DEPTNO, DNAME) VALUES (3, '������');

COMMIT;

SELECT * FROM EMP;
INSERT INTO EMP (EMPNO, ENAME, DEPTNO) VALUES (1, '����ȣ', 1);
INSERT INTO EMP (EMPNO, ENAME, DEPTNO) VALUES (2, '������', 3);

COMMIT;

DELETE FROM EMP WHERE EMPNO = 2;
ROLLBACK;

-- �ڽķ��ڵ尡 �����Ͽ� ���� ����
DELETE FROM DEPT5 WHERE DEPTNO = 1;

-- �������� ��ȸ
SELECT * FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'EMP_DEPT5_FK';

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMP';

-- ���������� ���� �Ұ���, ������ �����մϴ�.
ALTER TABLE EMP DROP CONSTRAINT EMP_DEPT5_FK;

-- �������� �߰��ϱ�
ALTER TABLE EMP ADD(
    CONSTRAINT EMP_DEPT5_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT5(DEPTNO)
    );
    
SELECT * FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'SYS_C008360';