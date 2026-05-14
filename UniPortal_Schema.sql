-- ============================================
-- UniPortal Academic Management System
-- Database Schema (SQL Server)
-- Designed by: Kirolos Girgis
-- Optimized Version
-- ============================================

-- 1. DEPARTMENT
CREATE TABLE DEPARTMENT (
    DepartmentID   INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL
);

-- 2. INSTRUCTOR
CREATE TABLE INSTRUCTOR (
    InstructorID   INT PRIMARY KEY IDENTITY(1,1),
    Name           NVARCHAR(100) NOT NULL,
    Email          NVARCHAR(100) NOT NULL UNIQUE,
    Phone          NVARCHAR(20),
    Office         NVARCHAR(50),
    InstructorPass NVARCHAR(255) NOT NULL,
    DepartmentID   INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

-- 3. STUDENT
CREATE TABLE STUDENT (
    StudentID   INT PRIMARY KEY IDENTITY(1,1),
    Name        NVARCHAR(100) NOT NULL,
    Email       NVARCHAR(100) NOT NULL UNIQUE,
    Major       NVARCHAR(100),
    Level       NVARCHAR(20),
    DateOfBirth DATE,
    StudentPASS NVARCHAR(255) NOT NULL,
    AdvisorID   INT,
    FOREIGN KEY (AdvisorID) REFERENCES INSTRUCTOR(InstructorID)
);

-- 3a. STUDENT PHONE (multi-valued)
CREATE TABLE STUDENT_PHONE (
    StudentID INT NOT NULL,
    Phone     NVARCHAR(20) NOT NULL,
    PRIMARY KEY (StudentID, Phone),
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID) ON DELETE CASCADE
);

-- 4. COURSE
CREATE TABLE COURSE (
    CourseID     INT PRIMARY KEY IDENTITY(1,1),
    CourseName   NVARCHAR(100) NOT NULL,
    CreditHours  INT NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

-- 4a. PREREQUISITE (self-referencing)
CREATE TABLE PREREQUISITE (
    CourseID             INT NOT NULL,
    PrerequisiteCourseID INT NOT NULL,
    PRIMARY KEY (CourseID, PrerequisiteCourseID),
    FOREIGN KEY (CourseID)             REFERENCES COURSE(CourseID),
    FOREIGN KEY (PrerequisiteCourseID) REFERENCES COURSE(CourseID)
);

-- 5. SEMESTER
CREATE TABLE SEMESTER (
    SemesterID   INT PRIMARY KEY IDENTITY(1,1),
    SemesterName NVARCHAR(50) NOT NULL,
    StartDate    DATE NOT NULL,
    EndDate      DATE NOT NULL,
    IsActive     BIT DEFAULT 0
);

-- 6. SECTION
CREATE TABLE SECTION (
    SectionID     INT PRIMARY KEY IDENTITY(1,1),
    SectionNumber NVARCHAR(20) NOT NULL,
    SectionType   NVARCHAR(20),         -- Lecture / Tutorial / Lab
    StartTime     TIME NOT NULL,
    EndTime       TIME NOT NULL,
    Day           NVARCHAR(20) NOT NULL,
    Room          NVARCHAR(50),
    Capacity      INT,
    CourseID      INT NOT NULL,
    InstructorID  INT NOT NULL,
    SemesterID    INT NOT NULL,
    FOREIGN KEY (CourseID)     REFERENCES COURSE(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID),
    FOREIGN KEY (SemesterID)   REFERENCES SEMESTER(SemesterID)
);

-- 7. ENROLLMENT
CREATE TABLE ENROLLMENT (
    EnrollmentID   INT PRIMARY KEY IDENTITY(1,1),
    Grade          NVARCHAR(5),
    Status         NVARCHAR(20),         -- Active / Dropped / Completed
    EnrollmentDate DATE NOT NULL,
    StudentID      INT NOT NULL,
    SectionID      INT NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID),
    CONSTRAINT UQ_Student_Section UNIQUE (StudentID, SectionID)
);

-- 8. ASSIGNMENT
CREATE TABLE ASSIGNMENT (
    AssignmentID       INT PRIMARY KEY IDENTITY(1,1),
    Title              NVARCHAR(200) NOT NULL,
    Description        NVARCHAR(MAX),
    Deadline           DATETIME NOT NULL,
    CreatedAt          DATETIME DEFAULT GETDATE(),
    AttachmentFileName NVARCHAR(255),
    AttachmentData     VARBINARY(MAX),
    InstructorID       INT NOT NULL,
    CourseID           INT NOT NULL,
    FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID),
    FOREIGN KEY (CourseID)     REFERENCES COURSE(CourseID)
);

-- 9. SUBMISSION
CREATE TABLE SUBMISSION (
    SubmissionID INT PRIMARY KEY IDENTITY(1,1),
    SubmittedAt  DATETIME DEFAULT GETDATE(),
    Content      NVARCHAR(MAX),
    FileName     NVARCHAR(255),
    Mark         DECIMAL(5,2),
    AssignmentID INT NOT NULL,
    StudentID    INT NOT NULL,
    FOREIGN KEY (AssignmentID) REFERENCES ASSIGNMENT(AssignmentID),
    FOREIGN KEY (StudentID)    REFERENCES STUDENT(StudentID)
);

-- 10. COURSE_MATERIAL
CREATE TABLE COURSE_MATERIAL (
    MaterialID   INT PRIMARY KEY IDENTITY(1,1),
    Title        NVARCHAR(200) NOT NULL,
    Description  NVARCHAR(MAX),
    FileName     NVARCHAR(255),
    FileType     NVARCHAR(50),
    UploadedAt   DATETIME DEFAULT GETDATE(),
    FileData     VARBINARY(MAX),
    InstructorID INT NOT NULL,
    CourseID     INT NOT NULL,
    FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID),
    FOREIGN KEY (CourseID)     REFERENCES COURSE(CourseID)
);

-- 11. ANNOUNCEMENT
CREATE TABLE ANNOUNCEMENT (
    AnnouncementID INT PRIMARY KEY IDENTITY(1,1),
    Title          NVARCHAR(200) NOT NULL,
    Body           NVARCHAR(MAX),
    Target         NVARCHAR(20) DEFAULT 'all',  -- 'all' / 'students' / 'instructors'
    CreatedAt      DATETIME DEFAULT GETDATE(),
    InstructorID   INT NOT NULL,
    FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID)
);

-- 12. COURSE_MESSAGE
CREATE TABLE COURSE_MESSAGE (
    MessageID  INT PRIMARY KEY IDENTITY(1,1),
    SenderID   INT NOT NULL,
    Content    NVARCHAR(MAX) NOT NULL,
    SentAt     DATETIME DEFAULT GETDATE(),
    CourseID   INT NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID)
);

-- 13. PRIVATE_MESSAGE
CREATE TABLE PRIVATE_MESSAGE (
    MessageID  INT PRIMARY KEY IDENTITY(1,1),
    SenderID   INT NOT NULL,
    SenderRole NVARCHAR(20) NOT NULL,   -- 'Student' / 'Instructor' / 'Admin'
    ReceiverID INT NOT NULL,
    Content    NVARCHAR(MAX) NOT NULL,
    SentAt     DATETIME DEFAULT GETDATE()
);
