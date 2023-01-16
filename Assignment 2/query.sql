
/*
1. Create a university database that consists of tables such as the schema diagram above
*/

create database db_university;
use db_university;

/*
2. Please complete SQL data definition and tuples of some tables others
*/
CREATE TABLE tbl_department (
    dept_name VARCHAR(20) NOT NULL PRIMARY KEY,
    building VARCHAR(15) NOT NULL,
    budget NUMERIC(12 , 2 ) NOT NULL
);

CREATE TABLE tbl_course (
    course_id VARCHAR(7) NOT NULL PRIMARY KEY,
    title VARCHAR(50),
    dept_name VARCHAR(20),
    credits NUMERIC(2 , 0 ),
    FOREIGN KEY (dept_name)
        REFERENCES tbl_department(dept_name)
);

CREATE TABLE tbl_instructor (
    id VARCHAR(5) NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(8 , 2 ),
    FOREIGN KEY (dept_name)
        REFERENCES tbl_department (dept_name)
);

CREATE TABLE tbl_section (
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4 , 0 ),
    building VARCHAR(15),
    room_number VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY (course_id , sec_id , semester , year),
    FOREIGN KEY (course_id)
        REFERENCES tbl_course (course_id)
);

CREATE TABLE tbl_teaches (
    instructor_id VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4 , 0 ),
    PRIMARY KEY (instructor_id , course_id , sec_id , semester , year),
    FOREIGN KEY (course_id , sec_id , semester , year)
        REFERENCES tbl_section (course_id , sec_id , semester , year),
    FOREIGN KEY (instructor_id)
        REFERENCES tbl_instructor (id)
);

CREATE TABLE tbl_student (
    id VARCHAR(5) NOT NULL PRIMARY KEY,
    student_name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    tot_cred INT NOT NULL,
    FOREIGN KEY (dept_name)
        REFERENCES tbl_department (dept_name)
);

CREATE TABLE tbl_advisor (
    s_id VARCHAR(5) NOT NULL PRIMARY KEY,
    i_id VARCHAR(5),
    FOREIGN KEY (s_id)
        REFERENCES tbl_student (id),
    FOREIGN KEY (i_id)
        REFERENCES tbl_instructor (id)
);
CREATE TABLE tbl_prereq (
    course_id VARCHAR(7) NOT NULL,
    prereq_id VARCHAR(7) NOT NULL,
    PRIMARY KEY (course_id , prereq_id),
    FOREIGN KEY (course_id)
        REFERENCES tbl_course (course_id),
    FOREIGN KEY (prereq_id)
        REFERENCES tbl_course (course_id)
);

CREATE TABLE tbl_takes (
    student_id VARCHAR(5) NOT NULL,
    course_id VARCHAR(7) NOT NULL,
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4 , 0 ),
    grade VARCHAR(2),
    PRIMARY KEY (student_id , course_id , sec_id , semester , year),
    FOREIGN KEY (student_id)
        REFERENCES tbl_student (id),
    FOREIGN KEY (course_id , sec_id , semester , year)
        REFERENCES tbl_section (course_id , sec_id , semester , year)
);

CREATE TABLE tbl_timeslot (
    time_slot_id VARCHAR(4),
    day VARCHAR(10),
    start_time TIME,
    end_time TIME,
    PRIMARY KEY (time_slot_id , day , start_time)
);
CREATE TABLE tbl_classroom (
    building VARCHAR(15),
    room_number VARCHAR(7),
    capacity INT NOT NULL,
    PRIMARY KEY (building , room_number)
);

-- alter table section to add foreign ke
ALTER TABLE tbl_section ADD FOREIGN KEY(building,room_number) REFERENCES tbl_classroom(building,room_number);

ALTER TABLE tbl_section ADD FOREIGN KEY(time_slot_id) REFERENCES tbl_timeslot(time_slot_id);

/*
3. Fillthe tuple of each table at least 10 tuples
*/
INSERT INTO tbl_department(dept_name, building, budget)
VALUES 	('Comp. Sci.','Taylor',100000),
		('Biology','Watson',90000),
        ('Elec. Eng.','Taylor',85000),
        ('Music','Packard',80000),
        ('Finance','Painter',120000),
        ('History','Painter',50000),
        ('Physics','Watson',70000),
		('Management', 'Painter',90000),
		('Chemistry','Watson',75000),
        ('Mathematics','Watson',85000);

SELECT 
    *
FROM
    tbl_department;

