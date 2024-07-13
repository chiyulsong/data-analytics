-- Create schema for a university database

-- Create Students table
CREATE TABLE Students (
    student_id INTEGER PRIMARY KEY,  -- Primary key for Students table
    first_name TEXT NOT NULL,        -- First name of the student
    last_name TEXT NOT NULL,         -- Last name of the student
    date_of_birth DATE,              -- Date of birth of the student
    enrollment_date DATE DEFAULT CURRENT_DATE  -- Date when the student enrolled, default is current date
);

-- Create Courses table
CREATE TABLE Courses (
    course_id INTEGER PRIMARY KEY,   -- Primary key for Courses table
    course_name TEXT NOT NULL,       -- Name of the course
    credits INTEGER CHECK(credits > 0)  -- Number of credits for the course, must be greater than 0
);

-- Create Instructors table
CREATE TABLE Instructors (
    instructor_id INTEGER PRIMARY KEY,  -- Primary key for Instructors table
    first_name TEXT NOT NULL,           -- First name of the instructor
    last_name TEXT NOT NULL,            -- Last name of the instructor
    hire_date DATE                      -- Date when the instructor was hired
);

-- Create Enrollments table with foreign keys
CREATE TABLE Enrollments (쟈ㅜㅇ
    enrollment_id INTEGER PRIMARY KEY,  -- Primary key for Enrollments table
    student_id INTEGER,                 -- Foreign key referencing Students table
    course_id INTEGER,                  -- Foreign key referencing Courses table
    enrollment_date DATE DEFAULT CURRENT_DATE,  -- Date of enrollment, default is current date
    grade TEXT CHECK(grade IN ('A', 'B', 'C', 'D', 'F')),  -- Grade for the course, must be one of 'A', 'B', 'C', 'D', 'F'
    FOREIGN KEY (student_id) REFERENCES Students(student_id),  -- Define foreign key relationship
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)      -- Define foreign key relationship
);

-- Create TeachingAssignments table with foreign keys
CREATE TABLE TeachingAssignments (
    assignment_id INTEGER PRIMARY KEY,  -- Primary key for TeachingAssignments table
    course_id INTEGER,                  -- Foreign key referencing Courses table
    instructor_id INTEGER,              -- Foreign key referencing Instructors table
    assignment_date DATE DEFAULT CURRENT_DATE,  -- Date of assignment, default is current date
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),      -- Define foreign key relationship
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)  -- Define foreign key relationship
);

-- Create a view to show student enrollments with course names
CREATE VIEW StudentEnrollments AS
SELECT
    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,  -- Concatenate first name and last name
    c.course_name,
    e.enrollment_date,
    e.grade
FROM
    Enrollments e
    JOIN Students s ON e.student_id = s.student_id
    JOIN Courses c ON e.course_id = c.course_id;

-- Create an index on the Courses table to speed up course name searches
CREATE INDEX idx_course_name ON Courses(course_name);

-- Create a composite index on the Enrollments table for student_id and course_id
CREATE INDEX idx_student_course ON Enrollments(student_id, course_id);

-- Add a unique constraint to ensure no duplicate enrollments
ALTER TABLE Enrollments
ADD CONSTRAINT unique_student_course UNIQUE (student_id, course_id);

-- Drop the view
DROP VIEW StudentEnrollments;

-- Drop the index
DROP INDEX idx_course_name;

-- Drop the tables
DROP TABLE TeachingAssignments;
DROP TABLE Enrollments;
DROP TABLE Instructors;
DROP TABLE Courses;
DROP TABLE Students;
