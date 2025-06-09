/*
    DML(Data Manipulation Language)
    : 데이터 조작 언어로 테이블에 값을 삽입(INSERT)하거나,
        수정(UPDATE)하거나, 삭제(DELETE)하는 구문
        
    INSERT
    - 테이블에 새로운 행(데이터)을 추가하는 구문
    
    INSERT INTO 테이블명 VALUES(값, 값, ...);
    - 테이블에 모든 컬럼에 대한 값을 INSERT 하고자 할 때 사용
    - 컬럼 순번을 지켜서 VALUES 값을 나열해야 함
    INSERT INTO 테이블명(컬럼, 컬럼, ...) VALUES(값, 값, ...);
    - 테이블의 특정 컬럼에 대한 값만 INSERT 하고자 할 떄 사용
    - 선택 안 된 컬럼들은 기본적으로 NULL 값이 들어감
    - 기본값(DEFAULT)이 지정되어 있으면 기본값이 들어감
    
    INSERT INTO 테이블명 (서브쿼리);
    - VALUES 대신 서브쿼리로 조회한 결과값을 통째로 INSERT
    - 서브쿼리의 결과값이 INSERT문에 지정된 테이블 컬럼의 개수와
        데이터 타입이 같아야 함
*/
CREATE TABLE EMP_DML(
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(30) NOT NULL,
    DEPT_TITLE VARCHAR2(30),
    HIRE_DATE DATE DEFAULT SYSDATE
);
INSERT INTO EMP_DML
VALUES(100, '이승민', '서비스 개발팀', DEFAULT);

-- 모든 컬럼 값을 지정하지 않아서 에러
INSERT INTO EMP_DML
VALUES(200, '박기민', '개발 지원팀');

-- 에러는 발생하지 않지만 데이터가 잘못 저장
INSERT INTO EMP_DML
VALUES(300, '디자인팀', '성예찬', SYSDATE);

-- 컬럼 순서와 데이터 타입니 맞이 않아서 에러
INSERT INTO EMP_DML
VALUES('기획팀', 400, '이상엽', DEFAULT);

INSERT INTO EMP_DML(EMP_ID, EMP_NAME, DEPT_TITLE, HIRE_DATE)
VALUES(500, '조규상', '마케팅팀', NULL);

INSERT INTO EMP_DML(EMP_ID, EMP_NAME, DEPT_TITLE)
VALUES('최다인', 600, '인사팀');

-- EMP_NAME 컬럼에 NOT NULL 제약조건에 의해 에러
INSERT INTO EMP_DML(EMP_ID,DEPT_TITLE)
VALUES(700, '보안팀');

INSERT INTO EMP_DML (
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, HIRE_DATE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);

TRUNCATE TABLE EMP_DML;
INSERT INTO EMP_DML(EMP_ID, EMP_NAME) (
    SELECT EMP_ID, EMP_NAME
    FROM EMPLOYEE
);

/*
    INSERT ALL (오라클만 가능)
    두 개 이상의 테이블에 각각 INSERT하는데 동일한 서브 쿼리가 사용되는 경우
    INSERT ALL을 이용해 여러 테이블에 한 번에 데이터 삽입이 가능
    
    INSERT ALL
        INTO 테이블1(컬럼, ..) VALUES(값, ...)
        INTO 테이블2(컬럼, ..) VALUES(값, ...)
        서브쿼리;
        
    INSERT ALL
        WHEN 조건 1 THEN
            INTO 테이블1(컬럼, ...) VALUES(값, ...)
        WHEN 조건2 THEN
            INTO 테이블2(컬럼, ...) VALUES(값, ...)
        서브쿼리;
*/
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 1=0; -- FALSE 처리해서 틀만 만들 수 있음

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE 1=0;

-- EMPLOYEE에서 부서코드가 D1인 직원의 사번, 이름, 부서코드, 입사일
INSERT ALL
    INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE) -- 테이블() 안 컬럼값은 VALUES와 동일하기에 생략.
    INTO EMP_MANAGER VALUE(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';
    
-- EMPLOYEE에서 입사일 기준으로 2000년 1월 1일 이전 입사한 사원과
-- 이후 입사란 사원의 테이블을 분리
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
WHERE 0=1;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
WHERE 0=1;

SELECT * FROM USER_INFO;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD';
INSERT ALL
    WHEN HIRE_DATE < '2000/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE >= '2000/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE;

CREATE TABLE EMP_02
AS SELECT EMP_ID, EMP_NAME 
FROM EMPLOYEE WHERE 0=1;

CREATE TABLE USER_02
AS SELECT USER_ID, NAME, MBTI 
FROM USER_INFO WHERE 0=1;

SELECT * FROM EMP_02;
SELECT * FROM USER_02;

INSERT ALL
    INTO EMP_02(EMP_ID, EMP_NAME) VALUES(USER_ID, NAME)
    INTO USER_02 VALUES(USER_ID, NAME, MBTI)
    SELECT USER_ID, NAME, MBTI
    FROM USER_INFO;

TRUNCATE TABLE USER_02;
COMMIT; -- 오라클에선 테이블을 만들고 커밋을 해야 테이블 저장이 됨
--          (커밋 후 원치 않게 테이블을 바꾸면  ROLLBACK으로 마지막으로 커밋한 지점으로 이동 가능)
    
/*
    UPDATE
    - 테이블에 기록된 데이터를 수정하는 구문
    UPDATE 테이블명
    SET 
        컬럼명 = 변경하려는값,
        컬럼명 = 변경하려는값,
        ...
    WHERE 조건; -- 기본키(PRIMARY KEY)로 조건을 거는 게 일반적.
    
    - SET 절에서 여러 개의 컬럼을 콤마(,)로 나열해서 값을 동시에 변경할 수 있다.
    - WHERE 절을 생략하면 모든 행의 데이터가 변경된다.
*/
SELECT * FROM USER_02;

UPDATE USER_02
SET MBTI = 'INTP'
WHERE MBTI IS NULL;

COMMIT;

-- 사실 조건에서는 PROMARY KEY로 조건을 거는 것을 전제로 한다.

ROLLBACK;

-- MBTI가 ISFP인 사람들의 MBTI를 ENTJ로 변경
UPDATE USER_INFO
SET MBTI = 'ENTJ'
WHERE MBTI = 'ISFP';
-- EMPLOYEE에서 EMP_NAME이 선동일인 사람의 급여(SALARY)를 7000원, 보너스를 0.2로 변경
UPDATE EMPLOYEE
SET 
    SALARY = 7000,
    BONUS = 0.2
WHERE EMP_NAME = '선동일';

/*
    DELETE
    테이블에 기록된 데이터를 삭제하는 구문
    
    DELETE FROM 테이블명
    WHERE 조건식(기본키 - PRIMARY KEY);
    
    -- > WHERE 절을 제시하지 않으면 전체 행이 삭제됨
*/

-- MBTI ISFJ인 사람들 삭제
DELETE FROM USER_02
WHERE MBTI = 'ISFJ';

-- USER_02 사람들 전체 삭제
DELETE FROM USER_02;

-- TRUNCATE를 사용해서 사람들 전체 삭제
TRUNCATE TABLE USER_02; -- ROLLBACK 적용 X

ROLLBACK;
SELECT * FROM USER_02;





