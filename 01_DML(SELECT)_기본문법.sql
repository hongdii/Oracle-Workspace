-- DML : 데이터 조작 , SELECT(DQL) , INSERT, UPDATE, DELETE
-- DDL : 데이터 정의 , CREATE , ALTER , DROP
-- TCL : 트랜젝션 제어, COMIT , ROLLBACK
-- DCL : 권한부여 , GRANT , REVOKE

/*
    <SELECT>
    데이터를 조회하거나 검색할 때 사용하는 명령어
    - RESULT SET : SELECT 구문을 통해 조회된 데이터의 결과물을 의미
                    즉, 조회된 행들의 집합
    [표현법]
    SELECT 조회하고자 하는 컬럼명, 컬럼명2, 컬럼명3, ...
    FROM 테이블명;
    
*/
-- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여 칼럼만을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;
-- 쿼리문은 대부분 대문자로 작성
-- 가독성을 위해 위와 같이 작성. SELECT와 FROM문 붙여서 적어도 에러는 안남.

-- EMPLOYEE테이블에서 전체 사원들의 모든 칼럼을 조회
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 전체 사원들의 이름, 이메일, 휴대폰 번호를 조회
SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE;

--------------------- 실습문제 -----------------------
-- 1번 . JOB 테이블의 모든 칼럼 조회
SELECT *
FROM JOB;

-- 2번 . JOB 테이블의 직급명만 조회
SELECT JOB_NAME
FROM JOB;

-- 3번 . DEPARTMENT 테이블의 모든 칼럼 조회
SELECT *
FROM DEPARTMENT;

-- 4번 . EMPLOYEE테이블의 직원명, 이메일, 전화번호, 입사일 칼럼만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5번 . EMPLOYEE테이블의 입사일, 직원명, 급여칼럼만 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    조회하고자 하는 칼럼들을 나열하는 SELECT 절에서 산술연산(+-/%)을 기술해서 결과를 조회할수 있다.
*/

-- EMPLOYEE 테이블로부터 직원명과 , 월급, 연봉
SELECT EMP_NAME, SALARY, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블로부터 직원명과 월급 보너스, 보너스가 포함된 연봉.(SALARY + SALARY * BONUS)*12
SELECT EMP_NAME, SALARY, BONUS, (SALARY + SALARY * BONUS) * 12
FROM EMPLOYEE;
--> 산술연산 과정에서 NULL 값이 존재할 경우 산술연산 결과마저도 NULL이된다.

-- EMPLOYEE 데이블로부터 직원명, 입사일, 근무일수(오늘날짜 - 입사일) 조회
-- DATE 타입끼리도 연산이 가능 (DATA -->년, 월, 일, 시, 분, 초)
-- 오늘날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- 결과값이 지저분한 이유 : DATE타입 안에 포함된 시, 분, 초에 대한 연산까지 수행하기때문.
-- 결과값은 일수 단위로 출력.

/*
    <컬럼명에 별칭부여하기>
    [표현법]
    컬럼명 AS 별칭,  컬럼명 AS "별칭", 컬럼명 별칭, 컬럼명 "별칭"
    
    AS 키워드는 있어도되고 없어도된다.
    
    AS 키워드를 붙이든 안붙이든 간에 
    별칭에 특수문자나 띄어쓰기가 포함된 경우 ""를  묶어서 표기해줘야함.
*/

-- EMPLOYEE 테이블로부터 직원명과 , 월급, 연봉
SELECT EMP_NAME, SALARY AS "급여(월)", SALARY * 12 AS "연봉(보너스 미포함)"
FROM EMPLOYEE;

-- EMPLOYEE 데이블로부터 직원명, 입사일, 근무일수(오늘날짜 - 입사일) 조회
-- DATE 타입끼리도 연산이 가능 (DATA -->년, 월, 일, 시, 분, 초)
-- 오늘날짜 : SYSDATE
SELECT EMP_NAME AS "사원명", HIRE_DATE AS "입사일", SYSDATE - HIRE_DATE AS "근무일수"
FROM EMPLOYEE;

/*
    < 리터럴 >
    임의로 지정한 문자열('')을 SELECT절에 기술하면     
    실제 그 테이블에 존재하는 데이터처럼 조회가 가능하다.
*/

-- EMPLOYEE 테이블로부터 사번, 사원명, 급여, 단위('원') 조회하기
SELECT EMP_ID, EMP_NAME, SALARY , '원' AS 단위
FROM EMPLOYEE;

/*
    DISTINCT : 분명한
    <DISTINCT>
    조회하고자 하는 칼럼에 중복된 값을 딱 한번만 조회하고자 할 때 사용
    해당 칼럼명 앞에 기술
    
    [표현법]
    DISTINCT 칼럼명
    (단, SELECT 절에 DISTINCT 구문은 단 한개만 가능하다.)
*/
-- EMPLOYEE테이블에서 부서코드들만 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- DEPT_CODE와 JOB_CODE 값을 세트로 묶어서 중복판별.
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

