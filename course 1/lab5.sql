CREATE TABLE student (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE course CASCADE;
CREATE TABLE course (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

DROP TABLE roster CASCADE;
CREATE TABLE roster (
    id SERIAL,
    student_id INTEGER REFERENCES student(id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES course(id) ON DELETE CASCADE,
    role INTEGER,
    UNIQUE(student_id, course_id),
    PRIMARY KEY (id)
);

insert into student(name) values ('Jersey'), ('Alix'), ('Jace'), ('Kelice'), ('Kie'),
('Aizah'), ('Brook'), ('Elshan'), ('Ilsa'), ('Taisha'), ('Shanyse'),
('Blazej'), ('Dedeniseoluwa'), ('Jaslyn'), ('Rhonda');

select * from student;

insert into course (title) values ('si106'), ('si110'), ('si206');

select * from course;

insert into roster(student_id, course_id, role) values (1,1,1),
(2,1,0), (3,1,0), (4,1,0), (5,2,1), (6,2,0), (7,2,0), (8,2,0),
(9,2,0), (10,2,0), (11,3,1), (12,3,0), (13,3,0), (14,3,0), (15,3,0);

SELECT student.name, course.title, roster.role
    FROM student 
    JOIN roster ON student.id = roster.student_id
    JOIN course ON roster.course_id = course.id
    ORDER BY course.title, roster.role DESC, student.name;