-- ============================================
-- CGTSTest.com Database
-- Version : 1.0
-- ============================================

CREATE DATABASE IF NOT EXISTS cgtstest
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE cgtstest;

-- ============================================
-- USERS
-- ============================================

CREATE TABLE users (

    id INT AUTO_INCREMENT PRIMARY KEY,

    full_name VARCHAR(100) NOT NULL,

    mobile VARCHAR(10) NOT NULL UNIQUE,

    password VARCHAR(100) NOT NULL,

    role ENUM('student','admin') DEFAULT 'student',

    status ENUM('active','blocked') DEFAULT 'active',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- ============================================
-- COURSE CATEGORY
-- ============================================

CREATE TABLE categories (

    id INT AUTO_INCREMENT PRIMARY KEY,

    category_name VARCHAR(100) NOT NULL,

    status TINYINT(1) DEFAULT 1

);

-- ============================================
-- COURSES
-- ============================================

CREATE TABLE courses (

    id INT AUTO_INCREMENT PRIMARY KEY,

    category_id INT NOT NULL,

    course_name VARCHAR(200) NOT NULL,

    course_description TEXT,

    course_image VARCHAR(255),

    course_type ENUM('free','premium') DEFAULT 'free',

    status ENUM('active','inactive') DEFAULT 'active',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id) REFERENCES categories(id)

);

-- ============================================
-- COURSE ACCESS
-- ============================================

CREATE TABLE course_access (

    id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    course_id INT NOT NULL,

    status ENUM('pending','approved','rejected') DEFAULT 'pending',

    approved_by INT DEFAULT NULL,

    approved_date DATETIME DEFAULT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (student_id) REFERENCES users(id),

    FOREIGN KEY (course_id) REFERENCES courses(id)

);

-- ============================================
-- TESTS
-- ============================================

CREATE TABLE tests (

    id INT AUTO_INCREMENT PRIMARY KEY,

    course_id INT NOT NULL,

    test_name VARCHAR(255) NOT NULL,

    total_questions INT DEFAULT 0,

    total_marks INT DEFAULT 0,

    duration INT DEFAULT 60,

    negative_mark DECIMAL(4,2) DEFAULT 0,

    status ENUM('active','inactive') DEFAULT 'active',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (course_id) REFERENCES courses(id)

);

-- ============================================
-- QUESTIONS
-- ============================================

CREATE TABLE questions (

    id INT AUTO_INCREMENT PRIMARY KEY,

    test_id INT NOT NULL,

    question LONGTEXT NOT NULL,

    option_a TEXT,

    option_b TEXT,

    option_c TEXT,

    option_d TEXT,

    answer CHAR(1),

    explanation LONGTEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (test_id) REFERENCES tests(id)

);

-- ============================================
-- RESULTS
-- ============================================

CREATE TABLE results (

    id INT AUTO_INCREMENT PRIMARY KEY,

    student_id INT NOT NULL,

    test_id INT NOT NULL,

    total_marks DECIMAL(10,2),

    obtained_marks DECIMAL(10,2),

    correct_answers INT,

    wrong_answers INT,

    skipped_questions INT,

    percentage DECIMAL(5,2),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (student_id) REFERENCES users(id),

    FOREIGN KEY (test_id) REFERENCES tests(id)

);

-- ============================================
-- DEFAULT ADMIN
-- ============================================

INSERT INTO users
(
full_name,
mobile,
password,
role,
status
)
VALUES
(
'Administrator',
'9999999999',
'admin123',
'admin',
'active'
);

-- ============================================
-- DEFAULT CATEGORY
-- ============================================

INSERT INTO categories(category_name)
VALUES
('CGPSC'),
('CG VYAPAM'),
('SSC'),
('Railway'),
('Banking');
