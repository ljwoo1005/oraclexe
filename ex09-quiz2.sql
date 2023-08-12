-- 1. �� ������ ��(last_name)�� �ش� ������ �Ŵ����� ������ ��(last_name) ��ȸ�ϱ�
select e.last_name employee , m.last_name manager
from employees e join employees m
on e.manager_id = m.employee_id;

-- 2. �� ������ ��(last_name)�� �ش� ������ �μ� �̸�(department_name) ��ȸ�ϱ�
select e.last_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- 3. �� �μ��� �̸�(department_name)�� �ش� �μ��� ��� �޿�(avg_salary) ��ȸ�ϱ�
select d.department_name, avg(e.salary) as avg_salary
from departments d join employees e
on d.department_id = e.department_id
group by d.department_name;

-- 4. �� �μ��� �̸�(department_name)�� �ش� �μ��� �ִ� �޿�(max_salary) ��ȸ�ϱ�
select d.department_name, max(e.salary) as max_salary
from departments d join employees e
on d.department_id = e.department_id
group by department_name;

-- 5. �� ������ ��(last_name)�� �ش� ������ ���� �μ��� �ּ� �޿�(min_salary) ��ȸ�ϱ�
-- �÷��� �ѹ��� ������ �ȵɶ��� ���� ���� select���� �ۼ��ؼ� �����Ѵ�.
select oe.last_name, od.min_salary
from employees oe
join (
    select d.department_id, min(e.salary) as min_salary
    from departments d
    join employees e on d.department_id = e.department_id
    group by d.department_id
    ) od
on oe.department_id = od.department_id;

-- 6. �� �μ��� �̸�(department_name)�� �ش� �μ��� ���� ���� �� ���� ���� �޿�(highest_salary) ��ȸ�ϱ�
select d.department_name, max(e.salary) as max_salary
from departments d join employees e
on d.department_id = e.department_id
group by department_name;

-- 7. �� ������ ��(last_name)�� �ش� ������ �Ŵ����� ��(last_name) �� �μ� �̸�(department_name) ��ȸ�ϱ�
select e.last_name, m.last_name, d.department_name
from employees e full outer join employees m
on e.manager_id = m.employee_id
join departments d
on e.department_id = d.department_id;

select e.last_name as worker_last_name, m.last_name as manager_last_name, d.department_name
from employees e
join employees m on e.manager_id = m.employee_id
join departments d on e.department_id = d.department_id;

-- 8. �� ������ ��(last_name)�� �ش� ������ ���� �μ��� �Ŵ����� ��(last_name) ��ȸ�ϱ�
select oe.last_name as w_last_name, om.last_name as m_last_name
from (
    select e.last_name, d.department_id, d.manager_id
    from employees e
    join departments d on e.department_id = d.department_id
    ) oe
join employees om on oe.manager_id = om.employee_id;

-- 10. ������ �߿��� �޿�(salary)�� 10000 �̻��� �������� ��(last_name)�� �ش� ������ �μ� �̸�(department_name) ��ȸ�ϱ�
select e.last_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id
and e.salary >= 10000;

/*
11.
�� �μ��� �̸�(department_name), �ش� �μ��� �Ŵ����� ID(manager_id)�� �Ŵ����� ��(last_name),
������ ID(employee_id), ������ ��(last_name), �׸��� �ش� ������ �޿�(salary) ��ȸ�ϱ�.
�������� �޿�(salary)�� �ش� �μ��� ��� �޿����� ���� �������� ��ȸ�մϴ�.
����� �μ� �̸��� ������ �޿��� ���� ������ ���ĵ˴ϴ�.
*/
select d.department_name, d.manager_id, m.last_name as m_last_name,
    e.employee_id, e.last_name as w_last_name, e.salary
from departments d
join employees m on d.manager_id = m.employee_id
join employees e on d.department_id = e.department_id
where e.salary > (
                -- �� �μ��� ��� �޿�
                select avg(e1.salary)
                from employees e1
                where e1.department_id = d.department_id -- �ٱ����� �̸� ������ departments ���̺��� id���� 
                                                         -- d.department_id�� �ϳ��� �����´� 
                                                         -- ���� departments d ���̺��� salary ��հ��� ���´�.
                )
order by d.department_name, e.salary desc
;

select d.department_name, d.manager_id, m.last_name as m_last_name,
    e.employee_id, e.last_name as w_last_name, e.salary
from departments d
join employees m on d.manager_id = m.employee_id
join employees e on d.department_id = e.department_id
join (
    -- �μ��� ��� �޿��� ���� ���̺��� join
    select department_id, avg(salary) as avg_salary
    from employees
    group by department_id
    ) da
on d.department_id = da.department_id
where e.salary > da.avg_salary
order by d.department_name, e.salary desc;
