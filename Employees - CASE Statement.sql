#Objective: Extract the employee number, first name, and last name of the first 100 employees,
#and add a column indicating 
#whether they are still employed or not.

USE employees;

#Step 1: SELECT Clause
SELECT
	e.emp_no, 
	e.first_name, 
	e.last_name,

#The SELECT statement is used to specify the columns we want to retrieve.
#e.emp_no, e.first_name, and e.last_name come from the Employees table.

#Step 2: CASE Statement for Employment Status
    CASE
    WHEN MAX(de.to_date) > SYSdate() THEN 'Is still employed'
    ELSE 'Not an employee anymore'
    END AS current_employee

#The CASE statement is used to create a new column called current_employee.
#The condition WHEN MAX(de.to_date) > SYSdate() checks if the latest to_date value in the dept_emp table is in the future.
#Since SYSdate() returns the current date, this logic correctly determines if the employee is still employed.
#The MAX() function is essential because employees may have multiple department records; selecting the most recent to_date ensures accuracy.
#The ELSE condition sets the status as "Not an employee anymore" for those whose employment period has ended.

#Step 3: FROM Clause and JOIN Operation
FROM 
Employees e 
	JOIN 
dept_emp de ON de.emp_no = e.emp_no
#The FROM clause specifies the primary table (Employees).
#The JOIN condition connects the Employees table with the dept_emp table on the common column emp_no, ensuring only matching records are retrieved.

#Step 4: GROUP BY Clause
GROUP BY de.emp_no
#Since the query involves an aggregation function (MAX()), the GROUP BY clause groups records by employee number to ensure only one record per employee is returned.

#Step 5: LIMIT Clause
LIMIT 100;
#The LIMIT clause restricts the result set to the first 100 employees.
#This ensures performance efficiency and meets the project’s requirements.

#Final Result:
SELECT
	e.emp_no, 
	e.first_name, 
	e.last_name,
 CASE
    WHEN MAX(de.to_date) > SYSdate() THEN 'Is still employed'
    ELSE 'Not an employee anymore'
    END AS current_employee
FROM 
Employees e 
	JOIN 
dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

#The output will display the following columns:
#emp_no: Employee number
#first_name: Employee's first name
#last_name: Employee's last name
#current_employee: Employment status as either "Is still employed" or "Not an employee anymore"
#This query effectively demonstrates skills in SQL querying, including JOIN operations, aggregation functions, and conditional logic. 
