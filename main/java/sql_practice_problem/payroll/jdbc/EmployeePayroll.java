package sql_practice_problem.payroll.jdbc;

import java.time.LocalDate;
import java.util.List;

public class EmployeePayroll {
    private int id;
    private String name;
    private String gender;
    private double salary;
    private LocalDate startDate;

    public EmployeePayroll(int id, String name, double salary) {
        this(id, name, "N/A", salary, null);
    }

    // Full Constructor
    public EmployeePayroll(int id, String name, String gender, double salary, LocalDate startDate) {
        this.id = id;
        this.name = name;
        this.gender = gender;
        this.salary = salary;
        this.startDate = startDate;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getGender() {
        return gender;
    }

    public double getSalary() {
        return salary;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    @Override
    public String toString() {
        return "EmployeePayroll{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", salary=" + salary +
                ", startDate=" + startDate +
                '}';
    }


}

