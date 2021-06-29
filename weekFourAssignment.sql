-- procedure 1 creates a seniority list for job position bidding purposes.

DROP PROCEDURE IF EXISTS employees_seniority_by_hire_date;

DELIMITER //

CREATE PROCEDURE employees_seniority_by_hire_date()
	SELECT first_name, last_name, hire_date from employees 
	GROUP BY hire_date 
	
DELIMITER ; //

CALL employees_seniority_by_hire_date;


-- procedure 2 returns a known employees current salary

DROP PROCEDURE IF EXISTS get_employee_salary;

DELIMITER //

CREATE PROCEDURE get_employee_salary(IN empFirstName varchar(30), IN empLastName varchar(30))

BEGIN
		SELECT s.salary AS "Salary", s.emp_no "Employee Number" FROM salaries s 
		INNER JOIN employees e on e.emp_no = s.emp_no
		WHERE first_name = empFirstName
			AND last_name = empLastName
			AND to_date > NOW();
END //

DELIMITER ; //

CALL get_employee_salary("Denny", "Setia");


-- procedure 3 will raise the salary of a known employee number by 5%

DROP PROCEDURE IF EXISTS employee_five_percent_raise;

DELIMITER //

CREATE PROCEDURE employee_five_percent_raise(IN known_emp_no INT(11), IN current_salary INT(11))

BEGIN
		DECLARE income INT;
		SET income = current_salary + (current_salary * .05);
		
		UPDATE salaries SET salary = income
		WHERE salaries.emp_no = known_emp_no
		AND to_date > NOW();
END //

DELIMITER ; //

CALL employee_five_percent_raise(10691, 67546);


-- procedure 4 will give a count of employees in a given TITLE;

DROP PROCEDURE IF EXISTS counting_employees;

DELIMITER //

CREATE PROCEDURE counting_employees()

BEGIN	
		SELECT ei.title AS "TITLE", COUNT(*) AS "NUMBER OF EMPLOYEES HOLDING POSITION" FROM employee_info ei
		GROUP BY ei.title;
END //

DELIMITER ; //

CALL counting_employees();


-- procedure 5 happy birthday to everyone in a department

DROP PROCEDURE IF EXISTS happy_birthday;

DELIMITER //

CREATE PROCEDURE happy_birthday(IN birthday_month int(2), IN department varchar(4))

BEGIN
		SELECT e.first_name AS "First Name", e.last_name AS "Last Name", e.birth_date AS "Birthday", de.dept_no AS "Department" FROM employees e
		INNER JOIN dept_emp de ON de.emp_no = e.emp_no
		WHERE MONTH(e.birth_date) = birthday_month AND de.dept_no = department
		ORDER BY DAY(e.birth_date);		
END //

DELIMITER ; //

CALL happy_birthday(06, 'd001');





















