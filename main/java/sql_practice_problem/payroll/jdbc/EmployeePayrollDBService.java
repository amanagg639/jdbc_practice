package sql_practice_problem.payroll.jdbc;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EmployeePayrollDBService {

    private static final String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/payroll_service?allowPublicKeyRetrieval=true&useSSL=false";
    private static final String USER = "root"; // change if needed
    private static final String PASSWORD = "262682"; // replace with your password
    private List<EmployeePayroll> employeeList = new ArrayList<>();

    public List<EmployeePayroll> getEmployeeList() {
        return employeeList;
    }

    public List<EmployeePayroll> getEmployeePayrollData() {


        String query = "SELECT ID, Name, Gender, Salary, StartDate FROM employee_payroll";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                int id = resultSet.getInt("ID");
                String name = resultSet.getString("Name");
                String gender = resultSet.getString("Gender");
                double salary = resultSet.getDouble("Salary");
                LocalDate startDate = resultSet.getDate("StartDate").toLocalDate();

                EmployeePayroll employee = new EmployeePayroll(id, name, gender, salary, startDate);
                employeeList.add(employee);
            }

        } catch (SQLException e) {
            e.printStackTrace(); // or use logging
        }

        return employeeList;
    }
    public boolean updateEmployeeSalary(String name, double salary) {
        String updateSQL = "UPDATE employee_payroll SET Salary = ? WHERE name = ?";
        try (Connection connection = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             PreparedStatement statement = connection.prepareStatement(updateSQL)) {

            statement.setDouble(1, salary);
            statement.setString(2, name);
            int rowsAffected = statement.executeUpdate();
            if(rowsAffected == 1){
                for (EmployeePayroll emp : employeeList) {
                    if(emp.getName().equalsIgnoreCase(name)){
                        emp.setSalary(salary);
                    }
                }
            }
            return rowsAffected == 1;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<EmployeePayroll> getEmployeesByStartDateRange(LocalDate start, LocalDate end) {
        List<EmployeePayroll> employeeList = new ArrayList<>();

        String query = "SELECT * FROM employee_payroll WHERE StartDate BETWEEN ? AND ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setDate(1, Date.valueOf(start));
            preparedStatement.setDate(2, Date.valueOf(end));

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String gender = resultSet.getString("gender");
                double salary = resultSet.getDouble("salary");
                LocalDate startDate = resultSet.getDate("StartDate").toLocalDate();

                employeeList.add(new EmployeePayroll(id, name, gender, salary, startDate));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employeeList;
    }

    public void getSalaryStatsByGender() {
        String query = "SELECT Gender, SUM(Salary) AS total, AVG(Salary) AS avg, MIN(Salary) AS min, MAX(Salary) AS max, COUNT(*) AS count " +
                "FROM employee_payroll GROUP BY Gender";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                String gender = resultSet.getString("Gender");
                double total = resultSet.getDouble("total");
                double avg = resultSet.getDouble("avg");
                double min = resultSet.getDouble("min");
                double max = resultSet.getDouble("max");
                int count = resultSet.getInt("count");

                System.out.println("Gender: " + gender);
                System.out.println("  Total Salary: " + total);
                System.out.println("  Avg Salary: " + avg);
                System.out.println("  Min Salary: " + min);
                System.out.println("  Max Salary: " + max);
                System.out.println("  Count: " + count);
                System.out.println();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addEmployee(String name, String gender, double salary, LocalDate startDate) {
        String query = "INSERT INTO employee_payroll (Name, Gender, Salary, StartDate) VALUES (?, ?, ?, ?)";
        EmployeePayroll employee = null;

        try (Connection connection = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, name);
            preparedStatement.setString(2, gender);
            preparedStatement.setDouble(3, salary);
            preparedStatement.setDate(4, Date.valueOf(startDate));

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected == 1) {
                ResultSet keys = preparedStatement.getGeneratedKeys();
                if (keys.next()) {
                    int id = keys.getInt(1);
                    employee = new EmployeePayroll(id, name, gender, salary, startDate);
                    // Add to in-memory list if needed:
                    employeeList.add(employee);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
