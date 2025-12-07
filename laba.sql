--1
SELECT
    count(students.student_id),
    course_name,
    group_name
FROM students
inner join groups_students on
students.student_id = groups_students.student_id
inner join groups on groups.group_id = groups_students.group_id
inner join courses on courses.course_id = groups.course_id
WHERE groups.start_date BETWEEN '2025-12-01' AND '2026-03-01'
GROUP BY course_name,group_name
ORDER BY group_name;


--2
SELECT
    course_name,
    COUNT(groups_students.student_id) as quantity,
    group_name
FROM students
inner join groups_students on
students.student_id = groups_students.student_id
inner join groups on groups.group_id = groups_students.group_id
inner join courses on courses.course_id = groups.course_id
WHERE groups_students.end_date::DATE BETWEEN '2026-02-01'::DATE AND '2026-03-01'::DATE
GROUP BY course_name,group_name
ORDER BY group_name;

--3
SELECT
    course_name,
    COUNT(groups_students.student_id) as quantity
FROM courses
INNER JOIN  groups ON groups.course_id = courses.course_id
INNER JOIN groups_students ON groups.group_id=groups_students.group_id
INNER JOIN students ON students.student_id = groups_students.student_id
WHERE groups_students.start_date::DATE BETWEEN '2025-01-01'::DATE AND '2026-03-01'::DATE
GROUP BY course_name
ORDER BY course_name;

--4
SELECT
    group_name,
    COUNT(groups_students.student_id) as quantity
FROM groups
INNER JOIN groups_students ON groups.group_id = groups_students.group_id
INNER JOIN courses on courses.course_id = groups.course_id
WHERE groups_students.start_date::DATE BETWEEN '2025-01-01'::DATE AND '2026-03-01' :: DATE
AND courses.course_name = 'Python 101'
GROUP BY group_name
ORDER BY group_name;

--5
SELECT
    group_name,
    COUNT(groups_students.student_id)  as quantity
FROM groups
INNER JOIN groups_students ON groups.group_id = groups_students.group_id
WHERE groups_students.end_date >= '2025-01-01'
AND groups.start_date = '2025-01-01'
AND groups.end_date = '2025-01-02'
GROUP BY group_name
ORDER BY group_name;

--6
SELECT
    course_name,
    group_name,
    COUNT(groups_students.student_id) as quantity
FROM groups
JOIN groups_students ON groups.group_id = groups_students.group_id
JOIN courses ON courses.course_id = groups.course_id
WHERE course_name = 'Morning Python'
AND groups_students.end_date < groups.end_date
GROUP BY course_name,group_name;

--7
SELECT
    group_name,
    COUNT(groups_students.student_id) as quantity
FROM groups
join groups_students on groups.group_id = groups_students.group_id
WHERE groups_students.end_date < '2026-04-08' ::DATE
GROUP BY group_name
ORDER BY group_name;


--8
SELECT
    students.name,
    students.surname,
    course_name,
    group_name,
    groups_students.start_date,
    groups_students.end_date
FROM groups
INNER JOIN groups_students on groups.group_id=groups_students.group_id
INNER JOIN students on groups_students.student_id = students.student_id
INNER JOIN courses on courses.course_id = groups.course_id
WHERE students.student_id IN (
    SELECT groups_students.student_id
    FROM groups_students
    JOIN groups ON groups_students.group_id = groups.group_id
    GROUP BY groups_students.student_id
    HAVING COUNT(DISTINCT groups.course_id) > 1
)
ORDER BY students.name, groups_students.start_date;


--9
SELECT
    group_name,
    course_name
FROM groups
INNER JOIN groups_students on groups.group_id = groups_students.group_id
INNER JOIN courses on courses.course_id = groups.course_id
INNER JOIN students on students.student_id = groups_students.student_id
WHERE students.student_id IN (SELECT
                                groups_students.student_id
                                FROM groups_students
                                JOIN groups ON groups.group_id = groups_students.group_id
                                WHERE groups_students.end_date < groups.end_date)
AND groups_students.end_date < '2026-04-08' ::DATE
GROUP BY group_name,course_name
ORDER BY  group_name,course_name;


SELECT
    course_name,
    COUNT(groups_students.student_id) as quantity
FROM courses
INNER JOIN groups ON groups.course_id = courses.course_id
INNER JOIN groups_students ON groups.group_id = groups_students.group_id
WHERE groups_students.end_date = groups.end_date
GROUP BY course_name
ORDER BY course_name;
