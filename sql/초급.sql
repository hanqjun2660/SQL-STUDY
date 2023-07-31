/* 초급 16
대소문자 변환 함수 배우기 (UPPER, LOWER, INITCAP)*/
-- 사원 테이블의 이름을 출력하는데 첫 번째 컬럼은 이름을 대문자로 출력하고
-- 두번째 컬럼은 이름을 소문자로 출력하고, 세번째 컬럼은 이름의 첫 번째 철자는 대문자로 하고,
-- 나머지는 소문자로 출력

SELECT
       UPPER(ENAME),
       LOWER(ENAME),
       INITCAP(ENAME)
  FROM EMP;

/* LOWER 함수를 사용하여 소문자로 검색 할 수 있게 되었다. */  
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE LOWER(ENAME) = 'scott';

-- UPPER : 전체 대문자로 변경, LOWER : 전체 소문자로 변경, INITCAP : 첫글자만 대문자로 변경

---------------------------------------------------------------------------------------------------------

/* 초급 17
문자에서 특정 철자 추출하기 (SUBSTR)*/
-- 영어단어 SMITH에서 SMI만 잘라내서 출력
SELECT
       SUBSTR(ENAME, 1, 3)
  FROM EMP
 WHERE ENAME = 'SMITH';
 
-- SUBSTR INDEX는 1부터 시작한다. 앞 3글자를 잘라내서 출력하고 싶다면 함수 내 START, END INDEX를 입력한다.
-- START END INDEX를 입력하지 않으면 입력한 INDEX만큼 잘리고 나머지가 출력된다.

---------------------------------------------------------------------------------------------------------

/* 초급 18
문자열의 길이를 출력하기 (LENGTH)*/
-- 이름을 출력하고 그 옆에 이름의 철자 개수를 출력

SELECT
       ENAME,
       LENGTH(ENAME)
  FROM EMP;
  
SELECT
       LENGTHB('가나다라마바사')
  FROM DUAL;

-- 문자열의 길이를 출력하기 위해서는 LENGTH 함수를 이용하자.
-- LENGTHB는 문자의 BYTE길이를 반환한다.

---------------------------------------------------------------------------------------------------------

/* 초급 19
문자에서 특정 철자의 위치 출력하기 (INSTR)*/
-- 사원 이름 SMITH에서 알파벳 철자 M이 몇 번째 자리에 있는지 출력
SELECT
       INSTR(ENAME, 'M')
  FROM EMP
 WHERE ENAME = 'SMITH';
 
/* SUBSTR과 INSTR을 같이 사용하여 원하는 INDEX만큼 문자열을 잘라낼 수 있다. */
SELECT
       SUBSTR('ABCDEFG@NAVER.COM', INSTR('ABCDEFG@NAVER.COM', '@') + 1)
  FROM DUAL;
  
SELECT
       RTRIM(SUBSTR('ABCDEFG@NAVER.COM', INSTR('ABCDEFG@NAVER.COM', '@') + 1), '.COM')
  FROM DUAL;
 
-- 특정 철자의 위치(INDEX)를 출력하는 함수다.

---------------------------------------------------------------------------------------------------------

/* 초급 20 
특정 철자를 다른 철자로 변경하기 (REPLACE)*/
-- 이름과 월급을 출력하는데, 월급을 출력할 때 숫자 0을 *(별표)로 출력

SELECT
       ENAME,
       REPLACE(SAL, 0, '*')
  FROM EMP;

/* REGEXP_REPLACE 함수를 사용하여 정규식으로 0~3은 *로 치환하였다. */
SELECT
       ENAME,
       REGEXP_REPLACE(SAL, '[0-3]', '*') AS SALARY
  FROM EMP;
  
SELECT
       REPLACE(ENAME, SUBSTR(ENAME, 2, 1), '*') AS "전광판 이름"
  FROM TEST_ENAME;
  
-- REPLACE는 특정 철자를 다른 철자로 치환하는 함수이다.

---------------------------------------------------------------------------------------------------------

/* 초급 21 
특정 철자를 N개 만큼 채우기*/
-- 이름과 월급을 출력하는데, 월급 컬럼의 자릿수를 10자리로 하고,
-- 월급을 출력하고 남은 나머지 자리에 별표(*)를 채워서 출력

SELECT
       ENAME,
       LPAD(SAL, 10, '*') AS SALARY1,
       RPAD(SAL, 10, '*') AS SALARY2
  FROM EMP;

/* ROUND 함수를 이용하여 월급을 나누어 막대 차트를 출력했다. */
SELECT
       ENAME,
       SAL,
       LPAD('■', ROUND(SAL/100), '■') AS BAR_CHART
  FROM EMP;

