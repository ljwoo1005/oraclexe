/*
���ϸ� : ex09-select-hierarchical.sql

��������
    Ʈ�� ������ ������ �����Ϳ��� �θ�-�ڽ� ���踦 ���� �����ϴµ� ���Ǵ� SQL
    �ַ� ������, ������ ������, ������ �ּ� � Ȱ��˴ϴ�.
    ����Ŭ���� ��� �����ϴ�.
    
���� Ű����
    START WITH : ���� ������ ���� ������ �����մϴ�. �ֻ��� �θ� ��带 �����մϴ�.
    CONNECT BY : �θ�-�ڽ� ���踦 �����ϴ� Ű�����, PRIOR Ű����� �Բ� ���˴ϴ�.
    PRIOR : �θ�-�ڽ� ���踦 ǥ���ϴ� Ű����� �ڽ� �÷� �տ� ���˴ϴ�.
    NOCYCLE : ����Ŭ�� ������� �ʵ��� �����ϴ� �ɼ��Դϴ�.
    LEVEL : �� ������ ���̸� ��Ÿ���� �ǻ� �÷����� ���˴ϴ�.
    SYS_CONNECT_BY_PATH : ���� ������ ��θ� ���ڿ��� ǥ�����ִ� �Լ��Դϴ�.
    ORDER SIBLINGS BY : ���� ������ �����ϴµ� ���˴ϴ�.
*/

-- id, name, manager_id, depth

SELECT
    E.EMPLOYEE_ID,
    E.LAST_NAME,
    E.MANAGER_ID,
    LEVEL AS depth, -- depth�� ��Ÿ���� ������ �÷� ����
    LPAD(' ', LEVEL * 2 - 2) || SYS_CONNECT_BY_PATH(E.LAST_NAME, '/') AS hierarchy_path 
                                -- ���� ������ last_name�� �̿��Ͽ� ��Ÿ��
FROM 
    EMPLOYEES E
START WITH
    E.MANAGER_ID IS NULL
CONNECT BY
    PRIOR E.EMPLOYEE_ID = E.MANAGER_ID -- �ڽ��÷� �տ� PRIOR Ű����
ORDER SIBLINGS BY E.EMPLOYEE_ID -- ���� ��峢���� EMPLOYEE_ID�� ����
;
