--1. Write a procedure with parameter is section_id, return (OUT parameter) course_no, description, cost, number of student enrolled to this section.
--Write a pl/sql block to call this procedure.

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE PRINT_STUDENT1(secID SECTION.SECTION_ID%TYPE , C_NO OUT COURSE.COURSE_NO%TYPE, C_DES OUT COURSE.DESCRIPTION%TYPE, C_COST OUT COURSE.COST%TYPE, num  OUT INT)
AS

BEGIN
    SELECT c.COURSE_NO,c.DESCRIPTION,c.COST, COUNT(e.STUDENT_ID) INTO C_NO,C_DES,C_COST,NUM
    FROM COURSE c ,SECTION s, enrollment e
    WHERE s.SECTION_ID=secID AND s.COURSE_NO=c.COURSE_NO AND e.section_id=s.section_id
    GROUP BY c.COURSE_NO,c.DESCRIPTION,c.COST,s.SECTION_ID;
END;
/
DECLARE
    c_NO COURSE.COURSE_NO%TYPE;
    c_DES COURSE.DESCRIPTION%TYPE;
    c_COST COURSE.COST%TYPE;
    num INT;
BEGIN
    PRINT_STUDENT1(85,c_NO,c_DES,c_COST,num);
    DBMS_OUTPUT.PUT_LINE('Course no: ' || c_NO );
    DBMS_OUTPUT.PUT_LINE('Description: ' || c_DES );
    DBMS_OUTPUT.PUT_LINE('COST: ' || c_COST );
    DBMS_OUTPUT.PUT_LINE('NUMBER OF STUDENT ENROLLED TO THIS SECTION: ' || num );

END;
/*
Course no: 25
Description: Intro to Programming
COST: 1195
NUMBER OF STUDENT ENROLLED TO THIS SECTION: 5
*/

--4. Write a trigger: When inserting or updating data of employee_change table, title of employee is always converted to lowercase letter.
--Write two statements to insert and update data of employee_change table.

CREATE OR REPLACE TRIGGER TRIGGER_Employee6
BEFORE INSERT OR UPDATE ON EMPLOYEE_CHANGE
FOR EACH ROW
BEGIN
    :NEW.TITLE :=LOWER(:NEW.TITLE);

END;

/
Insert into EMPLOYEE_CHANGE (EMPLOYEE_ID,NAME,SALARY,TITLE) values (10,'Chris',3000,'CLERK');

UPDATE EMPLOYEE_CHANGE SET  SALARY=2999 WHERE EMPLOYEE_ID=7;

SELECT * FROM EMPLOYEE_CHANGE WHERE EMPLOYEE_ID=7 OR EMPLOYEE_ID=10;
/*
10	Chris	3000	clerk
7	JOHNATHAN	2999	clerk
*/
