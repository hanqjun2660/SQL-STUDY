/* SQL 응용 다지기 139 
PL/SQL 변수 이해하기 1 */
-- 두수를 각각 물어보게 하고 입력받아 두수의 합이 결과로 PL/SQL을 작성.
SET SERVEROUTPUT ON;    
ACCEPT P_NUM1 PROMPT    '첫 번째 숫자를 입력하세요.'
ACCEPT P_NUM2 PROMPT    '두 번째 숫자를 입력하세요.'

DECLARE
        V_SUM NUMBER(10);

BEGIN
      V_SUM := &P_NUM1 + &P_NUM2;
      DBMS_OUTPUT.PUT_LINE('총합은 :' || V_SUM);
END;

-- PL/SQL은 PROCEDURE LANGUAGE SQL의 약자로 비절차적인 언어인 SQL에 프로그래밍 요소를 가미하여 절차적으로 처리할 수 있도록 하는 데이터베이스 프로그래밍 언어이다.
-- :=는 할당연산자이다.
-- DBMS_OUTPUT.PUT_LINE으로 프로시저 출력이 안될때 먼저 실행하면 정상동작한다.
/*
    DECLARE : 변수, 상수, 커서, 예외등 선언가능
    BEGIN : 실행절로 실행할 실행문을 기술
    END : PL/SQL문 블록을 종료
*/

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 140
PL/SQL 변수 이해하기 2 */
-- 사원 번호를 물어보게 하고 사원 번호를 입력하면 해당 사원의 월급이 출력되게 하는 PL/SQL을 작성하자
SET SERVEROUTPUT ON;

ACCEPT P_EMPNO PROMPT '사원 번호를 입력하세요'
DECLARE
        V_SAL NUMBER(10);

BEGIN
      SELECT 
             SAL INTO V_SAL
        FROM EMP
       WHERE EMPNO = &P_EMPNO;
      
      DBMS_OUTPUT.PUT_LINE('해당 사원의 월급은 ' || V_SAL);
      
