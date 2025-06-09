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

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;