-- LPAD, RPAD는 채워넣을 자릿수를 입력할 수 있고 채워넣을 문자를 입력할 수 있다.
-- LPAD는 왼쪽부터 채워넣고, RPAD는 오른쪽부터 채워넣는다.
-- * ROUND 함수는 반올림 함수이다.

---------------------------------------------------------------------------------------------------------

/* 초급 22
특정 철자 잘라내기 (TRIM, RTRIM, LTRIM)*/
-- 첫 번째 컬럼은 영어 단어 SMITH 철자를 출력하고, 두 번째 컬럼은 영어 단어 SMITH에서 S를 잘라서 출력하고,
-- 세 번째 컬럼은 영어 단어 SMITH에서 H를 잘라서 출력하고, 네 번째 컬럼은 영어 단어 SMITH 양쪽에 S를 잘라 출력

SELECT
       'SMITH',
       LTRIM('SMITH', 'S'),
       RTRIM('SMITH', 'H'),
       TRIM('S' FROM 'SMITHS')
  FROM DUAL;

/* TRIM으로 공백문자 제거 후 검색을 위해 아래와 같이 데이터를 추가한다. */
INSERT INTO EMP(EMPNO, ENAME, SAL, JOB, DEPTNO) VALUES(8291, 'JACK ', 3000, 'SALESMAN', 30);
COMMIT;

/* 공백문자가 포함되어 있는 데이터라면 아래와같이 검색이 되지 않는다. */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE ENAME = 'JACK';
 
/* TRIM을 사용하여 공백을 제거 할 수 있다. */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE RTRIM(ENAME) = 'JACK';
 
/* 공백 제거 검색을 위해 추가했던 데이터를 삭제 */
DELETE
  FROM EMP
 WHERE RTRIM(ENAME) = 'JACK';
 
COMMIT;

-- TRIM을 사용하면 특정 철자를 잘라낼 수 있다.
/*
    TRIM : 양쪽 공백 제거(옵션 미사용시), FROM 사용시 특정 철자 잘라낼 수 있음
    LTRIM : 좌측 공백 제거(옵션 미사용시), 옵션 사용시 특정 철자(왼쪽기준) 잘라낼 수 있음
    RTRIM : 좌측 공백 제거(옵션 미사용시), 옵션 사용시 특정 철자(오른쪽기준) 잘라낼 수 있음
*/

---------------------------------------------------------------------------------------------------------

/* 초급 23
반올림해서 출력하기 (ROUND)*/
-- 876.567 숫자를 출력하는데 소수점 두 번째 자리인 6에서 반올림해서 출력

SELECT
      '876.567',
       ROUND('876.567', 1)
  FROM DUAL;
  
-- 옵션이 없는 경우 소수점 자리수 첫번째 반올림 (0도 마찬가지)
-- 옵션으로 1을 입력하면 소수점 첫째 자리수까지 표시(두번째 소수점 반올림)
-- 옵션으로 2를 입력하면 소수점 두번째 자리수까지 표시(세번째 소수점 반올림)

---------------------------------------------------------------------------------------------------------

/* 초급 24
숫자를 버리고 출력하기 (TRUNC)*/
-- 876.567 숫자를 출력하는데 소수점 두 번째 자리인 6과 그 이후 숫자들을 모두 버리고 출력

SELECT
       '876.567',
       TRUNC('876.567', 1)
  FROM DUAL;
  
-- TRUNC 함수는 소수점 이후 숫자를 버림한다.
-- 옵션을 사용하면 옵션으로 선택한 INDEX이후의 숫자들을 모두 버림하고 출력한다.

---------------------------------------------------------------------------------------------------------

/* 초급 25 
나눈 나머지 값 출력하기 (MOD)*/
-- 숫자 10을 3으로 나눈 나머지 값이 어떻게 되는지 출력

SELECT
       MOD(10, 3)
  FROM DUAL;
  
SELECT
       MOD(EMPNO, 2)
  FROM EMP;
  
SELECT
       ENAME
  FROM EMP
 WHERE MOD(EMPNO, 2) = 0;

SELECT
       FLOOR(10/3)
  FROM DUAL;

-- MOD 함수는 숫자를 나누고 난 후 나머지 값을 출력한다.
-- FLOOR 함수는 나누고 난 후 값에 가장 가까운 값을 출력합니다. (사실상 버림 함수에 가까움)

---------------------------------------------------------------------------------------------------------

/* 초급 26
날짜 간 개월 수 출력하기 (MONTHS_BETWEEN)*/
-- 이름을 출력하고 입사한 날짜부터 오늘까지 총 몇달을 근무했는지 출력

SELECT
       ENAME,
       MONTHS_BETWEEN(SYSDATE,HIREDATE)
  FROM EMP;
  