INSERT INTO tbl_course(course_id,title,dept_name,credits)
VALUES 	('BIO-101','Intro. to Biology','Biology',4),
		('BIO-301','Genetics','Biology',4),
        ('BIO-399','Computational Biology','Biology',3),
        ('CS-101','Intro. to Computer Science','Comp. Sci.',4),
        ('CS-190','Game Design','Comp. Sci.',4),
        ('CS-315','Robotics','Comp. Sci.',3),
        ('CS-319','Image Processing','Comp. Sci.',3),
        ('CS-347','Database Systen Concepts','Comp. Sci.',3),
        ('EE-181','Intro. to Digital Systems','Elec. Eng.',3),
        ('FIN-201','Investment Banking','Finance',3),
        ('HIS-351','World History','History',3),
        ('MU-199','Music Video Production','Music',3),
        ('PHY-101','Physical Principles','Physics',4),
        ('CHE-101','Intro. to Organic Chemistry','CHemistry',4),
        ('MAT-101','Intro. to Calculus','Mathematics',3),
        ('MGT-101','Debit and Credit','Management',4);
        
SELECT 
    *
FROM
    tbl_course;

INSERT INTO tbl_instructor(id,name,dept_name,salary)
VALUES 	('10101','Srinivasan','Comp. Sci.',65000),
        ('12121','Wu','Finance',90000),
        ('15151','Mozart','Music',40000),
        ('22222','Einstein','Physics',95000),
        ('32343','El Said','History',60000),
        ('33456','Gold','Physics',87000),
        ('45565','Katz','Comp. Sci.',75000),
        ('58583','Califeri','History',62000),
        ('76543','Singh','Finance',80000),
        ('76766','Crick','Biology',72000),
        ('83821','Brandt','Comp. Sci.',92000),
        ('98345','Kim','Elec. Eng.',80000),
        ('99101','Shrestha','Mathematics',90000),
        ('99801','Poudel','Chemistry','86000'),
        ('99850','Dhamala','Management',50000);

SELECT 
    *
FROM
    tbl_instructor;

INSERT INTO tbl_timeslot(time_slot_id,day,start_time,end_time)
VALUES 	('A','Sunday','10:00:00','11:30:00'),
		('B','Sunday','11:30:00','13:00:00'),
        ('C','Monday','10:00:00','11:30:00'),
        ('D','Tuesday','11:00:00','12:30:00'),
        ('E','Tuesday','13:00:00','14:30:00'),
        ('F','Wednesday','10:00:00','11:30:00'),
        ('G','Wednesday','12:00:00','13:30:00'),
        ('H','Thursday','10:00:00','11:30:00'),
        ('I','Thursday','14:00:00','15:30:00'),
        ('J','Friday','10:00:00','11:30:00');
        
SELECT 
    *
FROM
    tbl_timeslot;

INSERT INTO tbl_classroom(building,room_number,capacity)
VALUES 	('Painter','514',55),
		('Packard','101',45),
        ('Taylor','3128',45),
        ('Watson','120',50),
        ('Watson','100',35);

SELECT 
    *
FROM
    tbl_classroom;
    
INSERT INTO tbl_section(course_id,sec_id,semester,year,building,room_number,time_slot_id)
values 	('BIO-101','1','Summer',2009,'Painter','514','B'),
        ('BIO-301','1','Summer',2010,'Painter','514','A'),
        ('CS-101','1','Fall',2009,'Packard','101','H'),
        ('CS-101','1','Spring',2010,'Packard','101','F'),
		('CS-190','1','Spring',2009,'Taylor','3128','E'),
        ('CS-190','2','Spring',2009,'Taylor','3128','A'),
        ('CS-319','1','Spring',2010,'Watson','100','B'),
        ('CS-319','2','Spring',2010,'Taylor','3128','C'),
        ('CS-347','1','Fall',2009,'Taylor',3128,'A'),
        ('EE-181','1','Spring',2009,'Taylor','3128','A'),
        ('FIN-201','1','Spring',2010,'Packard','101','B'),
        ('HIS-351','1','Spring',2010,'Painter','514','C'),
        ('MU-199','1','Spring',2010,'Packard','101','D'),
        ('PHY-101','1','Fall',2009,'Watson','100','A');
        
SELECT 
    *
FROM
    tbl_section;
;

INSERT INTO tbl_teaches(instructor_id, course_id, sec_id, semester, year)
VALUES 	('10101','CS-101','1','Fall',2009),
        ('10101','CS-319','1','Spring',2010),
        ('10101','CS-347','1','Fall',2009),
        ('12121','FIN-201','1','Spring',2010),
        ('15151','HIS-351','1','Spring',2010),
        ('22222','PHY-101','1','Fall',2009),
        ('32343','HIS-351','1','Spring',2010),
        ('45565','CS-101','1','Spring',2010),
		('45565','CS-319','1','Spring',2010),
		('76766','BIO-101','1','Summer',2009),
        ('76766','BIO-301','1','Summer',2010),
        ('83821','CS-190','1','Spring',2009),
        ('83821','CS-190','2','Spring',2009),
        ('83821','CS-319','2','Spring',2010),
		('98345','EE-181','1','Spring',2009);
        
