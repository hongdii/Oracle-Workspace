--01 SELECT
SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY AS "계열"
FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME||'의 정원은'|| CAPACITY || '명 입니다.' AS "학과별 정원"
FROM TB_DEPARTMENT;

SELECT STUDENT_NAME
FROM TB_STUDENT 
WHERE DEPARTMENT_NO = '001';

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <= 30;

SELECT STUDENT_NAME, DEPARTMENT_NO
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

SELECT PREATTENDING_CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N';

--02_SELECT
SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름, ENTRANCE_DATE AS 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

-- 3. 맞나
-- 2022-출생년도 +1 = 나이
SELECT PROFESSOR_NAME AS 교수이름, ( EXTRACT( YEAR FROM SYSDATE) - (SUBSTR(PROFESSOR_SSN, 1, 2)+1900) ) AS "나이"
FROM TB_PROFESSOR;
--ORDER BY "나이";

SELECT SUBSTR(PROFESSOR_NAME,2) AS 이름
FROM TB_PROFESSOR;

-- 5. 맞나
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE (EXTRACT( YEAR FROM ENTRANCE_DATE) - (SUBSTR(STUDENT_SSN, 1, 2)+1900) )!=19; 

SELECT TO_CHAR(TO_DATE('20/12/25'), 'DAY')
FROM DUAL;

SELECT TO_DATE('99/10/11', 'YY/MM/DD'), TO_DATE('49/10/10', 'YY/MM/DD'),
        TO_DATE('99/10/11', 'RR/MM/DD'), TO_DATE('49/10/11', 'RR/MM/DD')
FROM DUAL;
-- 순서대로 (20)99/10/11, (20)49/10/10, (19)99/10/11,   (20)49/10/10

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE  EXTRACT(YEAR FROM ENTRANCE_DATE) < 2000;

-- 9.
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NAME = '한아름';

SELECT ROUND(AVG(POINT), 1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10.
SELECT DEPARTMENT_NO AS "학과번호", CAPACITY AS "학생수(명)"
FROM TB_DEPARTMENT;

-- 11.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NO = 'A112113';

SELECT EXTRACT(YEAR FROM(TO_DATE(TERM_NO))) AS "년도", POINT AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113';

-- 13 모르겠음
SELECT DEPARTMENT_NO AS 학과코드명, COUNT(ABSENCE_YN) AS "휴학생 수"
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
GROUP BY ABSENCE_YN;

-- 14 모르겠음
SELECT STUDENT_NAME AS 동일이름, COUNT(DISTINCT STUDENT_NAME)
FROM TB_STUDENT
GROUP BY STUDENT_NAME;

-- 15 ?
SELECT ROUND(AVG(POINT), 1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113';