/* MONTHS_BETWEEN 함수를 사용하지 않고 구하려 할 때 */
SELECT
       TO_DATE('2019-06-01', 'RRRR-MM-DD') - TO_DATE('2018-10-01', 'RRRR-MM-DD')
  FROM DUAL;
  
SELECT
       ROUND((TO_DATE('2019-06-01', 'RRRR-MM-DD') - TO_DATE('2018-10-01', 'RRRR-MM-DD')) / 7) AS "총 주수"
  FROM DUAL;
  
-- SYSDATE 함수는 오늘 날짜를 확인하는 함수이다.
-- MONTH_BETWEEN 함수는 날짜를 입력받아 출력한다. MONTHS_BETWEEN(최신날짜, 예전날짜)
-- TO_DATE는 문자형식을 DATE 형태로 변경해준다. (날짜, 포맷)
-- 날짜 사이의 일수를 계산할땐 MONTHS_BETWEEN 함수를 쓰는게 정신건강에 좋겠다.

---------------------------------------------------------------------------------------------------------

/* 초급 27
개월 수 더한 날짜 출력하기 (ADD_MONTHS)*/
-- 2019년 5월 1일로부터 100달 뒤의 날짜는 어떻게 되는지 출력

/* 100개월 뒤 날짜 */
SELECT
       ADD_MONTHS(TO_DATE('2019-05-01', 'RRRR-MM-DD'), 100)
  FROM DUAL;
  
/* 100일 후 날짜 */
SELECT
       TO_DATE('2019-05-01', 'RRRR-MM-DD') + 100
  FROM DUAL;
  
/* 말일(30일,31일) 때문에 애매할 경우가 있다 아래와 같이 INTERVAL을 사용하자 */
SELECT
       TO_DATE('2019-05-01', 'RRRR-MM-DD') + INTERVAL '100' MONTH
  FROM DUAL;
  
/* 2019년 5월 1일 부터 1년 3개월 되는 날짜를 구해보자 */
SELECT
       TO_DATE('2019-05-01', 'RRRR-MM-DD') + INTERVAL '1-3' YEAR(1) TO MONTH
  FROM DUAL;
  
/* 3년 후 날짜 */
SELECT
       TO_DATE('2019-05-01', 'RRRR-MM-DD') + INTERVAL '3' YEAR
  FROM DUAL;

/* 3년 5개월 후 날짜 */ 
SELECT
       TO_DATE('2019-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') AS 날짜
  FROM DUAL;
  
-- ADD_MONTHS의 옵션은 개월 수로 집어넣는다. (기준날짜, 옵션)
-- INTERVAL을 사용하면 더 쉽고 간단하게 구할 수 있다. (날짜를 더하거나 뺄일이 있으면 INTERVAL을 사용하자)
-- INTERVAL의 내장함수는 다양하니 상황에 맞게 잘 활용하자 (시분초 단위까지 가능함)
-- TO_YMINTERVAL을 사용하면 조금 더 간단하게 년월 단위로 계산이 가능하다.

---------------------------------------------------------------------------------------------------------

/* 초급 28
특정 날짜 뒤에 오는 요일 날짜 (NEXT_DAY)*/
-- 2019년 5월 22일로부터 바로 돌아올 월요일의 날짜가 어떻게 되는지 출력

SELECT
       NEXT_DAY(TO_DATE('2019-05-22', 'RRRR-MM-DD'), '월요일')
  FROM DUAL;

SELECT
       SYSDATE AS "오늘날짜"
  FROM DUAL;

/* 오늘로부터 앞으로 돌아올 화요일의 날짜 */  
SELECT
       NEXT_DAY(SYSDATE, '화요일') AS "다음날짜"
  FROM DUAL;
  
/* 2019년 5월 22일부터 100달 뒤에 돌아오는 화요일의 날짜 */
SELECT
       NEXT_DAY(ADD_MONTHS('2019-05-22', 100), '화요일') AS "다음날짜"
  FROM DUAL;
  
/* 오늘 부터 100달 뒤 돌아올 월요일의 날짜 */
SELECT
       NEXT_DAY(ADD_MONTHS(SYSDATE, 100), '월요일') AS "다음날짜"
  FROM DUAL;
  
-- NEXT_DAY 함수는 미래의 돌아올 날짜를 검색할 수 있는 함수다.
-- 옵션으로 요일을 받는다.
-- SYSDATE는 현재 날짜를 반환한다.

---------------------------------------------------------------------------------------------------------

/* 초급 29 
특정 날짜가 있는 달의 마지막 날짜 출력하기 (LAST_DAY) */
-- 2019년 5월 22일 해당 달의 마지막 날짜가 어떻게 되는지 출력

