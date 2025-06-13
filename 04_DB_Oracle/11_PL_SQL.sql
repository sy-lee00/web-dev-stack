-- 이건 sqldevloper로 돌리는 걸 추천(똑같이 실행해도 다르게 나옴)

/*
    PL/SQL (PROCEDURE LANGUAGE EXTENSION TO SQL)
    - 오라클에서 제공하는 절차적인 프로그래밍 언어
    - SQL 문장 내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP, FOR, WHITE) 등을
        지원하는 SQL의 단점을 보완
    - 다수의 SQL 문을 한번에 실행 가능(BLOCK 구조)
    
    
    * 블록(BLOCK): 명령어를 모아 둔 PL/SQL 프로그램의 기본 단위
    
    * PL/SQL 구조
    - [선언부(DECLARE SECTION)]
        : DECLARE 시작, 변수나 상수를 선언 및 초기화
    - 실행부(EXECUTABLE SECTION) --> 얜 []가 없는데 필수기 때문. 나머지는 선택
        : BEGIN 시작, SQL문 또는 제어문(조건문, 반복문) 등의 로직을 기술하는 부분
    - [예외처리부(EXCEPTION SECTION)]
        : EXCEPTION 시작, 예외 발생 시 해결하기 위한 구문을 미리 기술
*/
SET SERVEROUTPUT ON; 
-- 이거 한번은 실행해 줘야 콘솔탭에 명시가 됨
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
-- / <-- 무조건 명시!

/*
    DECLARE 선언부
    - 변수 및 상수를 선언하는 공간(선언과 동시에 초기화도 가능)
    - 일반 타입 변수, 레퍼런스 타입 변수, ROW 타입 변수
*/
-- 일반 타입 변수: 변수명 [CONSTANT] 자료형 [:= 값];
DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14; -- 상수값 지정
BEGIN
    EID := &번호;
    ENAME := '&이름';
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

-- 레퍼런스 타입 변수: 변수명 테이블명.컬럼명%TYPE;
-- 박나라 사원의 사번, 직원명, 급여 정보를 조회해서 출력
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_NAME = '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

/*
    EMPLOYEE, DEPARTMENT 테이블
    컬럼: EMP_ID, EMP_NAME, DEPT_TITLE
    조회: EMP_ID로 해당 부서가 어디인지
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    INTO EID, ENAME, DTITLE
    FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
    WHERE EMP_ID = '&사번';
    
    DBMS_OUTPUT.PUT_LINE('사번이 ' || EID || '인 사람의 부서는 ' || DTITLE || '입니다.');
END;
/

/*
    실행부
    제어문 (조건문, 반복문), 쿼리문 등의 로직을 기술
    
    1. IF 문
    IF 조건식 THEN 실행내용 END IF;
*/
-- 사번을 입력받은 후 해당 사원의 이름, 보너스 출력
-- 단, 보너스를 받지 않는 사원은 보너스 출력 전에 '보너스를 지급받지 않는 사원입니다.;

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '%사번';
    
    IF 
        EMP.BONUS IS NULL THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('보너스는 ' || EMP.BONUS);
END;
/
/*
    IT 조건식 THEN 실행내용
    ELSE 실행내용
    END IF;
*/
-- 보너스가 있는 경우만 보너스 출력, 없으면 해당 문구 출력
DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF 
        EMP.BONUS IS NOT NULL THEN DBMS_OUTPUT.PUT_LINE(EMP.BONUS);
    ELSE DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
END;
/

/*
    IF ~ ELSIF ~ ELSE
    IF 조건식1 THEN 실행내용1
    ELSIF 조건식2 THEN 실행내용2
    ...
    ELSE 실행내용N
    END IF;
*/
-- 사용자에게 점수를 입력받아 SCORE 변수(데이터타입: NUMBER)에 저장한 후
-- 학점은 입력된 점수에 따라 GRADE 변수(데이터타입: CHAR(1))에 저장
-- 출력은 '당신의 점수는 95점이고, 학점은 A학점입니다.'
-- 90점 이상은 'A', 80점 이상은 'B', 70점 이상은 'C', 60점 이상은 'D', 60점 미만은 'F'
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN 
    SCORE := '&점수';
    IF
        SCORE >= 90 THEN GRADE := 'A';
    ELSIF 
        SCORE >= 80 THEN GRADE := 'B';
    ELSIF 
        SCORE >= 70 THEN GRADE := 'C';
    ELSIF 
        SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || ' 점이고, 학점은 ' || GRADE || '학점입니다.');
END;
/

