# UniPortal Academic Management System

This repository contains a comprehensive database design for an academic management system (UniPortal), designed to streamline operations within educational institutions by managing data for students, instructors, courses, and communication.

## 📌 Project Overview
The **UniPortal** system is built to provide a robust infrastructure for managing all aspects of the academic process. This project includes the conceptual design (ERD), the logical schema (Relational Mapping), and the implementation script (SQL Schema).

## 🚀 Key Modules
The system is divided into several interconnected modules:
* **Administration:** Manages departments and academic levels.
* **Users:** Handles detailed profiles for students and instructors, including multi-valued attributes like phone numbers.
* **Academics:** Includes course management, prerequisites, semesters, and sections.
* **Assessment:** Manages course enrollment, assignments, and student submissions.
* **Communication:** Features announcements, course-specific messaging, and private messaging.

## 📊 Database Structure
The project consists of the following documentation and scripts:
1.  **ER Diagram (ERD):** Visual representation of entities and their relationships [cite: 1].
2.  **Relational Mapping:** Logical table structures and foreign key connections [cite: 2].
3.  **SQL Script:** The `UniPortal_Schema_EN.sql` file containing all `CREATE TABLE` statements and constraints for SQL Server.

## 🛠️ Table Inventory (15 Tables)
The database is normalized into 15 tables to ensure data integrity and minimize redundancy:
* `DEPARTMENT`, `INSTRUCTOR`, `STUDENT`, `STUDENT_PHONE`
* `COURSE`, `PREREQUISITE`, `SEMESTER`, `SECTION`
* `ENROLLMENT`, `ASSIGNMENT`, `SUBMISSION`, `COURSE_MATERIAL`
* `ANNOUNCEMENT`, `COURSE_MESSAGE`, `PRIVATE_MESSAGE`

## ⚙️ How to Use
1.  Download the `UniPortal_Schema_EN.sql` file.
2.  Open SQL Server Management Studio (SSMS) or your preferred database management tool.
3.  Execute the script to build the tables and relationships.
4.  Refer to the provided ERD to understand the data flow and entity connections.

## ✒️ Credits
* **Design & Development:** Kirolos Girgis