SELECT
       LAST_DAY(TO_DATE('2019-05-22', 'RRRR-MM-DD')) AS "마지막 날짜"
  FROM DUAL;
  
/* 오늘부터 이번달 말일까지 몇일이 남았는지 출력 */
SELECT
       LAST_DAY(SYSDATE) - SYSDATE AS "마지막 날짜"
  FROM DUAL;
  
/* 한 사원의 이름, 입사일, 입사한 달의 마지막 달을 구하고 출력 */
SELECT
       ENAME,
       HIREDATE,
       LAST_DAY(HIREDATE)
  FROM EMP
 WHERE ENAME = 'KING';
 
-- LAST_DAY 함수는 단순하게 DATE형으로 받은 기준날짜의 마지막 날짜를 반환한다.

---------------------------------------------------------------------------------------------------------

/* 초급 30
문자형으로 데이터 유형 변환하기 (TO_CHAR)*/
-- 이름이 SCOTT인 사원의 이름과 입사한 요일을 출력하고 SCOTT의 월급에 천 단위를 구분할 수 있는 콤마(,)를 붙여 출력

SELECT
       ENAME,
       TO_CHAR(HIREDATE, 'DAY') AS "요일",
       TO_CHAR(SAL, '999,999') AS "월급"
  FROM EMP
 WHERE ENAME = 'SCOTT';
 
/* 날짜를 년, 월, 일로 출력해보자 */
SELECT
       TO_CHAR(HIREDATE, 'YYYY') AS "연도",
       TO_CHAR(HIREDATE, 'MM') AS "달",
       TO_CHAR(HIREDATE, 'DD') AS "일",
       TO_CHAR(HIREDATE, 'DAY') AS "요일"
  FROM EMP
 WHERE ENAME = 'KING';
 
/* 1981년도 입사한 사원의 이름과 입사일을 출력 */
SELECT
       ENAME,
       HIREDATE
  FROM EMP
 WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981';
 
/* 날짜 추출을 위해 EXTRACT 함수를 사용하여도 된다. */
SELECT
       ENAME AS "이름",
       EXTRACT(YEAR FROM HIREDATE) AS "연도",
       EXTRACT(MONTH FROM HIREDATE) AS "달",
       EXTRACT(DAY FROM HIREDATE) AS "일"
  FROM EMP;
  
/* 이름과 월급을 출력하고 월급엔 천단위 구분 기호를 추가하자 */
SELECT
       ENAME AS "이름",
       TO_CHAR(SAL, '999,999') AS "월급"
  FROM EMP;
  
/* 천 단위와 백만 단위를 표시해보자 */
SELECT
       ENAME AS "이름",
       TO_CHAR(SAL * 200, '999,999,999') AS "월급"
  FROM EMP;
 
-- TO_CHAR 함수의 옵션 DAY는 날짜를 요일로 출력한다. (날짜 출력 형식 포맷이 몇가지 존재한다.)
-- TO_CHAR 함수의 옵션중 숫자 포맷을 정할수도 있다.
-- EXTRACT 함수를 사용해서 날짜를 추출할 수 있으며, YEAR, MONTH, DAY와 같은 옵션을 사용할 수 있다. (FROM과 같이 사용)

---------------------------------------------------------------------------------------------------------

/* 초급 31
날짜형으로 데이터 유형 변환하기 (TO_DATE)*/
-- 81년 11월 17일에 입사한 사원의 이름과 입사일을 출력

SELECT
       ENAME,
       HIREDATE
  FROM EMP
 WHERE HIREDATE = TO_DATE('81/11/17');
 
/* 현재 접속한 세션의 날짜 형식 확인 후 포맷에 맞게 검색*/
SELECT
       *
  FROM NLS_SESSION_PARAMETERS
 WHERE PARAMETER = 'NLS_DATE_FORMAT';

SELECT
       ENAME,
       HIREDATE
  FROM EMP 
 WHERE HIREDATE = '81/11/17';
 
 /* 날짜 포맷을 변경하고 조회해보자 */
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/RR';
 
 SELECT
        ENAME,
        HIREDATE
   FROM EMP
  WHERE HIREDATE = '17/11/81';
  
/* 하지만 날짜 포맷이 달라도 쿼리에 명시해두면 검색이 된다. */
SELECT
       ENAME,
       HIREDATE
  FROM EMP
 WHERE HIREDATE = TO_DATE('81/11/17', 'RR/MM/DD');

/* 다시 날짜 포맷을 원래대로 되돌리자 */
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';
 
-- TO_DATE 함수는 문자열을 DATE형으로 변환해준다.
-- 날짜 검색을 할때는 접속한 세션의 날짜 형식을 확인해야 검색시 에러가 발생하지 않는다.
-- 날짜 포맷이 달라도 쿼리에 포맷을 명시해두면 검색이 된다!

