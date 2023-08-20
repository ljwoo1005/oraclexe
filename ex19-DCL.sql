/*
���ϸ� : ex19-DCL.sql

DCL(Data Control Language)
    DCL�� ���̺� �����͸� ������ �� �ʿ��� ������ �����ϴ� ��ɾ�

���� Ű����
    CONNECT : �����ͺ��̽��� �����ϴ� ������ �����մϴ�.
    RESOURCE : ���̺�, ������, ���ν��� ���� ������ �� �ִ� ������ �ο��մϴ�.
    ALTER, DROP : ��ü�� ���� �Ǵ� ���� ������ �����մϴ�.
    DBA : �����ͺ��̽� �����ڷμ� �ý����� ������ ������ �� �ִ� ������ �ο��մϴ�.
*/

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- ����� �����ϱ�
CREATE USER SCOTT2 IDENTIFIED BY TIGER;

-- GRANT ��ɾ�� ���� �����ֱ�
GRANT CREATE SESSION TO SCOTT2;
GRANT CONNECT TO SCOTT2;

-- GRANT ���� ���� �����ϱ�
REVOKE CREATE SESSION FROM SCOTT2;
REVOKE CONNECT FROM SCOTT2;

-- OBJECT �����ֱ�
GRANT CREATE SEQUENCE TO SCOTT2;
GRANT CREATE SYNONYM TO SCOTT2;
GRANT CREATE TABLE TO SCOTT2;
GRANT CREATE PROCEDURE TO SCOTT2;
GRANT CREATE VIEW TO SCOTT2;

-- ��� �����ֱ�
GRANT CONNECT, DBA, RESOURCE TO SCOTT2;

-- ���� �����ϱ�
REVOKE CONNECT, DBA, RESOURCE FROM SCOTT2;

-- ����� ��й�ȣ ����
ALTER USER SCOTT2 IDENTIFIED BY TIGER2;

/*
ROLE - ���� �׷�
*/

-- ROLE �������
CREATE ROLE ROLE01;

-- ROLE ���� �Ҵ�
GRANT CREATE SESSION, CREATE TABLE, INSERT ANY TABLE TO ROLE01;

-- ����ڿ��� ROLE �ο�
GRANT ROLE01 TO SCOTT2;
REVOKE ROLE01 FROM SCOTT2;

-- ����� �����ϱ�
DROP USER SCOTT2;
DROP USER SCOTT2 CASCADE; -- SCOTT2�� ���õǾ��ִ� ��� ��ü����� ���� ����