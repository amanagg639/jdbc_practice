
mysql> create database payroll_service;
Query OK, 1 row affected (0.02 sec)

mysql> use payroll_service;
Database changed

mysql> Create Table employee_payroll
    -> (
    -> ID int,
    -> Name varchar(255),
    -> Salary int,
    -> StartDate Date
    -> );
Query OK, 0 rows affected (0.12 sec)

 mysql> INSERT INTO employee_payroll (ID, Name, Salary, StartDate)
    -> VALUES
    -> (1, 'Aman', 50000, '2025-06-15');
Query OK, 1 row affected (0.04 sec)

mysql> SELECT * FROM employee_payroll;
+------+------+--------+------------+
| ID   | Name | Salary | StartDate  |
+------+------+--------+------------+
|    1 | Aman |  50000 | 2025-06-15 |
+------+------+--------+------------+
1 row in set (0.01 sec)

mysql> Terminal close -- exit!

mysql> USE payroll_service;
Database changed
mysql> INSERT INTO employee_payroll (ID, Name, Salary, StartDate)
    -> VALUES
    -> (2, 'Aditya', 35000, '2024-08-21'),
    -> (3, 'Bill', 40000, '2018-02-01');
Query OK, 2 rows affected (0.15 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT Salary FROM employee_payroll WHERE Name = 'Bill';
+--------+
| Salary |
+--------+
|  40000 |
+--------+
1 row in set (0.03 sec)

mysql> SELECT * FROM employee_payroll WHERE StartDate BETWEEN CAST('2018-01-01' AS DATE) AND DATE (NOW());
+------+--------+--------+------------+
| ID   | Name   | Salary | StartDate  |
+------+--------+--------+------------+
|    2 | Aditya |  35000 | 2024-08-21 |
|    3 | Bill   |  40000 | 2018-02-01 |
+------+--------+--------+------------+
2 rows in set (0.02 sec)

mysql> UPDATE employee_payroll SET Gender = 'M' WHERE Name = 'Bill' or Name = 'Aman';
ERROR 1054 (42S22): Unknown column 'Gender' in 'field list'
mysql> ALTER TABLE employee_payroll ADD Gender char;
Query OK, 0 rows affected (0.12 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> UPDATE employee_payroll SET Gender = 'M' WHERE Name = 'Bill' or Name = 'Aman';
Query OK, 2 rows affected (0.02 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> SELECT SUM(Salary) FROM employee_payroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| SUM(Salary) |
+-------------+
|       90000 |
+-------------+
1 row in set (0.01 sec)

mysql> 
mysql> SELECT AVG(Salary) FROM employee_payroll
    -> ;
+-------------+
| AVG(Salary) |
+-------------+
|  41666.6667 |
+-------------+
1 row in set (0.01 sec)


mysql> SELECT COUNT(ID) FROM employee_payroll WHERE StartDate > '2024-01-01';
+-----------+
| COUNT(ID) |
+-----------+
|         2 |
+-----------+
1 row in set (0.01 sec)

mysql> ALTER TABLE employee_payroll ADD (PhoneNO int(10), Address varchar(255), Department varchar(255));  
Query OK, 0 rows affected, 1 warning (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 1

mysql> select * from employee_payroll;
+------+--------+--------+------------+--------+---------+---------+------------+
| ID   | Name   | Salary | StartDate  | Gender | PhoneNO | Address | Department |
+------+--------+--------+------------+--------+---------+---------+------------+
|    1 | Aman   |  50000 | 2025-06-15 | M      |    NULL | NULL    | NULL       |
|    2 | Aditya |  35000 | 2024-08-21 | NULL   |    NULL | NULL    | NULL       |
|    3 | Bill   |  40000 | 2018-02-01 | M      |    NULL | NULL    | NULL       |
+------+--------+--------+------------+--------+---------+---------+------------+
3 rows in set (0.11 sec)

mysql> ALTER TABLE employee_payroll ADD (BasicPay double, Deductions double, TexablePay double, IncomeTax double, NetPay double);
Query OK, 0 rows affected (0.17 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> INSERT INTO employee_payroll (ID, Name, Salary, StartDate, Gender, PhoneNO, Address, Department)
    -> VALUES
    -> (4, 'Terissa', 60000, '2020-05-21', 'F', '123345', 'Silvia', 'Sales'),
    -> (5, 'Terissa', 60000, '2020-05-21', 'F', '123345', 'Silvia', 'Marketing');
Query OK, 2 rows affected (0.03 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll
    -> ;
+------+---------+--------+------------+--------+---------+---------+------------+----------+------------+------------+-----------+--------+
| ID   | Name    | Salary | StartDate  | Gender | PhoneNO | Address | Department | BasicPay | Deductions | TexablePay | IncomeTax | NetPay |
+------+---------+--------+------------+--------+---------+---------+------------+----------+------------+------------+-----------+--------+
|    1 | Aman    |  50000 | 2025-06-15 | M      |    NULL | NULL    | NULL       |     NULL |       NULL |       NULL |      NULL |   NULL |
|    2 | Aditya  |  35000 | 2024-08-21 | NULL   |    NULL | NULL    | NULL       |     NULL |       NULL |       NULL |      NULL |   NULL |
|    3 | Bill    |  40000 | 2018-02-01 | M      |    NULL | NULL    | NULL       |     NULL |       NULL |       NULL |      NULL |   NULL |
|    4 | Terissa |  60000 | 2020-05-21 | F      |  123345 | Silvia  | Sales      |     NULL |       NULL |       NULL |      NULL |   NULL |
|    5 | Terissa |  60000 | 2020-05-21 | F      |  123345 | Silvia  | Marketing  |     NULL |       NULL |       NULL |      NULL |   NULL |
+------+---------+--------+------------+--------+---------+---------+------------+----------+------------+------------+-----------+--------+
5 rows in set (0.00 sec)

mysql> show tables;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| employee_payroll          |
+---------------------------+
1 row in set (0.04 sec)


mysql> select * from employee_payroll;
+------+---------+--------+------------+--------+---------+---------+------------+----------+------------+------------+-----------+--------+
| ID   | Name    | Salary | StartDate  | Gender | PhoneNO | Address | Department | BasicPay | Deductions | TexablePay | IncomeTax | NetPay |
+------+---------+--------+------------+--------+---------+---------+------------+----------+------------+------------+-----------+--------+
|    1 | Aman    |  50000 | 2025-06-15 | M      |    NULL | NULL    | NULL       |     NULL |       NULL |       NULL |      NULL |   NULL |
|    2 | Aditya  |  35000 | 2024-08-21 | NULL   |    NULL | NULL    | NULL       |     NULL |       NULL |       NULL |      NULL |   NULL |
|    3 | Bill    |  40000 | 2018-02-01 | M      |    NULL | NULL    | NULL       |     NULL |       NULL |       NULL |      NULL |   NULL |
|    4 | Terissa |  60000 | 2020-05-21 | F      |  123345 | Silvia  | Sales      |     NULL |       NULL |       NULL |      NULL |   NULL |
|    5 | Terissa |  60000 | 2020-05-21 | F      |  123345 | Silvia  | Marketing  |     NULL |       NULL |       NULL |      NULL |   NULL |
+------+---------+--------+------------+--------+---------+---------+------------+----------+------------+------------+-----------+--------+
5 rows in set (0.00 sec)

mysql> Terminal close -- exit!