---------------------------------------------------------------------------------------------------------

/* 초급 32
암시적 형 변환 이해하기*/
-- 아래 쿼리를 실행해보자,
-- SAL 컬럼은 숫자형인데 아래 쿼리를 보면 문자형으로 비교를 하고 있다.
-- 암시적인 형 변환을 이용한 것인데, 오라클이 알아서 숫자형 = 숫자형으로 형 변환을 하기때문에 검색이된다!

SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE SAL = '3000';
 
/* 
    SAL 컬럼에 일부러 문자형으로 데이터를 넣어보자 
    그리고 숫자형으로 검색을 해보자.
*/
CREATE TABLE EMP32
(ENAME VARCHAR2(10),
SAL VARCHAR2(10));

INSERT INTO EMP32(ENAME, SAL) VALUES('SCOTT', '3000');
INSERT INTO EMP32(ENAME, SAL) VALUES('SMITH', '1200');
COMMIT;

/* 위 아래는 동일한 결과를 출력한다. 오라클이 암시적인 형 변환을 해주기때문 */
SELECT
       ENAME,
       SAL
  FROM EMP32
 WHERE SAL = 3000;
 
SELECT
       ENAME,
       SAL
  FROM EMP32
 WHERE TO_NUMBER(SAL) = 3000;
 
-- 오라클은 숫자형 -> 문자형 / 문자형 -> 숫자형 암시적 형 변환을 해준다.
-- 고로 이런 상황일땐 TO_CHAR, tO_NUMBER로 형 변환을 하지 않아도 에러가 나지 않고 검색이 정상적으로 실행된다.

---------------------------------------------------------------------------------------------------------

/* 초급 33
NULL 값 대신 다른 데이터 출력하기 (NVL, NVL2)*/
-- 이름과 커미션을 출력하는데, 커미션이 NULL인 사원들은 0으로 출력해보자

SELECT
       ENAME,
       NVL(COMM, 0)
  FROM EMP;

/* 이름, 월급, 커미션, 월급 + 커미션 출력 */
-- 실제 커미션 데이터가 NULL이라 NVL을 사용하여 0으로 치환하여야 월급과 더하기가 가능하다.
SELECT
       ENAME AS "이름",
       SAL AS "월급",
       NVL(COMM, 0) AS "커미션",
       SAL + NVL(COMM, 0) AS "월급 + 커미션"
  FROM EMP
 WHERE JOB IN ('SALESMAN', 'ANALYST');
 
 /* NVL2 함수 사용하여 커미션이 NULL이 아닌 사원들은 SAL + COMM을 출력하자 */
 SELECT
        ENAME,
        SAL,
        COMM,
        NVL2(COMM, SAL+COMM, SAL)
   FROM EMP
 WHERE JOB IN ('SALESMAN', 'ANALYST');

-- NVL 함수는 NULL이 데이터로 들어가있는 경우 사용자가 지정한 데이터로 출력을 해준다.
-- 실제 데이터가 변경되는 것은 아니다.
-- NVL2는 첫번째 인자가 NULL이 아닌경우 두번째 인자를 실행하고, NULL인경우 세번째 인자만 실행한다.

---------------------------------------------------------------------------------------------------------

/* 초급 34
IF문을 SQL로 구현하기 1 (DECODE) */

-- 부서번호가 10이면 300, 20이면 400 둘다 아니면 0을 출력
/*
    표현하면 아래와 같다.
    IF(DEPTNO = 10) {
        보너스 = 300;
    } ELSE IF(DEPTNO) {
        보너스 = 400;
    } ELSE {
        보너스 = 0;
    }
*/
SELECT
       ENAME,
       DEPTNO,
       DECODE(DEPTNO, 10, 300, 20, 400, 0) AS "보너스"
  FROM EMP;
  
/* 짝수인지 홀수인지 출력하는 쿼리 */
SELECT
       EMPNO,
       MOD(EMPNO,2),
       DECODE(MOD(EMPNO,2), 0, '짝수',1 ,'홀수') AS "보너스"
  FROM EMP;
  
/* 
    DEFAULT 값을 생략한 경우 
    이름과 직업, 보너스를 출력하는데, 직업이 SALESMAN이면 보너스 5000을 출력, 나머지는 보너스 2000을 출력한다.
*/
SELECT
       ENAME,
       JOB,
       DECODE(JOB, 'SALESMAN', 5000, 2000) AS "보너스"
  FROM EMP;
  