END;

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 141
PL/SQL IF 이해하기 1 (IF ~ ELSE문) */
-- 숫자를 물어보게 하고 숫자를 입력하면 해당 숫자가 짝수인지 홀수인지 출력되게 하는 PL/SQL을 작성해보자
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM PROMPT '숫자를 입력하세요 ~ '
BEGIN
        IF MOD(&P_NUM, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('짝수입니다.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('홀수입니다.');
        END IF;
END;

-- SET VERIFY OFF를 사용하면 변수에 들어가는 값을 보여주는 과정을 보여주지않는다.
-- IF문을 종료하기 위해 END IF로 종료한다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 142
PL/SQL IF 이해하기 2 (IF ~ ELSE IF ~ ELSE 문) */
-- 이름을 입력받아 해당 사원의 월급이 3000 이상이면 고소득자, 2000이상이고 3000보다 작으면 중간 소득자, 아니면 저소득자 메세지를 출력하는 PL/SQL문을 작성
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_ENAME PROMPT '이름을 입력하세요 ~'
DECLARE
        V_ENAME EMP.ENAME%TYPE := UPPER('&P_ENAME');
        V_SAL EMP.SAL%TYPE;

BEGIN
        SELECT SAL INTO V_SAL
          FROM EMP
         WHERE ENAME = V_ENAME;
         
        IF V_SAL >= 3000 THEN
            DBMS_OUTPUT.PUT_LINE('고소득자입니다.');
        ELSIF V_SAL >= 2000 THEN
            DBMS_OUTPUT.PUT_LINE('중간 소득자입니다.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('저소득자 입니다.');
        END IF;
END;

-- ELSE IF문을 작성할땐 ELSIF로 작성해야한다. (ELSE IF)로 작성시 에러발생
-- %TYPE이란 변수의 데이터 타입을 EMP테이블의 해당컬럼 데이터 타입으로 설정하겠다는 뜻이다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 143
PL/SQL BASIC LOOP 이해하기 */
-- PL/SQL의 BASIC LOOP문으로 구구단 2단을 출력
DECLARE
        V_COUNT NUMBER(10) := 0;
BEGIN
        LOOP
            V_COUNT := V_COUNT + 1;
            DBMS_OUTPUT.PUT_LINE('2 X ' || V_COUNT || ' = ' || 2 * V_COUNT);
            EXIT WHEN V_COUNT = 9;
        END LOOP;
END;

-- LOOP문을 이용하면 특정 실행문을 반복하여 실행할 수 있다.
-- EXIT WHEN으로 LOOP 종료 조건을 정할 수 있다.
-- END LOOP문을 이용하여 LOOP를 종료한다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 144
PL/SQL WHILE LOOP 이해하기 */
-- PL/SQL의 WHILE LOOP문으로 구구단 2단을 출력해 보겠습니다.
DECLARE
        V_COUNT NUMBER(10) := 0;
BEGIN
        WHILE V_COUNT < 9 LOOP
            V_COUNT := V_COUNT + 1;
            DBMS_OUTPUT.PUT_LINE('2 X ' || V_COUNT || ' = ' || 2 * V_COUNT);
        END LOOP;
END;

-- WHILE LOOP는 BASIC LOOP와 다르게 EXIT WHEN절이 없다. 대신 WHILE과 LOOP 사이 해당 조건이 TRUE일때만 LOOP가 수행된다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 145
PL/SQL FOR LOOP 이해하기 */
-- PL/SQL의 FOR LOOP문으로 구구단 2단을 출력
BEGIN
        FOR I IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE('2 X ' || I || ' = ' || 2 * I );
        END LOOP;
END;

-- BASIC, WHILE, FOR LOOP문중 가장 간결하다.
-- FOR 인덱스 IN 하한값..상한값 으로 작성하여 사용한다.
-- BASIC, WHILE보다 무한루프에 빠질 위험이 적다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 146
PL/SQL 이중 LOOP문 이해하기 */
-- PL/SQL의 이중 FOR LOOP문을 이용하여 구구단 2단부터 9단까지 출력
PROMPT 구구단 전체를 출력합니다.
BEGIN
    FOR I IN 2..9 LOOP
        FOR J IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || I * J);
        END LOOP;
    END LOOP;
END;

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 147
PL/SQL CURSOR문 이해하기 (BASIC LOOP) */
/* 
    PL/SQL의 커서문과 BASIC 루프문을 활용해서 부서 번호를 물어보게 하고, 부서 번호를 입력하면
    해당 부서 사원 이름, 월급, 부서 번호가 출력되게 해보자
*/
DECLARE
        V_ENAME EMP.ENAME%TYPE;
        V_SAL EMP.SAL%TYPE;
        V_DEPTNO EMP.DEPTNO%TYPE;
        
        CURSOR EMP_CURSOR IS
            SELECT
                   ENAME,
                   SAL,
                   DEPTNO
              FROM EMP
             WHERE DEPTNO = &P_DEPTNO;
BEGIN
        OPEN EMP_CURSOR;
            LOOP
                FETCH EMP_CURSOR INTO V_ENAME, V_SAL, V_DEPTNO;
                EXIT WHEN EMP_CURSOR%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(V_ENAME || ' ' || V_SAL || ' ' || V_DEPTNO);
            END LOOP;
        CLOSE EMP_CURSOR;
END;

-- CURSOR는 PL/SQL에서 데이터를 저장할 메모리영역을 뜻한다.
-- CURSOR는 테이블내 데이터를 한건씩 가져오는게 아닌 여러 ROW를 한번에 가지고오기위해 사용된다.
-- CURSOR는 OPEN / CLOSE로 열고 닫는다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 148
PL/SQL CURSOR문 이해하기 (FOR LOOP) */
-- PL/SQL의 커서문과 FOR 루프문을 활용해서 부서 번호를 물어보게 하고, 부서 번호를 입력하면 해당 사원의 이름, 월급, 부서 번호가 출력
ACCEPT P_DEPTNO PROMPT '부서 번호를 입력하세요 ~ '
DECLARE
        CURSOR EMP_CURSOR IS
            SELECT
                   ENAME,
                   SAL,
                   DEPTNO
              FROM EMP
             WHERE DEPTNO = &P_DEPTNO;
BEGIN
    FOR EMP_RECORD IN EMP_CURSOR LOOP
        DBMS_OUTPUT.PUT_LINE(EMP_RECORD.ENAME || ' ' || EMP_RECORD.SAL || ' ' || EMP_RECORD.DEPTNO );
    END LOOP;
END;

-- CURSOR의 데이터를 EMP_RECORD 변수에 한행씩 담아낸다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 149
PL/SQL CURSOR FOR LOOP문 이해하기 */
-- 서브 쿼리를 사용한 CURSOR FOR LOOP문을 사용하여 148번 예제를 단순화해보자
ACCEPT P_DEPTNO PROMPT '부서 번호를 입력하세요 ~ '
BEGIN
    FOR EMP_RECORD IN (SELECT
                              ENAME,
                              SAL,
                              DEPTNO
                         FROM EMP
                        WHERE DEPTNO = &P_DEPTNO) LOOP
        DBMS_OUTPUT.PUT_LINE(EMP_RECORD.ENAME || ' ' || EMP_RECORD.SAL || ' ' || EMP_RECORD.DEPTNO);
    END LOOP;
END;

-- CURSOR를 DECLARE에 선언하지 않고 BEGIN에서 서브쿼리를 사용할 수 있다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 150
프로시저 구현하기 */
-- 이름을 입력받아 해당 사원의 월급이 출력되게 하는 프로시저를 생성
CREATE OR REPLACE PROCEDURE PRO_ENAME_SAL
(
    P_ENAME IN EMP.ENAME%TYPE   -- 매개변수로 사용할것이며 EMP 테이블의 ENAME 컬럼의 데이터 타입을 따름
)
IS
    V_SAL EMP.SAL%TYPE;         -- BEGIN에서 사용할 내부변수 선언
BEGIN
    SELECT
           SAL INTO V_SAL
      FROM EMP
     WHERE ENAME = P_ENAME;
     
     DBMS_OUTPUT.PUT_LINE(V_SAL || '입니다.');
END;

/* 프로시저로 만들어진 PL/SQL을 호출해보자 */
EXEC PRO_ENAME_SAL('SCOTT');

-- 프로시저를 생성하면 PL/SQL코드를 데이터베이스에 저장하고 호출할 수 있다.
-- PL/SQL코드로 데이터베이스에 저장하는 방법
-- 여러개의 쿼리를 한번에 실행하여 처리하는 방법으로 자바에서의 처리보다 속도면에서 빠르다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 151
함수 구현하기 */
-- 부서 번호를 입력받아 해당 부서 사원들의 부서 위치가 출력되는 함수를 생성
CREATE OR REPLACE FUNCTION GET_LOC
(P_DEPTNO IN DEPT.DEPTNO%TYPE)
RETURN DEPT.LOC%TYPE
IS
    V_LOC DEPT.LOC%TYPE;
BEGIN
    SELECT
           LOC INTO V_LOC
      FROM DEPT
     WHERE DEPTNO = P_DEPTNO;
    RETURN V_LOC;
END;

/* 위에서 만든 함수를 SELECT에서 호출하여 사용해보자 */
SELECT
       ENAME,
       GET_LOC(DEPTNO) AS "LOC"     -- 호출된 함수에서 DEPT 테이블의 LOC컬럼 결과를 RETURN하여 출력이 가능하다.
  FROM EMP
 WHERE JOB = 'SALESMAN';

-- 사용자가 직접 필요한 함수를 생성하여 사용할 수 있도록 오라클에서 함수 생성을 지원한다.
-- %TYPE을 사용하면 부모 테이블 컬럼의 데이터 타입을 따라가기 때문에 부모 테이블 데이터 타입의 길이가 바뀌거나 수정되어도 PL/SQL을 수정할 필요가 없다.

---------------------------------------------------------------------------------------------------------

/* SQL 응용 다지기 152
수학식 구현하기 1 (절대값) */
-- 숫자를 물어보게 하고 해당 숫자의 절대값이 출력되는 PL/SQL을 작성
SET SERVEROUTPUT ON
ACCEPT P_NUM PROMPT '숫자를 입력하세요 ~ '

DECLARE
    V_NUM NUMBER(10) := &P_NUM;

BEGIN
    IF V_NUM >= 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_NUM);
    ELSE
        DBMS_OUTPUT.PUT_LINE(-1 * V_NUM);
    END IF;
END;

---------------------------------------------------------------------------------------------------------