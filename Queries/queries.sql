SELECT first_name,last_name,title
FROM employees as e
LEFT JOIN titles as t ON e.emp_no = t.emp_no;

SELECT first_name,last_name,dept_no,title
FROM employees as e
LEFT JOIN dept_emp as de ON e.emp_no = de.emp_no
LEFT JOIN titles as t ON e.emp_no = t.emp_no;

DROP TABLE retirement_info;

SELECT emp_no,first_name,last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;
SELECT * FROM departments;

SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de ON ri.emp_no = de.emp_no;

DROP TABLE IF EXISTS current_emp;
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
SELECT * FROM current_emp;

SELECT COUNT (ce.emp_no),de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
on ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

DROP TABLE IF EXISTS emp_info;
SELECT e.emp_no,e.first_name,e.last_name, e.gender,s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s 
ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
SELECT * FROM emp_info; 

SELECT dm.dept_no,
d.dept_name,
dm.emp_no,
ce.last_name,
ce.first_name,
dm.from_date,
dm.to_date
-- INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);

SELECT ce.emp_no,ce.first_name,ce.last_name,d.dept_name
--INTO retirement_list
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

SELECT e.emp_no, e.first_name,e.last_name,d.dept_no
--INTO sales_list
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE dept_name IN ('Sales','Development');

SELECT * FROM departments;