-- DECODE는 조건문처럼 사용하여 출력할 수 있다.
-- DECODE의 DEFAULT 값은 생략 가능하다.
-- MOD 함수는 나눈 후 나머지 값이기 때문에 위에서는 짝수로 나누어 나머지값이 있냐 없냐고 짝수 홀수를 판단하였다.

---------------------------------------------------------------------------------------------------------

/* 초급 35 
IF문을 SQL로 구현하기 2 (CASE) */

SELECT
       ENAME,
       JOB,
       SAL,
       CASE WHEN SAL >= 3000 THEN 500
            WHEN SAL >= 2000 THEN 300
            WHEN SAL >= 1000 THEN 200
            ELSE 0 END AS BOUNUS
  FROM EMP
 WHERE JOB IN ('SALESMAN', 'ANALYST');
 
 /* 
    이름, 직업, 커미션, 보너스를 출력한다.
    보너스는 커미션이 NULL이면 500을 출력하고,
    NULL이 아니면 0을 출력한다.
*/
SELECT
       ENAME,
       JOB,
       COMM,
       CASE WHEN COMM IS NULL THEN 500
            ELSE 0 END AS "보너스"
  FROM EMP;
  
/*
    보너스를 출력할 때 직업이 SALESMAN, ANALYST이면 500을 출력하고,
    직업이 CLERK, MANAGER이면 400을 출력하고,
    나머지 직업은 0을 출력한다.
*/
SELECT
       ENAME,
       JOB,
       CASE WHEN JOB IN('SALESMAN', 'ANALYST') THEN 500
            WHEN JOB IN('CLERK', 'MANAGER') THEN 400
            ELSE 0 END AS "보너스"
  FROM EMP;

-- CASE문은 WHEN THEN / ELSE END와 같이 사용한다.
-- DECODE는 "=" 비교만 가능하지만 CASE는 "="와 ">" 둘다 비교가 가능하다.

---------------------------------------------------------------------------------------------------------

/* 초급 36
최대값 출력하기 (MAX) */
-- 사원 테이블에서 최대 월급을 출력

SELECT
       MAX(SAL)
  FROM EMP;

-- 직업이 SALESMAN인 사원들 중에서 최대 월급을 출력
SELECT
       MAX(SAL)
  FROM EMP
 WHERE JOB = 'SALESMAN';
 
-- 직업도 같이 출력을 해보려고 한다.
-- 단일 그룹 함수가 아니라는 에러가 출력된다.
-- JOB은 여러개의 행이 출력되어야 하는데 MAX 함수는 하나만 출력되기 때문에 이러한 에러가 발생한다.
-- 이러한 문제를 해결하기 위해선 GROUP BY절을 사용하여 GROUPING을 해야한다.
SELECT
       JOB,
       MAX(SAL)
  FROM EMP
 WHERE JOB = 'SALESMAN';
 
-- GROUP BY 절을 사용하여 다시 출력해보자.
SELECT
       JOB,
       MAX(SAL)
  FROM EMP
 WHERE JOB = 'SALESMAN'
 GROUP BY JOB;
 
/* 부서 번호와 부서 번호별 최대 월급을 출력해보자 */
SELECT
       DEPTNO,
       MAX(SAL)
  FROM EMP
 GROUP BY DEPTNO;
  
-- MAX 함수를 이용하면 최대값을 출력할 수 있다.
-- MAX 함수를 사용하여 조회하면 단일행만 조회된다. 다중행 조회시 에러가 발생하기 때문에 GROUP BY 절을 사용하여 단일행으로 GROUPING 해줘야 에러가 발생하지 않는다.
-- GROUP BY 절은 WHERE절 다음 사용하자.

---------------------------------------------------------------------------------------------------------

/* 초급 37
최소값 출력하기 (MIN) */
-- 직업이 SALESMAN인 사원들 중 최소 월급을 출력해보자
SELECT
       MIN(SAL)
  FROM EMP
 WHERE JOB = 'SALESMAN';
 
 /* 직업과 직업별 최소 월급을 출력하는데, ORDER BY 절을 사용하여 최소 월급이 높은 것 부터 출력 */
 SELECT
        JOB,
        MIN(SAL)
   FROM EMP
   GROUP BY JOB
   ORDER BY MIN(SAL) DESC;
   
/* 그룹함수 특징으로 WHERE절의 조건이 거짓이라도 결과를 항상출력한다. */
-- 거짓이어도 조회가 실패하지 않고 NULL이 반환된다. NVL을 통해 확인해보자
SELECT
       MIN(SAL)
  FROM EMP
 WHERE 1 = 2;
 