/*
    테이블은 EMPLOYEE, 컬럼은 SALARY
    500만원 이상이면 '고급', 300만원 이상이면 '중급', 300만원 미만이면 '초급'
    사원의 사번을 입력받아서 '해당 사원의 급여 등급은 고급입니다.'
*/
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    EMP_LEVEL VARCHAR2(6);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    IF EMP.SALARY >= 5000000 THEN EMP_LEVEL := '고급';
    ELSIF EMP.SALARY >= 3000000 THEN EMP_LEVEL := '중급';
    ELSE EMP_LEVEL := '초급';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여 등급은 ' || EMP_LEVEL || '입니다.');
END;
/

/*
    CASE 비교대상자
        WHEN 비교값1 THEN 결과값1
        WHEN 비교값2 THEN 결과값2
        ...
        ELSE 결과값N
    END CASE
*/
-- 사번을 입력받은 후 부서코드에 따라 
-- D1인 경우는 개발팀, D2인 경우는 디자인팀, D3인 경우는 기획팀, 그 외에는 서비스팀
-- 출력: '해당 사원 이름 OOO는 개발팀입니다'
SELECT * FROM EMPLOYEE;
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR(30);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '개발팀'
                WHEN 'D2' THEN '디자인팀'
                WHEN 'D3' THEN '기획팀'
                ELSE '서비스팀'
            END;
    
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '는(은) ' || DNAME || '입니다');
END;
/

/*
    반복문
    
    LOOP
        반복적으로 실행할 구문;
        
        * 반복문을 빠져나갈 수 있는 구문
        1) IF 조건식 THEN EXIT; END IF;
        2) EXIT WHEN 조건식;
    END LOOP;
*/
-- 1 ~ 5까지 1씩 증가하는 값을 출력
DECLARE
    NUM NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM + 1;
        EXIT WHEN NUM > 5;
    END LOOP;
END;
/

/*
    FOR LOOP
    
    FOR 변수 IN 초기값..최종값
    LOOP
        반복적으로 실행할 구문;
    END
*/
-- 1 ~ 5까지 1씩 증가하는 값을 출력
BEGIN
    FOR NUM IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
    END LOOP;
END;
/

/*
    WHILE LOOP
    WHILE 
    END LOOP;
*/
DECLARE
    NUM NUMBER := 1;
BEGIN
    WHILE NUM <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM + 1;
    END LOOP;
END;
/
/*
    구구단 출력(2~9단)
*/
-- LOOP
DECLARE
    NUM1 NUMBER := 2;
    NUM2 NUMBER := 1;
BEGIN
    WHILE NUM1 < 10
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM1 || ' x ' || NUM2 || ' = ' || NUM1 * NUM2);
        NUM2 := NUM2 + 1;
        IF(NUM2 > 9) THEN NUM1 := NUM1 + 1;
                            NUM2 := 1;
        END IF;
    END LOOP;
END;
/
-- FOR
BEGIN
    FOR NUM1 IN 2..9
    LOOP
        FOR NUM2 IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(NUM1 || ' x ' || NUM2 || ' = ' || NUM1 * NUM2);
        END LOOP;
    END LOOP;
END;
/
-- WHILE
DECLARE
    NUM NUMBER := 1;
    DAN NUMBER := 2;
BEGIN
    WHILE DAN > 9
END;
/
    
/*
    예외처리부
    예외(EXCEPTION): 실행 중 발생하는 오류
    
    EXCEPTION
        WHEN 예외명1 THEN 예외처리구문1;
        WHEN 예외명2 THEN 예외처리구문2;
        ...
        
    * 오라클에서 미리 정의되어 있는 시스템 예외
    - NO_DATA_FOUND: SELECT한 결과가 한 행도 없는 경우
    - TOO_MANY_ROWS: SELECT한 결과가 한 행이 리턴되어야 하는데 여러 행인 경우
    - ZERO_DIVIDE: 숫자를 0으로 나눌 때
    - DUP_VAL_ON_INDEX: UNIQUE 제약조건에 위배되었을 경우
    ...
*/
BEGIN
    DBMS_OUTPUT.PUT_LINE(10 / &숫자);
EXCEPTION
    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌 수 없습니다');
END;
/

-- EMPLOYEE에서 부서코드(DEPT_CODE)를 입력받아서
-- 사원을 조회하려고 할 때
-- NO_DATA_FOUND: 조회 결과가 없습니다
-- TOO_MANY_ROWS: 너무 많은 행이 조회되었습니다
SELECT * FROM EMPLOYEE;
DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE DEPT_CODE = '&부서코드';
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('조회 결과가 없습니다');
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('너무 많은 행이 조회되었습니다');
END;
/