---------------------------------------------------------
/*
    <WHERE 절>
    조회하고자 하는 테이블에 특정 조건을 제시해서 
    그 조건을 만족하는 데이터들을 조회하고자 할 때 기술하는 구문
    
    [표현법]
    SELECT 조회하고자하는 컬럼명, ...
    FROM 테이블명
    WHERE 조건식; --> 조건에 해당하는 행들을 뽑아내겠다.
    
    실행순서
    FROM, WHERE, SELECT
    
    - 조건식에 다양한 연산자들 사용 가능
    
    <비교연산자>
    >, <, >=, <=
    - (일치하는지 여부, 자바에서는 == 였음)
    !=, ^=, <> 일치하지 않는가.
*/

-- EMPLOYEE테이블에서 급여가 400만원 이상인 사원들만 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';     -- D9 값 자체를 조건식에 사용할때는 ''홀따옴표 작성
                            -- 오라클에서는 동등비교가 = 임

-- EMPLOYEE 테이블로부터 부서코드가 D9가 아닌 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE 
    -- DEPT_CODE != 'D9';
    -- DEPT_CODE ^= 'D9';
    DEPT_CODE <> 'D9';
    
    -- !=, ^=, <> 모두 같지 않다 기호임. !=를 사용하지 못하는 컨트롤러도있음
----------------실습문제---------------------------------------------
-- 1. EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE 테이블에서 직급코드가 J2인 사원들의 이름 급여 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';
    -- ENT_DATE = NULL; => 제대로 출력되지 않는 잘못된 문장
                      -- NULL은 동등비교연산으로 비교하지않음
    -- ENT_DATE IS NULL; => 제대로 된 문장

-- 4. EMPLOYEE 테이블에서 연봉(급여*12)이 5000만원 이상인 사원들의 이름 급여 연봉 입사일 조회
SELECT  EMP_NAME, SALARY , SALARY * 12 AS "연봉" , HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY*12) >= 50000000;
-- SELECT절에서 부여한 별칭은 WHERE절에서 사용할 수 없다.
-- WHERE절에 우선적으로 실행되기때문

/*
    SELECT  *
    FROM {
        SELECT  EMP_NAME, SALARY , SALARY * 12 AS "연봉" , HIRE_DATE
        FROM EMPLOYEE
    } C
    WHERE 연봉 >= 50000000;
*/ -- 이렇게 해서 별칭을 WHERE절에서 사용 가능

/*
    <논리연산자>
    여러개의 조건을 엮을때 사용
    AND(자바 :&&) , OR(자바 :||)
    AND : ~이면서 , 그리고
    OR : ~이거나 , 또는
*/

-- EMPLOYEE 테이블에서 부서코드가 D9이면서 급여가 500만원이상인 사원들의 이름, 부서코드, 급여 조회
SELECT 
    EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 D6이거나 급여가 300만원 이상이면서 재직중인 사원들의 이름, 부서코드 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D6' OR SALARY >= 3000000) AND ENT_YN = 'N';
-- OR 연산 같은 경우 괄호로 묶어주는 것이 좋음

-- 급여가 350 만원 이상이고 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT 
    EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000; -- <=SALARY<= 불가
/*
    <BETWEEN AND>
    몇 이상 몇 이하인 범위에 대한 조건을 제시할때 사용.
*/
SELECT 
    EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- 급여가 350만원 미만이고, 600만원 초과인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE 
-- SALARY < 3500000 OR SALARY > 6000000;
    SALARY NOT BETWEEN 3500000 AND 6000000;
    -- NOT SALARY BETWEEN 3500000 AND 6000000; 도 가능
    -- 오라클의 NOT은 자바의 논리부정연산자와 동일함.

-- ** BETWEEN가지고 DATE형식간에도 비교 가능.
-- 입사일이 '90/01/01' ~ '03/01/01'인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE 
    -- HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
    HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';
    -- BETWEEN으로 작성하는 것이 효율적
    
/*
    <LIKE '특정패턴'>
    비교하고자 하는 컬럼값이 내가 지정한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    컬럼명 LIKE '특정패턴'
    
    - 옵션 : 특정패턴 부분에 와일드카드인 '%' , '_' 를 가지고 제시할 수 있음.
    
    '%' : 0글자 이상
            비교대상 컬럼명 LIKE '문자%' => 컬럼값중에 '문자'로 시작하는 것을 조회
            비교대상 컬럼명 LIKE '%문자' => 컬럼값중에 '문자'로 끝나는 것을 조회
            비교대상 컬럼명 LIKE '%문자%' => 컬럼값중에 '문자'가 포함되는 것을 조회
            
    '_' : 1글자
            비교대상 컬럼명 LIKE '_문자' => 컬럼값중에 '문자'앞에 무조건 1글자가 존재하는 경우 조회
            비교대상 컬럼명 LIKE '__문자' => 컬럼값중에 '문자'앞에 무조건 2글자가 존재하는 경우 조회
*/