SELECT
       NVL(MIN(SAL), 0)
  FROM EMP
 WHERE 1 = 2;
 
 /* 
    직업, 직업별 최소 월급을 출력하는데,
    직업에서 SALESMAN은 제외하고 출력하고,
    직업별 최소 월급이 높은 것 부터 출력해보자
*/
SELECT
       JOB,
       MIN(SAL)
  FROM EMP
 WHERE JOB != 'SALESMAN'
 GROUP BY JOB
 ORDER BY MIN(SAL) DESC;
 
 -- MAX 함수와 마찬가지로 MIN 함수도 동일하게 단일행으로 조회된다.
 -- ORDER BY 절은 항상 마지막에 작성한다.
 -- MIN 함수는 WHERE절의 내용이 거짓이라도 조회에 실패하지 않고 NULL을 반환한다.
 
 ---------------------------------------------------------------------------------------------------------
 
 /* 초급 38
 평균값 출력하기 (AVG) */
 -- 사원 테이블의 평균 월급을 출력
 SELECT
        AVG(COMM)
   FROM EMP;
   
/* NULL을 0으로 치환하고 계산하면 결과가 달라진다. (AVG 함수는 NULL을 무시하기 때문) */
SELECT
       ROUND(AVG(NVL(COMM, 0)))
  FROM EMP;
   
-- NULL은 제외하고 계산된다.
-- NULL을 0으로 치환하고 계산하면 성능이 더 좋지 않다.

---------------------------------------------------------------------------------------------------------

/* 초급 39
토탈값 출력하기 (SUM) */
-- 부서 번호와 부서 번호별 토탈 월급을 출력
SELECT
       DEPTNO,
       SUM(SAL)
  FROM EMP
 GROUP BY DEPTNO;
 
 /* 직업, 직업별 토탈 월급을 출력하는데 직업별 토탈 월급이 높은 것 부터 출력해보자 */
 SELECT
        JOB,
        SUM(SAL)
   FROM EMP
 GROUP BY JOB
 ORDER BY SUM(SAL) DESC;

/* 직업과 직업별 토탈 월급을 출력하는데, 직업별 토탈 월급이 4000 이상인 것만 출력해보자 */
-- WHERE절에 그룹함수를 사용하면 그룹 함수는 허가되지 않습니다. 라는 에러가 발생한다.
-- 이를 해결하기 위해선 HAVING 절을 사용한다.
SELECT
       JOB,
       SUM(SAL)
  FROM EMP
 WHERE SUM(SAL) >= 4000
 GROUP BY JOB;
 
SELECT
       JOB,
       SUM(SAL)
  FROM EMP
  GROUP BY JOB
 HAVING SUM(SAL) >= 4000;
 
/*
    직업과 직업별 토탈 월급을 출력하는데,
    직업에서 SALESMAN은 제외하고,
    직업별 토탈 월급이 4000 이상인 사원들만 출력해보자
*/
SELECT
       JOB,
       SUM(SAL)
  FROM EMP
 WHERE JOB != 'SALESMAN'
 GROUP BY JOB
 HAVING SUM(SAL) >= 4000
 ORDER BY SUM(SAL) DESC;
 
 -- SUM 함수는 숫자 데이터 합계를 단일행으로 출력한다.
 -- 그룹함수에 조건을 줄땐 WHERE절 대신 HAVING절을 사용해야 한다.
 -- HAVING 절은 GROUP BY 절 아래에 작성한다.
 
 ---------------------------------------------------------------------------------------------------------
 
 /* 초급 40
 건수 출력하기 (COUNT) */
 -- 사원 전체가 몇명인지 출력해보자
 SELECT
        COUNT(EMPNO)
   FROM EMP;
   
SELECT
       COUNT(COMM)
  FROM EMP;
  
SELECT
       COUNT(NVL(COMM, 0))
  FROM EMP;
  
SELECT
       ROUND(AVG(NVL(COMM, 0)))
  FROM EMP;
  
-- COUNT 함수는 NULL을 무시하고 COUNT한다.
-- AVG, COUNT는 NULL을 무시하므로 항상 NULL을 염두에 두고 사용하자.
-- NVL 함수를 사용해서 NULL을 무시하지 않도록 하는게 좋다.

---------------------------------------------------------------------------------------------------------

