SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM titles AS t
INNER JOIN employees AS e
ON (t.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no,
to_date DESC;

SELECT COUNT(title) total_openings, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY total_openings DESC;

--Deliverable 2

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
	ON(e.emp_no = de.emp_no)
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01'AND'1965-12-31')
ORDER BY e.emp_no ASC;


---Deliverable 3

--Counts total upcoming openings 
SELECT COUNT(emp_no) total_openings
FROM unique_titles;
SELECT * FROM retiring_titles;


--Creates a table including salary and department name

SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
t.title,
d.dept_name
INTO department_retirement
FROM employees AS e
INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no)
INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE (e.birth_date BETWEEN '1952-01-01'AND'1955-12-31');
select count(emp_no) from department_retirement

SELECT COUNT(emp_no) total_openings,
title
FROM department_retirement
GROUP BY title
ORDER BY total_openings;

-- -----------------------------------------------

--Refactored mentorship_eligibility query to include department name
--Between 1962 and 1965
drop table mentorship_department;
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
t.title,
d.dept_name
INTO mentorship_department
FROM employees AS e
INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no)
INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1960-01-01'AND'1965-12-31');

--total mentors in departments born from 1962 to 1965
drop table mentor_count;
SELECT COUNT(emp_no) mentors,
title
INTO mentor_count
FROM mentorship_department
GROUP BY title
ORDER BY mentors;

drop table mentors_to_openings;
SELECT rt.total_openings,
mc.mentors,
rt.title
INTO mentors_to_openings
FROM retiring_titles AS rt
INNER JOIN mentor_count AS mc ON rt.title = mc.title;

select * from mentors_to_openings

-- -----------------------------------------------

--Extracts birth year and groups by birth year to find youngest employees
SELECT
	EXTRACT(year FROM birth_date) AS year,
	COUNT(emp_no) AS employees
INTO employee_birth_year
FROM mentorship_department
GROUP BY year
ORDER BY year DESC;


	
	