-- 성이 전씨인 사원들의 이름, 급여, 입사일을 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름 중에 '하'가 포함된 사원들의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 전화번호 4번째자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';   -- (언더바3번)9모든숫자와도됨

-- 이름 가운데 글자가 '지'인 사원들의 모든 칼럼
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_지_';

-- 시험문제나옴
-- 내가 찾고자하는 문자 -> _ %
-- ha_iy@kh.or.kr
-- sun_di@kh.or.kr
-- _ 기준으로 앞에 딱 2글자만 있는 이메일
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '__\_%' ESCAPE '\';    -- 탈출문자지정
-- '\' 뒤의 글자를 특정패턴으로써가 아닌, 문자로 지정해줌

-------------------------------- 실습문제 ----------------------------
-- 1. 이름이 '연'으로 끝나는 사원들의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 3. DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

/*
    <IS NULL>
    해당 값이 NULL인지 비교해주는 구문.
    
    [표현법]
    비교대상칼럼 IS NULL : 컬럼값이 NULL인 경우
    비교대상칼럼 IS NOT NULL : 컬럼값이 NULL이 아닌 경우
*/

-- 보너스를 받지 않는 사원들(BONUS칼럼의 값이 NULL)의 사번, 이름, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;    -- NULL값은 동등비교하려면 무조건 IS를 사용함.

-- 사수가 없는 사원들의 사원명, 사수번호, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 사수도 없고 부서도 배치받지 못한 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 부서배치는 받지 않았지만 보너스는 받는 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
    <IN>
    비교 대상 칼럼 값에 내가 제시한 목록들중 일치하는 값이 있는지 판단
    
    [표현법]
    칼럼명 IN (값, 값, 값 ,값 ,...)
*/

-- 부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, 
       DEPT_CODE,
       SALARY
FROM EMPLOYEE
WHERE 
    -- DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
    DEPT_CODE IN ('D6', 'D8', 'D5');

-- 직급코드가 J1, J3, J4가 아닌 사원들의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE NOT IN ('J1', 'J3', 'J4');
-- IN 많이 쓰임

/*
    <연결연산자 ||>
    여러 컬럼값들을 마치 하나의 컬럼인 것처럼 연결시켜주는 연산자
    컬럼과 리터럴(임의의 문자열값 등)을 연결할 수 있음.
    
    자바 : System.out.println("num : " + num);
*/

SELECT EMP_ID || EMP_NAME || SALARY AS "연결"
FROM EMPLOYEE;

-- XX번 XXX의 월급은 XXXX원 입니다. AS 급여정보
SELECT EMP_ID || '번 ' || EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS 급여정보
FROM EMPLOYEE;

/*
    <연산자 우선순위>
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. NOT
    7. AND
  ★ 8. OR
  -- 뭐가 먼저 실행될지 모를땐 괄호로 우선순위 정해주기
  ----------------------------------------
  
  <ORDER BY 절>
  SELECT 문 가장 마지막에 기입하는 구문뿐만 아니라 가장 마지막에 실행되는 구문
  최종 조회된 결과물들에 대해서 정렬 기준을 세워주는 구문.
  
  [표현법]
  SELECT 컬럼명1, 컬럼명2, ...
  FROM 테이블명
  WHERE 조건식(생략가능)
  ORDER BY [정렬 기준으로 세우고자 하는 칼럼명/별칭/컬럼순번] [ASC/DESC](생략가능) [NULLS FIRST/NULLS LAST](생략가능)
*/

-- 월급이 높은 사람들부터 나열하고 싶다.(내림차순)
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- 보너스 기준 정렬
SELECT *
FROM EMPLOYEE
-- ORDER BY BONUS; -- ASC(오름차순) && NULLS LAST 요 두개가 기본값.
-- ORDER BY BONUS ASC NULLS FIRST;
-- ORDER BY BONUS DESC; -- NULLS FIRST 기본값
ORDER BY BONUS DESC, SALARY ASC;
--> 첫번째로 제시한 정렬기준 컬럼값이 일치할 경우 두번째 정렬기준을 가지고 다시 정렬.

-- 연봉기준 줄세우기
SELECT NAME, SALARY, SARRARY *12 AS 연봉
FROM EMPLOYEE
ORDER BY 3;
        -- 연봉 DESC;
        -- 연봉 (SALARY * 12)DESC; 
 
 --> ORDER BY 절은 숫자뿐만아니라 문자열, 날짜에 대해서도 정렬가능하다.











