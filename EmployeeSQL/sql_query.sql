create table title (
title_id varchar(10),
title varchar(30),
PRIMARY KEY(title_id)
);

select * from title 

create table employee (
emp_no integer  NOT NULL,
emp_title_id varchar(20)NOT NULL,
birth_date date NOT NULL,
first_name varchar(30)NOT NULL,
last_name varchar(30)NOT NULL,
sex varchar(10)NOT NULL,
hire_date date NOT NULL,
 PRIMARY KEY(emp_no),
 constraint fk_emp_title_id 
	FOREIGN KEY(emp_title_id) 
	 REFERENCES title(title_id)
);

select * from employee 

create table dept(
dept_no varchar(10),
dept_name varchar(30),
PRIMARY KEY(dept_no)
);

select * from dept 

create table dept_emp(
emp_no int,
dept_no varchar(10),
constraint fk_dept_no FOREIGN KEY(dept_no) REFERENCES dept(dept_no),
constraint fk_emp_no FOREIGN KEY(emp_no) REFERENCES employee(emp_no)
);

select * from dept_emp


create table dept_manager(
dept_no varchar(10),
emp_no int,
constraint fk_dept_no FOREIGN KEY(dept_no) REFERENCES dept(dept_no),
constraint fk_emp_no FOREIGN KEY(emp_no) REFERENCES employee(emp_no)
);

select * from dept_manager;

Create table salaries(
emp_no int,
salary int,
constraint fk_emp_no FOREIGN KEY(emp_no) REFERENCES employee(emp_no)
);

select * from salaries

--List the following details of each employee: employee number, last name, first name, sex, and salary.

select emp.emp_no,emp.last_name,emp.first_name,emp.sex,sal.salary from
employee as emp,salaries as sal Where emp.emp_no = sal.emp_no;

select emp.emp_no,emp.last_name,emp.first_name,emp.sex,sal.salary 
from
employee as emp inner join salaries as sal ON emp.emp_no = sal.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.

select first_name, last_name, hire_date from employee Where hire_date >= '1986-01-01' and hire_date <= '1986-12-31' order by hire_date ;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select dept.dept_no,dept.dept_name,manag.emp_no,emp.last_name,emp.first_name
from dept_manager as manag 
left join employee as emp ON manag.emp_no = emp.emp_no
left join dept ON manag.dept_no = dept.dept_no order by dept.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
select dept.dept_no,dept.dept_name,emp.emp_no,emp.last_name,emp.first_name
from dept_emp
left join employee as emp ON dept_emp.emp_no = emp.emp_no
left join dept ON dept_emp.dept_no = dept.dept_no order by dept.dept_no;

---List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name,last_name, sex 
from employee Where first_name = 'Hercules' and last_name like 'B%';

---List all employees in the Sales department, including their employee number, last name, first name, and department name.
select dept.dept_no,dept.dept_name,emp.emp_no,emp.last_name,emp.first_name
from dept_emp
left join employee as emp ON dept_emp.emp_no = emp.emp_no
left join dept ON dept_emp.dept_no = dept.dept_no where dept.dept_name ='Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select dept.dept_no,dept.dept_name,emp.emp_no,emp.last_name,emp.first_name
from dept_emp
left join employee as emp ON dept_emp.emp_no = emp.emp_no
left join dept ON dept_emp.dept_no = dept.dept_no where dept.dept_name ='Sales' or dept.dept_name ='Development' ;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT employee.last_name, COUNT(employee.last_name) AS "Last Name Count"
FROM employee
GROUP BY employee.last_name
ORDER BY "Last Name Count" DESC;

