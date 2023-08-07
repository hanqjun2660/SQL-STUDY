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
