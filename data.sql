-- Employee Table
CREATE TABLE employees(
  employee_id INTEGER NOT NULL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  department_id INTEGER,
  hire_date DATE,
  FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE CASCADE
) 


-- Department Table

CREATE TABLE departments (
  department_id INTEGER PRIMARY KEY,
  department_name VARCHAR(100)
)

-- Salaries Table

CREATE TABLE salaries(
  employee_id INTEGER,
  salary DECIMAL(10, 2),
  from_data DATE,
  to_date DATE,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
)

--Query for find employess who have been hired in the last year

SELECT
  *
FROM
  employees
WHERE
     strftime('%Y', hire_date) = strftime('%Y', 'now', '-1 year');

-- Query for caluculating the total salary expenditure for each department

SELECT
  d.department_name,
  SUM(s.salary) AS total_salary_expenditure
FROM
  salaries s
  JOIN employees e ON s.employee_id = e.employee_id
  JOIN departments d ON e.department_id = d.department_id
GROUP BY
  d.department_name;

-- Query for finding the top 5 highest-paid employees along with their department names

SELECT
  e.employee_id,
  s.salary,
  d.department_name
FROM
  employees e
  JOIN salaries s ON e.employee_id = s.employee_id
  JOIN departments d ON e.department_id = d.department_id
ORDER BY
  s.salary DESC;