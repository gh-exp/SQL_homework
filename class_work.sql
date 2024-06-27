-- 1. Find the employees who have been with the company for more than 10 years. Return employee ID, first name, last name, and hire date.
-- Firsw WAY 
select e.employee_id,
       e.first_name,
       e.last_name,
       e.hire_date,
       js.start_date
  from employees e
  join job_history js
on e.employee_id = js.employee_id
 where sysdate - js.start_date >= 3650;

-- Second WAY
select employee_id,
       first_name,
       last_name,
       hire_date
  from employees
 where sysdate - hire_date >= 3650;

-- 2. Write a query to display the department ID, department name, and the number of employees in each department that has more than 5 employees.
select d.department_id,
       d.department_name,
       count(e.employee_id) as num_employees
  from departments d
  join employees e
on d.department_id = e.department_id
 group by d.department_id,
          d.department_name
having count(e.employee_id) > 5;

 
-- 3. Find the employees who do not have a department assigned. Return first name, last name, and employee ID.
select first_name,
       last_name,
       employee_id,
       department_id
  from employees
 where department_id is null;

-- 4. Display the employee ID, first name, last name, and salary for all employees who work in the 'IT' department and earn less than the average salary of the 'IT' department.
select e.employee_id,
       e.first_name,
       e.last_name,
       e.salary,
       d.department_name
  from employees e
  join departments d
on e.department_id = d.department_id
 where d.department_name = 'IT'
   and salary < (
	select avg(salary)
	  from employees e
	  join departments d
	on e.department_id = d.department_id
	 where d.department_name = 'IT'
);

-- 5. Write a query to find the average salary for each job title. Return job title and average salary.
select j.job_title,
       avg(salary)
  from employees e
  join jobs j
on e.job_id = j.job_id
 group by j.job_title;

-- 6. Display the first name, last name, and department name for all employees who have a manager with the last name 'Weiss'.
select e.first_name,
       e.last_name,
       d.department_name
  from employees e
  join departments d
on e.department_id = d.department_id
  join employees m
on e.manager_id = m.employee_id
 where m.last_name = 'Weiss'; 

-- 7. Write a query to find the departments that do not have any employees. Return department ID and department name.
select d.department_id,
       d.department_name,
       count(e.employee_id) as num_employees
  from departments d
  left join employees e
on d.department_id = e.department_id
 group by d.department_id,
          d.department_name
having count(e.employee_id) = 0;

-- 8. Write a query to display the employee ID, first name, last name, and hire date for all employees hired in the last 25 years.
select employee_id,
       first_name,
       last_name,
       hire_date
  from employees
 where sysdate - hire_date < 9125;

-- 9. Find the employees whose first name starts with 'A' and who work in departments located in 'California'. Return first name, last name, department ID, and department name.
select e.first_name,
       e.last_name,
       e.department_id,
       d.department_name
  from employees e
  join departments d
on e.department_id = d.department_id
  join locations l
on d.location_id = l.location_id
 where l.state_province = 'California'
   and e.first_name like 'A%';

-- 10. Display the first name, last name, and the number of years each employee has been with the company.
select first_name,
       last_name,
       hire_date,
       round(
	       (sysdate - hire_date) / 365,
	       0
       ) as years
  from employees;

-- 11. Write a query to display the department name and the total salary for all departments where the total salary is greater than $50,000.
select d.department_name,
       sum(salary)
  from employees e
 right join departments d
on e.department_id = d.department_id
 group by department_name
having sum(salary) > 50000;

-- 12. Find the employees who work in the 'Marketing' department and have a salary that is more than the average salary of the 'Marketing' department. Return first name, last name, and salary.
select e.first_name,
       e.last_name,
       e.salary
  from employees e
  join departments d
on e.department_id = d.department_id
 where d.department_name = 'Marketing'
   and salary > (
	select avg(salary)
	  from employees e
	  join departments d
	on e.department_id = d.department_id
	 where d.department_name = 'Marketing'
);
-- 13. Display the department name, and the highest salary in each department.
select d.department_name,
       max(salary)
  from employees e
 right join departments d
on e.department_id = d.department_id
 group by department_name;
