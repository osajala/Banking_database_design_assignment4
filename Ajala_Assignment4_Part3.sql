/*
    Name: <Full Name>
    DTSC660: Data and Database Managment with SQL
    Module 6
    Assignment 4- PART 2
*/

----------------------------------------------------------------------------------------------------
/*				                 Query 8  
Write a query to return an alphabetical list of dept_names from the department table showing
all departments that are assigned to at least one instructor in the instructor table. You must use
a SET operator in your solution.
*/
----------------------------------------------------------------------------------------------------

SELECT dept_name FROM department
INTERSECT
SELECT dept_name FROM instructor  
ORDER BY dept_name;

----------------------------------------------------------------------------------------------------
/*				                  Query 9 
Write a query that returns a list of course_ids from the course table for courses that do not
have any prerequisites listed in the prereq table. This should be sorted from smallest to largest.
Your solution must use a SET operator.
*/
----------------------------------------------------------------------------------------------------

SELECT course_id FROM course
EXCEPT
SELECT course_id FROM prereq  
ORDER BY course_id;

----------------------------------------------------------------------------------------------------
/*				                  Query 10         
Write a query that returns an alphabetical list of dept_names for departments that satisfy one or
more of the following conditions:
● The department has a budget less than $50,000
● The department has at least one instructor whose salary is greater than $100,000
● The department has at least one student whose total credits are equal to the highest
total credits taken by any student.
Do not hardcode the maximum total credits, instead use an approach that works if this number
changes.Your solution must include at least one SET operator and at least one subquery. Do
not use JOINs.
*/
----------------------------------------------------------------------------------------------------
SELECT dept_name FROM department WHERE budget < 50000
UNION 
SELECT dept_name FROM instructor WHERE salary > 100000
UNION
SELECT dept_name FROM student WHERE tot_cred = (SELECT MAX(tot_cred) AS max_cred FROM student);
   
----------------------------------------------------------------------------------------------------
/*				                  Query 11      
Write a query that returns the course_id and title of courses and their prerequisites. Your output
should name the returned columns: course_id, course_name, prereq_id, prereq_name (in
that order). Only include courses that have prerequisites in the results.Your solution must use a
JOIN.
*/
----------------------------------------------------------------------------------------------------

SELECT a.course_id, a.course_name, a.prereq_id, c1.title AS prereq_name FROM
(SELECT c.course_id, c.title as course_name, p.prereq_id FROM
course c JOIN prereq p USING(course_id)) a
LEFT JOIN course c1 ON c1.course_id = a.prereq_id;

----------------------------------------------------------------------------------------------------
/*				                  Query 12  
Write a query to find the id of each student who has never taken a course at the university. Your
solution must use an OUTER JOIN- do not use any subqueries or set operations.
*/
----------------------------------------------------------------------------------------------------

SELECT s.id FROM
student s FULL OUTER JOIN takes t 
ON s.id = t.id
FULL JOIN course c USING(course_id)
WHERE c.course_id IS NULL;
    



  