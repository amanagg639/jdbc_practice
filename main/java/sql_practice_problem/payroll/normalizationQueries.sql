mysql> use database payroll_service
ERROR 1049 (42000): Unknown database 'database'
mysql> use payroll_service
Database changed
mysql> CREATE TABLE employee (
    -> id INT AUTO_INCREMENT PRIMARY KEY,
    -> name VARCHAR(100),
    -> gender VARCHAR(10),
    -> start_date DATE,
    -> dept_id INT,
    -> FOREIGN KEY (dept_id) REFRENCES department(dept_id)
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'REFRENCES department(dept_id)
)' at line 7
mysql> CREATE TABLE department (
    -> dept_id INT AUTO_INCREMENT PRIMARY KEY,
    -> dept_name VARCHAR(100) NOT NULL
    -> );
Query OK, 0 rows affected (0.19 sec)

mysql> CREATE TABLE employee (
    -> id INT AUTO_INCREMENT PRIMARY KEY,
    -> name VARCHAR(100),
    -> gender VARCHAR(10),
    -> start_date DATE,
    -> dept_id INT,
    -> FOREIGN KEY (dept_id) REFRENCES department(dept_id)
    -> );
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'REFRENCES department(dept_id)
)' at line 7
mysql> CREATE TABLE employee (
    -> id INT AUTO_INCREMENT PRIMARY KEY,
    -> name VARCHAR(100),
    -> gender VARCHAR(10),
    -> start_date DATE,
    -> dept_id INT,
    -> FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> CREATE TABLE payroll (
    -> payroll_id INT AUTO_INCREMENT PRIMARY KEY,
    -> basic_pay DECIMAL(10,2),
    ->     deductions DECIMAL(10,2),
    ->     taxable_pay DECIMAL(10,2),
    ->     income_tax DECIMAL(10,2),
    ->     net_pay DECIMAL(10,2),
    ->     salary DECIMAL(10,2),
    ->     employee_id INT,
    ->     FOREIGN KEY (employee_id) REFERENCES employee(id)
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> SELECT 
    ->     e.id, e.name, e.gender, e.start_date,
    ->     p.salary, p.basic_pay, p.net_pay
    -> FROM employee e
    -> JOIN payroll p ON e.id = p.employee_id;
Empty set (0.01 sec)

mysql> INSERT INTO employee (id, name, gender, start_date, dept_id)
    -> VALUES
    -> (1, 'Aman', 'M', '2025-06-15'),
    -> (2, 'Anshuman', 'M', '2025-07-13');
ERROR 1136 (21S01): Column count doesn't match value count at row 1
mysql> INSERT INTO employee (id, name, gender, start_date, dept_id)
    -> VALUES
    -> (1, 'Aman', 'M', '2025-06-15', 1),
    -> (2, 'Anshuman', 'M', '2025-07-13', 2);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`payroll_service`.`employee`, CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`))
mysql> INSERT INTO department (dept_id, dept_name)
    -> VALUES
    -> (1, 'HR'),
    -> (2, 'Engineering');
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO employee (id, name, gender, start_date, dept_id)
    -> VALUES
    -> (1, 'Aman', 'M', '2025-06-15', 1),
    -> (2, 'Anshuman', 'M', '2025-07-13', 2);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO payroll (basic_pay, deductions, taxable_pay, income_tax, net_pay, salary, employee_id)
    -> VALUES
    -> (80000, 3000, 4000, 3000, 75000, 90000, 1),
    -> (60000, 3000, 4000, 3000, 55000, 70000, 2);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT 
    ->     e.id, e.name, e.gender, e.start_date,
    ->     p.salary, p.basic_pay, p.net_pay
    -> FROM employee e
    -> JOIN payroll p ON e.id = p.employee_id;
+----+----------+--------+------------+----------+-----------+----------+
| id | name     | gender | start_date | salary   | basic_pay | net_pay  |
+----+----------+--------+------------+----------+-----------+----------+
|  1 | Aman     | M      | 2025-06-15 | 90000.00 |  80000.00 | 75000.00 |
|  2 | Anshuman | M      | 2025-07-13 | 70000.00 |  60000.00 | 55000.00 |
+----+----------+--------+------------+----------+-----------+----------+
2 rows in set (0.01 sec)

mysql> SELECT p.salary FROM employee e
    -> JOIN payroll p ON e.id = p.employee_id
    -> WHERE e.name = 'Anshuman';
+----------+
| salary   |
+----------+
| 70000.00 |
+----------+
1 row in set (0.00 sec)

mysql> SELECT e.gender,
    ->        SUM(p.salary) AS total_salary,
    ->        AVG(p.salary) AS avg_salary,
    ->        MIN(p.salary) AS min_salary,
    ->        MAX(p.salary) AS max_salary,
    ->        COUNT(*) AS employee_count
    -> FROM employee e
    -> JOIN payroll p ON e.id = p.employee_id
    -> GROUP BY e.gender;
+--------+--------------+--------------+------------+------------+----------------+
| gender | total_salary | avg_salary   | min_salary | max_salary | employee_count |
+--------+--------------+--------------+------------+------------+----------------+
| M      |    160000.00 | 80000.000000 |   70000.00 |   90000.00 |              2 |
+--------+--------------+--------------+------------+------------+----------------+
1 row in set (0.02 sec)

mysql> CREATE TABLE contact (
    ->     contact_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     phone VARCHAR(15),
    ->     email VARCHAR(100),
    ->     address VARCHAR(255) DEFAULT 'N/A',
    ->     employee_id INT,
    ->     FOREIGN KEY (employee_id) REFERENCES employee(id)
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> tee D:\bridgelabz-workspace\jdbc\src\main\java\sql_practice_problem\address_book.sql
