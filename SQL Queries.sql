-- SQL Query to find the second highest salary of Employee
-- SQL Query to find Max Salary from each department.
-- Write SQL Query to display the current date?
-- Write an SQL Query to check whether the date passed to Query is the date of the given format or not?
 -- SELECT  ISDATE('1/08/13') AS "MM/DD/YY";
-- Write an SQL Query to print the name of the distinct employee whose DOB is between 01/01/1960 to 31/12/1975.
-- Write an SQL Query to find the number of employees according to gender whose DOB is between 01/01/1960 to 31/12/1975.
-- Write an SQL Query to find an employee whose salary is equal to or greater than 10000.
-- Write an SQL Query to find the name of an employee whose name Start with ‘M’
-- find all Employee records containing the word "Joe", regardless of whether it was stored as JOE, Joe, or joe.
-- Write an SQL Query to find the year from date.
-- Write SQL Query to find duplicate rows in a database? and then write SQL query to delete them?
-- There is a table which contains two columns Student and Marks, you need to find all the students,
   -- whose marks are greater than average marks i.e. list of above-average students.
-- How do you find all employees who are also managers?
SELECT e.name, m.name FROM Employee e, Employee m WHERE e.mgr_id = m.emp_id;

