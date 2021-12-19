# Pewlett Hackard Analysis

## Overview
- Management wanted two reports describing the company's upcoming retiring employees for a mentorship-eligibility proposal.
  -For the first report, we created three different retirement titles tables. We inner joined the titles and employee tables on the employee number and filtered the birth dates within the retirement range. The second table only contained unique employee numbers to show where which department they were retiring from. The third totaled up the number the employees about to retire from each department.
  - The second report inner joined three tables, listing unique employee numbers of candidates for the mentorship-eligibility program who are expected to retire in the next ten years.

## Results
1. Retirement Titles Report:
- The third table required the unique employee numbers from the second table to accurately total up the number of positions that are opening for each title. The first table could not be used because it contained duplicates of the employee number. Using `SELECT COUNT(emp_no) FROM retirement_titles` totals the employee numbers from the first table to be 133,776, where using `SELECT COUNT(emp_no) FROM unique_titles` has 90,398 unique employee numbers from the second table.

- The three tables do not show which departments anyone is retiring from.

2. Mentorship Eligibility Report:
-  The mentorship eligibility table contains the employees who are retiring next decade. It only filters by their birth date and their current positions, therefore, does not filter positions or departments that do not have many opening positions.

- Using `SELECT COUNT(emp_no) FROM mentorship_eligibility`, there are only 1549 employees that fall in the age criteria for mentorship, nowhere near enough employees to train 90,398 employees.

## Summary
- `SELECT COUNT(emp_no) FROM unique_titles` counts 90,398 openings will need to be filled.

- As mentioned in the 4th bullet of results, the birth date filter `WHERE ... (e.birth_date BETWEEN '1965-01-01'AND'1965-12-31')` is only set for 1965. There are only 1549 employees that fall in the age criteria for mentorship. Which is not enough to train for 90,000 openings.
- If the filter is expanded between 1962 and 1965, then 56,859 people become eligible. If it is expanded to start in 1960 then 93756 become eligible, but the number of Senior Engineer mentors is still only 9374 compared to the 30000 senior engineer openings seen here: ![mentors_to_openings](https://github.com/taherrin92/Pewlett-Hackard-Analysis/blob/main/Queries/Data/Challenge_Data/total_openings_to_mentors_1960.png)




- The search could be further refined by breaking down and comparing positions leaving each department to the number of mentors available in that position for a more accurate distribution.

  - Interesting side note, in the image shown here: ![employees_by_age](https://github.com/taherrin92/Pewlett-Hackard-Analysis/blob/main/Queries/Data/Challenge_Data/employees_by_year.png)


  - This group by query counts the employee number for each birth year, the emp_no doesn't even have to be unique to show that the youngest hire was born in 1962. The company needs to hire much younger employees before every single employees retires in a decade.