SELECT 
    *
FROM
    tbl_teaches;

INSERT INTO tbl_student(id, student_name, dept_name, tot_cred)
VALUES	('00128','Zhang','Comp. Sci.',102),
        ('12345','Shankhar','Comp. Sci.',32),
        ('19991','Brandt','History',80),
        ('23121','Chavez','Finance',110),
        ('44553','Peltier','Physics',56),
        ('45678','Levy','Physics',46),
        ('54321','Williams','Comp. Sci.',54),
        ('55739','Sanchez','Music',38),
        ('70557','Snow','Physics',0),
        ('76543','Brown','Comp. Sci.',58),
        ('76653','Aoi','Elec. Eng.',60),
        ('98765','Bourikas','Elec. Eng.',98),
        ('98988','Tanaka','Biology',120);
        
SELECT 
    *
FROM
    tbl_student;
    
INSERT INTO tbl_advisor(s_id,i_id)
VALUES	('00128','10101'),
		('12345','45565'),
        ('23121','12121'),
        ('54321','45565'),
        ('55739','15151'),
        ('70557','33456'),
        ('76653','98345'),
        ('98988','76766'),
        ('44553','22222');
SELECT 
    *
FROM
    tbl_advisor;
    
INSERT INTO tbl_takes(student_id,course_id,sec_id,semester,year,grade)
VALUES 	('00128','CS-101','1','Fall',2009,'A'),
		('00128','CS-190','1','Spring',2009,'A+'),
        ('19991','HIS-351','1','Spring',2010,'A'),
        ('23121','FIN-201','1','Spring',2010,'B'),
        ('12345','CS-319','1','Spring',2010,'A'),
        ('44553','PHY-101','1','Fall',2009,'B+'),
        ('45678','PHY-101','1','Fall',2009,'A'),
        ('54321','CS-190','2','Spring',2009,'A+'),
        ('55739','MU-199','1','Spring',2010,'A'),
        ('70557','PHY-101','1','Fall',2009,'B'),
        ('76543','CS-101','1','Fall',2009,'A+'),
        ('76543','CS-190','2','Spring',2009,'A'),
        ('76653','EE-181','1','Spring',2009,'C'),
        ('98765','EE-181','1','Spring',2009,'A'),
        ('98988','BIO-301','1','Summer',2010,'A');

SELECT 
    *
FROM
    tbl_takes;
        
/*
4. Write the following queries in Relational Algebra and SQL :
*/

/*
4.1. Find the names of all instructors in the History department
*/
SELECT 
    name
FROM
    tbl_instructor
WHERE
    tbl_instructor.dept_name = 'History';



/*
4.2. Find the instructor ID and department name of all instructors associated with a 
department with budget of greater than $95,000
*/
SELECT 
    tbl_instructor.id as instructor_id, tbl_instructor.dept_name
FROM
    tbl_instructor
        JOIN
    tbl_department ON tbl_department.dept_name = tbl_instructor.dept_name
WHERE
    tbl_department.budget > 95000;

/*
4.3. Find the names of all instructors in the Comp. Sci. department together with the
course titles of all the courses that the instructors teach
*/
SELECT 
    name AS instructor_name, tbl_course.title AS course_title
FROM
    tbl_instructor
        JOIN
    tbl_teaches ON tbl_instructor.id = tbl_teaches.instructor_id
        JOIN
    tbl_section ON tbl_teaches.course_id = tbl_section.course_id
        JOIN
    tbl_course ON tbl_section.course_id = tbl_course.course_id
WHERE
    tbl_instructor.dept_name = 'Comp. Sci.';
    
/*
4.4. Find the names of all students who have taken the course title of “Game Design”
*/

SELECT DISTINCT
    tbl_student.student_name
FROM
    tbl_student
        JOIN
    tbl_takes ON tbl_takes.student_id = tbl_student.id
        JOIN
    tbl_section ON tbl_takes.course_id = tbl_section.course_id
        JOIN
    tbl_course ON tbl_section.course_id = tbl_course.course_id
WHERE
    tbl_course.title = 'Game Design';

/*
4.5. For each department, find the maximum salary of instructors in that department. You 
may assume that every department has at least one instructor
*/
SELECT 
    tbl_instructor.dept_name,
    MAX(tbl_instructor.salary) AS max_salary
FROM
    tbl_instructor
GROUP BY tbl_instructor.dept_name;

/*
4.6. Find the lowest, across all departments, of the per-department maximum salary 
computed by the preceding query
*/


