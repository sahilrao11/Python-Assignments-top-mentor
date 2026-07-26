CREATE DATABASE UniversityDB;
USE UniversityDB;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    StudentID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

INSERT INTO Departments VALUES
(1,'Computer Science'),
(2,'Information Technology'),
(3,'Electronics'),
(4,'Mechanical'),
(5,'Civil');

INSERT INTO Students VALUES
(101,'Alice Johnson',21,1),
(102,'Bob Smith',22,2),
(103,'Charlie Brown',20,1),
(104,'David Lee',23,3),
(105,'Emma Wilson',21,4);

INSERT INTO Courses VALUES
(201,'Artificial Intelligence',101),
(202,'Data Science',101),
(203,'Database Management',102),
(204,'Artificial Intelligence',103),
(205,'Machine Learning',103);

SELECT s.StudentID, s.Name, s.Age, d.DepartmentName
FROM Students s
JOIN Departments d
ON s.DepartmentID = d.DepartmentID;

SELECT s.Name
FROM Students s
JOIN Courses c
ON s.StudentID = c.StudentID
WHERE c.CourseName = 'Artificial Intelligence';

SELECT d.DepartmentName, COUNT(s.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

SELECT c.CourseName
FROM Students s
JOIN Courses c
ON s.StudentID = c.StudentID
WHERE s.Name = 'Alice Johnson';

SELECT s.Name, COUNT(c.CourseID) AS TotalCourses
FROM Students s
JOIN Courses c
ON s.StudentID = c.StudentID
GROUP BY s.StudentID, s.Name
HAVING COUNT(c.CourseID) > 1;

SELECT d.DepartmentName, AVG(s.Age) AS AverageAge
FROM Departments d
JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

SELECT d.DepartmentName, COUNT(s.StudentID) AS TotalStudents
FROM Departments d
JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalStudents DESC
LIMIT 1;

SELECT s.Name
FROM Students s
LEFT JOIN Courses c
ON s.StudentID = c.StudentID
WHERE c.CourseID IS NULL;

SELECT s.Name, COUNT(c.CourseID) AS TotalCourses
FROM Students s
LEFT JOIN Courses c
ON s.StudentID = c.StudentID
GROUP BY s.StudentID, s.Name;

SELECT s.Name, c.CourseName
FROM Students s
JOIN Departments d
ON s.DepartmentID = d.DepartmentID
JOIN Courses c
ON s.StudentID = c.StudentID
WHERE d.DepartmentName = 'Computer Science'
AND c.CourseName LIKE '%Data%';