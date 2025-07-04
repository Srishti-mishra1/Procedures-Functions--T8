use functions;

-- Stored Procedure
delimiter $$
create  procedure add_employee(
	in p_first_name varchar(50),
	in p_last_name varchar(50),
	in p_department varchar(50),
	in p_salary decimal(10,2),
	in p_hire_date date
)
begin 
	insert into employees(first_name,last_name,department,salary,hire_date)
    values(p_first_name,p_last_name,p_department,p_salary,p_hire_date);
end $$
delimiter ;
CALL add_employee('John', 'Doe', 'Sales', 60000, '2023-04-01');

-- Function Example - it is useful when we need to compute and return a single value or calcu;ation.
-- Calculating salary increase based on current salary and %
delimiter $$

create function calculate_salary_increase(current_salary decimal(10,2),increase_percentage decimal(5,2))
returns decimal(10,2)
deterministic 
begin
	return current_salary * (1+ increase_percentage /100);
end $$
delimiter ;
SELECT calculate_salary_increase(60000, 5);

DELIMITER $$

CREATE PROCEDURE update_salary(
    IN p_employee_id INT,
    IN p_new_salary DECIMAL(10, 2)
)
BEGIN
    DECLARE current_salary DECIMAL(10, 2);

    -- Get current salary
    SELECT salary INTO current_salary FROM employees WHERE employee_id = p_employee_id;

    -- Check if new salary is higher
    IF p_new_salary > current_salary THEN
        UPDATE employees SET salary = p_new_salary WHERE employee_id = p_employee_id;
    ELSE
        SELECT 'New salary must be greater than the current salary' AS message;
    END IF;
END$$

DELIMITER ;
CALL update_salary(1, 70000);  -- Updates salary if the new salary is higher
CALL update_salary(2, 40000);  -- Will return a message as new salary is not higher


