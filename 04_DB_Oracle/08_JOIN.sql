/*
    JOIN
    - 두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    - 조회 결과는 하나의 결과물(RESULT SET)로 나움

    - 관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 담고 있음
        (중복을 최소화하기 위해 최대한 쪼개서 관리함)
        부서 데이터는 부서 테이블, 사원 데이터는 사원 테이블, ...

        만약 어떤 사원이 어떤 부서에 속해있는지 부서명과 같이 조회하고 싶다면?

        => 즉, 관계형 데이터베이스에서 SQL문을 이용한 테이블 간에 "관계"를 맺어 원하는 데이터를 조회하는 방법

        "오라클 구문"과 "ANSI 구문"
        ANSI(미국국립표준협회 == 산업표준을 제정하는 단체)

*/
/*
    등가 조인(EQUAL JOIN) / 내부 조인(INNER/NATURAL JOIN)
    - 연결시키는 컬럼의 값이 일치하는 행들만 조인돼서 조회
    
    오라클 구문
    SELECT 컬럼, 컬럼, ...
    FROM 테이블1, 테이블2
    WHERE 테이블1.컬럼 = 테이블2.컬럼;

    ANSI 구문
    SELECT 컬럼, 컬럼, ...
    FROM 테이블1
        JOIN 테이블2 ON (테이블1.컬럼 = 테이블2.컬럼);
    - FROM 절에서 기준이 되는 테이블을 기술
    - JOIN 절에서 같이 조회하고자 하는 테이블을 기술 후 매칭시킬 컬럼에 대한 조건을 기술(USING 또는 ON)
        --> 연결에 사용하는 컬럼명이 같은 경우 USING(컬럼명)
*/
-- EMPLOYEE, DEPARTMENT 조인해서 
--  사번(EMP_ID), 사원명(EMP_NAME), 부서코드(DEPT_CODE), 부서명(DEPT_TITLE) 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT; -- DEPT_ID, DEPT_TITLE

-- 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON (EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID);
    
-- 사번(EMP_ID), 사원명(EMP_NAME), 직급코드(JOB_CODE), 직급명(JOB_NAME), 테이블: EMPLOYEE, JOB
-- 연결할 두 컬럼이 같은 경우
-- 1. 테이블명을 이용할 수 있다
-- 오라클 구문
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 2. 테이블에 별칭을 부여해서 이용
-- ANSI 구문
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);
    
-- 컬럼명이 같은 경우는 USING 사용 추천
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE);
    
-- 3. 자연조인(NATURAL JOIN): 각 테이블마다 동일한 컬럼이 한 개만 존재할 경우 (사용을 추천하진 않음)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
    NATURAL JOIN JOB;
    
-- 직급이 대리인 사원의 사번(EMP_ID), 이름(EMP_NAME), 직급명(JOB_NAME), 급여(SALARY) 조회
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
    WHERE JOB_NAME = '대리';
    
-- 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';
-- DEPARTMENT랑 LOCATION 참고해서 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM LOCATION
    JOIN DEPARTMENT ON (LOCATION_ID = LOCAL_CODE);
-- 부서가 총무부가 아닌 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '총무부';

/*
    포괄 조인 / 외부 조인(OUTER JOIN)
    - 두 테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회가 가능
    - 단, 반드시 기준이 되는 테이블(컬럼)을 지정해야 한다.
*/
-- 사원명, 부서명 조회
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE 
    LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE);
-- 기준 삼는 테이블의 반대 테이블의 컬럼 뒤에 (+) (이건 한 쪽에만 사용 가능)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_ID(+) = DEPT_CODE;

-- RIGHT JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE 
    RIGHT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE);
    
-- FULL JOIN = LEFT + RIGHT (LEFT, RIGHT, FULL 어느 테이블을 기준으로 NULL을 포함하여 모든 행을 보여줄지 고려하여 사용)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE 
    FULL JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE);
    
/*
    비등가 조인(NON EQUAL JOIN)
    - 매칭시킬 컬럼에 대한 조건 작성시 '='(등호)를 사용하지 않는 조인문
        --> 값의 범위에 포함되는 행들을 연결하는 방식
        -ANSI 구문으로는 JOIN ON으로만 사용가능 (USING 사용 불가)
*/
-- 사원명, 급여, 급여레벨 조회 (ON BETWEEN 사용)
SELECT * FROM SAL_GRADE;
SELECT * FROM EMPLOYEE;
SELECT EMP_NAME, SALARY, SAL_LEVEL 
FROM EMPLOYEE
    JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
    
/*
    자체 조인(SELF JOIN)
    - 같은 테이블을 다시 한번 조인하는 경우(자기 자신과 조인) -> 대댓글
*/
-- 사원 사번, 사원 명, 사원 부서코드, 사수 사번(MANAGER_ID), 사수명, 사수 부서코드 조회
SELECT * FROM EMPLOYEE;
SELECT E1.EMP_ID, E1.EMP_NAME, E1.DEPT_CODE, E1.MANAGER_ID, E2.EMP_NAME 사수명, E2.DEPT_CODE 사수부서코드
FROM EMPLOYEE E1
    JOIN EMPLOYEE E2 ON (E2.EMP_ID = E1.MANAGER_ID);
    
/*
    카테시안곱(CATESIAN PRODUCT) / 교차 조인(CROSS JOIN)
    - 조인되는 모든 테이블의 각 행들이 서로 모두 매핑된 데이터가 검색(곱집합)
    - 두 테이블의 행들이 모두 곱해진 행들의 조합이 출력
        -> 방대한 데이터 출력으로 과부하
*/
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    CROSS JOIN DEPARTMENT; -- 23 X 9
    
SELECT * FROM EMPLOYEE; -- 23개 항
SELECT * FROM DEPARTMENT; -- 9개 항

/*
    다중 JOIN
    - 여러 개의 테이블을 조인하는 경우
*/
-- 사원명, 부서명, 직급명 조회 / EMPLOYEE, DEPARTMENT, JOB
SELECT EMP_NAME, DEPT_CODE, JOB_CODE FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
SELECT JOB_CODE, JOB_NAME FROM JOB;

SELECT EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
    JOIN JOB USING (JOB_CODE);
    
-- 국가명, 지역명, 직급명, 부서명, 사원명, 급여, 급여등급 조회
-- NATIONAL, LOCATION, JOB, DEPARTMENT, EMPLOYEE, SAL_GRADE
SELECT * FROM NATIONAL;
SELECT * FROM LOCATION;
SELECT * FROM JOB;
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT SAL_LEVEL, MIN_SAL, MAX_SAL FROM SAL_GRADE;

SELECT NATIONAL_NAME 국가명, LOCAL_NAME 지역명, JOB_NAME 직급명, DEPT_TITLE 부서명, EMP_NAME 사원명, SALARY 급여, SAL_LEVEL 급여등급
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
    LEFT JOIN JOB USING (JOB_CODE)
    LEFT JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL)
    LEFT JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID)
    LEFT JOIN NATIONAL USING(NATIONAL_CODE);

COMMIT;

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;