/* 초급 41
데이터 분석 함수로 순위 출력하기 1 (RANK) */
-- 직업이 ANALYST, MANAGER인 사원들의 이름, 직업, 월급, 월급의 순위를 출력
SELECT
       ENAME,
       JOB,
       SAL,
       RANK() OVER(ORDER BY SAL DESC) AS "순위"
  FROM EMP
 WHERE JOB IN ('ANALYST', 'MANAGER');
 
 /* 직업별로 월급이 높은 순서대로 순위를 부여해서 각각 출력해보자 */
 SELECT
        ENAME,
        SAL,
        JOB,
        RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS "순위"
   FROM EMP;
 
 -- RANK 함수는 순위를 출력하는 데이터 분석 함수이다.
 -- RANK() 뒤 OVER 다음에 나오는 괄호안에는 출력하고 싶은 데이터를 정렬하는 SQL 문을 넣으면 된다.
 -- PARTITION은 그룹으로 묶어 출력해준다.
 
 ---------------------------------------------------------------------------------------------------------
 
 /* 초급 42
 데이터 분석 함수로 순위 출력하기 (DENSE_RANK) */
 /*
    직업이 ANALYST, MANAGER인 사원들의 이름, 직업, 월급, 월급의 순위를 출력하는데,
    순위 1위인 사원이 두 명이 있을 경우 다음 순위가 3위로 출력되지 않고 2위로 출력되는 문제를 해결해 보자.
 */
 SELECT
        ENAME,
        SAL,
        RANK() OVER(ORDER BY SAL DESC) AS RANK,
        DENSE_RANK() OVER(ORDER BY SAL DESC) AS DENSE_RANK
   FROM EMP
  WHERE JOB IN('ANALYST', 'MANAGER');
  
/*
    81년도에 입사한 사원들의 직업, 이름, 월급, 순위를 출력하는데,
    직업별로 월급이 높은 순서대로 순위를 부여하여 출력해보자
*/  

SELECT
       JOB,
       ENAME,
       SAL,
       DENSE_RANK() OVER(ORDER BY SAL DESC) AS "순위"
  FROM EMP
 WHERE TO_CHAR(HIREDATE, 'RRRR') = '1981';
--   BETWEEN TO_DATE('1981/01/01', 'RRRR/MM/DD')
--   AND TO_DATE('1981/12/31', 'RRRR/MM/DD');

/* DENSE_RANK 바로 다음에 오는 괄호에도 다음과 같이 데이터를 넣고 사용할 수 있다. */
SELECT
       DENSE_RANK(2975) WITHIN GROUP(ORDER BY SAL DESC) AS "순위"
  FROM EMP;
  
SELECT
       DENSE_RANK('81/11/17') WITHIN GROUP(ORDER BY HIREDATE ASC) AS "순위"
  FROM EMP;

-- DENSE_RANK의 사용법은 RANK 함수와 동일하다.
-- DENSR_RANK를 사용하면 1순위인 사람이 2명 이상 있어도 순위가 제대로 나온다. (동점자 순위 동일하게 처리 됨)
-- WHITIN GROUP은 어느 그룹 내에서 라는 뜻으로 위 쿼리는 2975가 SAL 그룹안에서 몇 순위인지 보겠다는 쿼리다.

---------------------------------------------------------------------------------------------------------

/* 초급 43
데이터 분석 함수로 등급 출력하기 (NTILE)*/
/*
    이름과 직업, 월급의 등급을 출력해보자. 월급의 등급은 4등급으로 나눠,
    1등급 (0 ~25%), 2등급 (25 ~ 50%), 3등급 (50 ~ 75%), 4등급 (75 ~ 100%)로 출력해보자
*/
SELECT
       ENAME,
       JOB,
       NTILE(4) OVER(ORDER BY SAL DESC NULLS LAST) AS "등급"
  FROM EMP
 WHERE JOB IN('ANALYST', 'MANAGER', 'CLERK');
 
 -- NTILE 함수는 인자로 받은 값만큼 나누어 데이터를 등급으로 순위를 나눈다.
 -- NULLS LAST는 NULL은 가장 마지막에 출력하겠다는 뜻이다.
 
 ---------------------------------------------------------------------------------------------------------
 
 /* 초급 44
 데이터 분석 함수로 순위의 비율 출력하기 (CUME_DIST) */
 -- 이름과 월급, 월급의 순위, 월급의 순위 비율을 출력
 SELECT
        ENAME,
        SAL,
        RANK() OVER(ORDER BY SAL DESC) AS "RANK",
        DENSE_RANK() OVER(ORDER BY SAL DESC) AS "DENSE_RANK",
        CUME_DIST() OVER(ORDER BY SAL DESC) AS CUME_DIST
   FROM EMP;
   
/* PARTITION JOB을 사용하여 직업별로 CUME_DIST를 출력해보자 */
SELECT
       ENAME,
       SAL,
       RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS "RANK",
       CUME_DIST() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS "CUME_DIST"
  FROM EMP;
  
-- CUME_DIST 함수는 특정 데이터 순위의 비율을 출력한다.
-- RANK, DENSE_RANK랑 비슷하게 사용한다.
-- 딱히 비율을 출력할 일은 없을것 같아 자주사용하지 않을 것 같다.

---------------------------------------------------------------------------------------------------------