#Objective: Extract salary-related insights for employees numbered between 10500 and 10600 inclusive, 
#focusing on past, current, and future salary values, with differences calculated for meaningful analysis.

#Step 1: Database Selection
USE employees;
#This command sets the context for the query, ensuring all table references come from the employees database.

#Step 2: SELECT Clause
SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_current_previous_salary,
    LEAD(salary) OVER w - salary AS diff_current_next_salary

#emp_no and salary are selected as core data points.
#LAG(): This window function retrieves the previous salary for the employee in the ordered sequence, helping identify trends or increments.
#LEAD(): This window function retrieves the subsequent salary for the employee in the ordered sequence.

#The calculated columns:
#salary - LAG(salary) computes the difference between the current salary and the previous salary.
#LEAD(salary) - salary computes the difference between the next salary and the current salary.

#Step 3: FROM Clause
FROM 
	salaries
#Specifies the salaries table as the source of the data.

#Step 4: WHERE Clause:
WHERE emp_no > 8000 BETWEEN 10500 AND 10600
#Filters the data to include only employees with employee numbers between 10500 and 10600
#The condition ensures focus only on the relevant employee records for meaningful analysis.

#Step 5: WINDOW Clause
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);
#PARTITION BY emp_no groups data by individual employees, ensuring the LAG() and LEAD() functions analyze salaries within each employee’s salary history.
#ORDER BY salary sorts salaries in ascending order within each employee’s salary history, ensuring the sequence is logical and meaningful.


#Final Result:
#The query returns:
SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_current_previous_salary,
    LEAD(salary) OVER w - salary AS diff_current_next_salary
FROM 
	salaries
WHERE emp_no > 8000 BETWEEN 10500 AND 10600
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

#emp_no: Employee number
#salary: Current salary
#previous_salary: The previous salary value in the ordered list for that employee
#next_salary: The next salary value in the ordered list for that employee
#diff_current_previous_salary: The difference between the current salary and the previous salary
#diff_current_next_salary: The difference between the next salary and the current salary

#This query effectively demonstrates advanced SQL concepts such as window functions, filtering, and data partitioning.
