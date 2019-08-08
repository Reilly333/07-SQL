
/*Create a table schema for department.csv*/
CREATE TABLE departments (
	dept_no VARCHAR(4),
	dept_name VARCHAR(20),
	PRIMARY KEY (dept_no)
);

SELECT *
FROM departments;

/*Create a table schema for dept_emp.csv*/

CREATE TABLE dept_emp (
	emp_no INT REFERENCES employees(emp_no),
	dept_no VARCHAR(4) REFERENCES departments(dept_no),
	from_date DATE,
	to_date DATE
);

SELECT *
FROM dept_emp
	
/*Create a table schema for dept_manager.csv*/

CREATE TABLE dept_manager (
	dept_no VARCHAR(30),
	emp_no int VARCHAR(10),
	from_date date VARCHAR(10),
	to_date date,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM dept_manager

/*Create a table schema for employee.csv*/

CREATE TABLE employees (
	emp_no int,
	birth_date date(10),
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	gender VARCHAR(1),
	hire_date date(10),
	PRIMARY KEY (emp_no)
);

SELECT *
FROM employees

/*Create a table schema for salaries.csv*/

CREATE TABLE salaries (
	emp_no int,
	salaries int,
	from_date date(10),
	to_date date(10),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM salaries

/*Create a table schema for titles.csv*/

CREATE TABLE titles (
	emp_no int,
	title VARCHAR(20),
	from_date date(10),
	to_date date(10),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT *
FROM titles





/* List the following details of each employee: employee number, last name, first name, gender, and salary. */

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
Left JOIN salaries AS s
	ON e.emp_no = s.emp_no
;

-----------------------------------------------------------------------
-- List employees who were hired in 1986.

SELECT * 
FROM employees
WHERE hire_date > '1986-01-31' AND hire_date < '1987-01-01';
;

-----------------------------------------------------------------------
/* List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates. */

SELECT dp.dept_no, dp.dept_name, m.emp_no, e.first_name, e.last_name, m.hire_date, m.to_date
FROM departments AS dp
Left JOIN employees AS e
	ON m.emp_no = e.emp_no
Left JOIN dept_manager AS dp
	ON m.dept_no = dp.dept_no
WHERE m.to_date = '9999-01-01'
;

-----------------------------------------------------------------------
/* List the department of each employee with the following information: employee number, last name, first name, and department name. */

SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees e
Left JOIN dept_emp AS de1
	ON e.emp_no = de1.emp_no
Left JOIN departments AS dp
	ON de1.dept_no = dp.dept_no
;

-----------------------------------------------------------------------
/* List all employees whose first name is "Hercules" and last names begin with "B." */

SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'Hercules' AND last_name LIKE 'B%'
;

-----------------------------------------------------------------------
/* List all employees in the Sales department, including their employee number, last name, first name, and department name. */

SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name 
FROM employees AS e
Left JOIN dept_emp AS de1
	ON e.emp_no = de1.emp_no
Left JOIN departments AS dp
	ON de1.emp_no = dp.depr_no
WHERE dp.dept_name = 'Sales'
;

-----------------------------------------------------------------------
/* List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name. */

SELECT emp.emp_no, emp.last_name, emp.first_name, dp.dept_name 
FROM employees AS e
Left JOIN dept_emp AS de1
	ON e.emp_no = de1.emp_no
Left JOIN departments as dp
	ON dp.emp_no = de1.emp_no
WHERE dp.dept_name = 'Sales' 
OR dp.dept_name = 'Development'
;

-----------------------------------------------------------------------
/* In descending order, list the frequency count of employee last names, i.e., how many employees share each last name. */

SELECT last_name, COUNT(*) AS freq_count
FROM employees
GROUP BY last_name
ORDER BY COUNT(*) DESC
;
-----------------------------------------------------------------------