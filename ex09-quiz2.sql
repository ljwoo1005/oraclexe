-- 1. 각 직원의 성(last_name)과 해당 직원의 매니저인 직원의 성(last_name) 조회하기
select e.last_name employee , m.last_name manager
from employees e join employees m
on e.manager_id = m.employee_id;

-- 2. 각 직원의 성(last_name)과 해당 직원의 부서 이름(department_name) 조회하기
select e.last_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

-- 3. 각 부서의 이름(department_name)과 해당 부서의 평균 급여(avg_salary) 조회하기
select d.department_name, avg(e.salary) as avg_salary
from departments d join employees e
on d.department_id = e.department_id
group by d.department_name;

-- 4. 각 부서의 이름(department_name)과 해당 부서의 최대 급여(max_salary) 조회하기
select d.department_name, max(e.salary) as max_salary
from departments d join employees e
on d.department_id = e.department_id
group by department_name;

-- 5. 각 직원의 성(last_name)과 해당 직원이 속한 부서의 최소 급여(min_salary) 조회하기
-- 컬럼이 한번에 연결이 안될때는 각각 따로 select문을 작성해서 결합한다.
select oe.last_name, od.min_salary
from employees oe
join (
    select d.department_id, min(e.salary) as min_salary
    from departments d
    join employees e on d.department_id = e.department_id
    group by d.department_id
    ) od
on oe.department_id = od.department_id;

-- 6. 각 부서의 이름(department_name)과 해당 부서에 속한 직원 중 가장 높은 급여(highest_salary) 조회하기
select d.department_name, max(e.salary) as max_salary
from departments d join employees e
on d.department_id = e.department_id
group by department_name;

-- 7. 각 직원의 성(last_name)과 해당 직원의 매니저의 성(last_name) 및 부서 이름(department_name) 조회하기
select e.last_name, m.last_name, d.department_name
from employees e full outer join employees m
on e.manager_id = m.employee_id
join departments d
on e.department_id = d.department_id;

select e.last_name as worker_last_name, m.last_name as manager_last_name, d.department_name
from employees e
join employees m on e.manager_id = m.employee_id
join departments d on e.department_id = d.department_id;

-- 8. 각 직원의 성(last_name)과 해당 직원이 속한 부서의 매니저의 성(last_name) 조회하기
select oe.last_name as w_last_name, om.last_name as m_last_name
from (
    select e.last_name, d.department_id, d.manager_id
    from employees e
    join departments d on e.department_id = d.department_id
    ) oe
join employees om on oe.manager_id = om.employee_id;

-- 10. 직원들 중에서 급여(salary)가 10000 이상인 직원들의 성(last_name)과 해당 직원의 부서 이름(department_name) 조회하기
select e.last_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id
and e.salary >= 10000;

/*
11.
각 부서의 이름(department_name), 해당 부서의 매니저의 ID(manager_id)와 매니저의 성(last_name),
직원의 ID(employee_id), 직원의 성(last_name), 그리고 해당 직원의 급여(salary) 조회하기.
직원들의 급여(salary)가 해당 부서의 평균 급여보다 높은 직원들을 조회합니다.
결과는 부서 이름과 직원의 급여가 높은 순으로 정렬됩니다.
*/
select d.department_name, d.manager_id, m.last_name as m_last_name,
    e.employee_id, e.last_name as w_last_name, e.salary
from departments d
join employees m on d.manager_id = m.employee_id
join employees e on d.department_id = e.department_id
where e.salary > (
                -- 각 부서의 평균 급여
                select avg(e1.salary)
                from employees e1
                where e1.department_id = d.department_id -- 바깥에서 미리 구해진 departments 테이블의 id값을 
                                                         -- d.department_id로 하나씩 가져온다 
                                                         -- 따라서 departments d 테이블의 salary 평균값이 나온다.
                )
order by d.department_name, e.salary desc
;

select d.department_name, d.manager_id, m.last_name as m_last_name,
    e.employee_id, e.last_name as w_last_name, e.salary
from departments d
join employees m on d.manager_id = m.employee_id
join employees e on d.department_id = e.department_id
join (
    -- 부서별 평균 급여를 가진 테이블을 join
    select department_id, avg(salary) as avg_salary
    from employees
    group by department_id
    ) da
on d.department_id = da.department_id
where e.salary > da.avg_salary
order by d.department_name, e.salary desc;
