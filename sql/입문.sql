/* 입문 1 
테이블에서 특정 컬럼 선택하기*/
-- 사원 테이블에서 사원 번호와 이름과 월급을 출력

SELECT
       EMPNO,
       ENAME,
       SAL
  FROM EMP;

-- 가독성을 높이기 위해 SQL은 대문자, 컬럼명/테이블명은 소문자로 작성하라고 한다.
-- 하지만 대부분 실무에서 대문자로 전부 작성하였기 때문에 대문자로 작성할 예정이다.
-- 원하는 컬럼만 조회할땐 ',' 로 컬럼을 구분해서 작성한다.
-- * SQL을 작성할 땐 SELECT절을 먼저 쓰고 다음 FROM절을 작성한다. (그렇지 않을경우 ERROR 발생)
-- * SQL의 마지막엔 세미콜론(;)을 작성하자. (MyBatis 등에선 ';'을 붙이면 안된다.)

---------------------------------------------------------------------------------------------------------

/* 입문 2
태이블에서 모들 컬럼 출력하기*/
-- 사원 테이블을 모든 열(coulum)들을 전부 출력

SELECT
        *
  FROM EMP;

-- 전체 컬럼을 출력하고 다시한번 특정 컬럼을 출력하는 경우
SELECT
       DEPT.*,
       DEPTNO
  FROM DEPT;
  
-- 테이블의 모든 컬럼을 조회할 땐 '*'을 사용하면 테이블에 존재하는 모든 컬럼이 조회된다.
-- 하지만 실무에서 '*'을 사용하게 되면 보안상에 문제가 있을 수 있기 때문에 지양하자

---------------------------------------------------------------------------------------------------------

/* 입문 3 
컬럼 별칭을 사용하여 출력되는 컬럼명 변경하기*/
-- 사원 테이블의 사원번호, 이름, 월급을 출력하는데 컬럼명을 한글로
-- '사원번호', '사원이름' 으로 출력해보자.

SELECT
       EMPNO AS 사원번호,
       ENAME AS 사원이름,
       SAL AS "Salary"
  FROM EMP;

/* 별칭 사용하는 경우의 예제 */
-- 아래의 경우 같은 수식이 들어가는 경우 해당 수식으로 컬럼명이 출력 됨
SELECT
       ENAME,
       SAL * (12+3000)
  FROM EMP;
  
-- 아래와 같이 별칭을 작성할 경우 컬럼명이 월급으로 출력 됨
SELECT
       ENAME,
       SAL * (12+3000) AS 월급
  FROM EMP;

-- AS를 사용하면 해당 컬럼의 별칭을 지정 할 수 있다.
-- 대소문자를 구분하여 출력할 경우에는 더블코테이션(")으로 감싸주어야 한다.
-- (대소문자 구분시, 공백문자 출력시, 특수문자($,_,#만 가능) 출력시)

---------------------------------------------------------------------------------------------------------

/* 입문 4 
연결 연산자 사용하기(||)*/
-- 사원 테이블의 이름과  월급을 서로 붙여서 출력

SELECT
       ENAME || SAL
  FROM EMP;
  
-- 다음의 쿼리의 경우 연결 연산자로 출력하면 사용한 의미가 있다.
SELECT
       ENAME || '의 월급은' || SAL || '입니다.' AS 월급
  FROM EMP;
  
SELECT
       ENAME || '의 직업은' || JOB || '입니다.' AS 직업
  FROM EMP;
  
-- 연결 연산자를 사용하면 컬럼 2개의 데이터를 하나로 연결하여 출력이 가능하다.

---------------------------------------------------------------------------------------------------------

/* 입문 5 
중복된 데이터를 제거해서 출력하기(DISTINCT)*/
-- 사원 테이블에서 직업을 출력하는데 중복된 데이터를 제외하고 출력

SELECT DISTINCT
       JOB
  FROM EMP;
  
SELECT UNIQUE
       JOB
  FROM EMP;

-- DISTINCT를 사용하면 테이블 내 중복된 데이터를 제외한 결과가 출력된다.
-- DISTINCT 말고도 UNIQUE를 사용해도 동일한 결과를 출력할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 입문 6 
데이터를 정렬해서 출력하기(ORDER BY) */
-- 이름과 월급을 출력하는데 월급이 낮은 사원부터 출력

SELECT
       ENAME,
       SAL
  FROM EMP
 ORDER BY SAL ASC;
 
SELECT
       ENAME,
       SAL AS 월급
  FROM EMP
 ORDER BY 월급 ASC;
 
SELECT
       ENAME,
       DEPTNO,
       SAL
  FROM EMP
 ORDER BY DEPTNO ASC, SAL DESC;
 
-- ORDER BY는 Default로 오름차순 정렬이다. (ASC 생략 가능)
-- DESC 사용시 내림차순 정렬된다.
-- ORDER BY절은 SQL 맨 마지막에 작성한다.
-- ORDER BY에는 컬럼 별칭도 사용할 수 있다.
-- ORDER BY절에는 여러개의 컬럼을 작성할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 입문 7
WHERE절 배우기 1 (숫자 데이터 검색)*/
-- 월급이 3000인 사원들의 이름, 월급, 직업을 출력

SELECT
       ENAME,
       SAL,
       JOB
  FROM EMP
 WHERE SAL = 3000;
 
SELECT
       ENAME AS 이름,
       SAL AS 월급
  FROM EMP
 WHERE SAL >= 3000;

/* 에러발생 */ 
SELECT
       ENAME AS 이름,
       SAL AS 월급
  FROM EMP
 WHERE 월급 >= 3000;
 
-- WHERE절은 FROM절 다음에 작성한다.
-- WHERE절에 원하는 조건을 작성하면 해당 조건에 맞는 데이터가 출력된다.
-- WHERE절에 사용하는 연산자는 (>,<, BETWEEN AND, LIKE, IS NULL, IN 등이 있다.)

---------------------------------------------------------------------------------------------------------

/* 입문 8
WHERE절 배우기 2 (문자와 날짜 검색)*/
-- 이름이 SCOTT인 사원의 이름, 월급, 직업, 입사일, 부서 번호 출력

SELECT
       ENAME,
       SAL,
       JOB,
       DEPTNO
  FROM EMP
 WHERE ENAME = 'SCOTT';
 
SELECT
       ENAME,
       HIREDATE
  FROM EMP
 WHERE HIREDATE = '81/11/17';

/* 현재 접속한 세션의 날짜 형식 조회 */
SELECT
       *
  FROM NLS_SESSION_PARAMETERS
 WHERE PARAMETER = 'NLS_DATE_FORMAT';
 
-- WHERE절에서 문자, 날짜를 검색할땐 싱글코테이션(')으로 감싸야 한다.
-- 날짜형식 RR과 YY는 다름. (RR = 1900년대, YY = 2000년대)

---------------------------------------------------------------------------------------------------------

/* 입문 9
산술 연산자 배우기(*, /, +, -)*/
-- 연봉이 36000 이상인 사원들의 이름과 연봉을 출력

SELECT
       ENAME,
       SAL * 12 AS 연봉
  FROM EMP
 WHERE SAL * 12 >= 36000;

SELECT
       ENAME,
       SAL,
       COMM,
       SAL + NVL(COMM, 0)
  FROM EMP
 WHERE DEPTNO = 10;

-- 산술연산자의 실행 우선 순위가 있다. 사칙연산 우선순위와 동일하다.
-- 데이터가 없으면 NULL로 출력된다 NULL은 알 수 없는 값으로, NVL을 사용하여 숫자로 변경 해주어야 월급 + 커미션으로 출력된다.

---------------------------------------------------------------------------------------------------------

/* 입문 10 
비교 연산자 배우기 1 (>, <, >=, <=, =, !=, <>, ^=)*/
-- 월급이 1200 이하인 사원들의 이름과 월급, 직업, 부서번호를 출력

SELECT
       ENAME,
       JOB,
       DEPTNO
  FROM EMP
 WHERE SAL <= 1200;
 
/*
    > : 크다.
    < : 작다.
    >= : 크거나 같다.
    <= : 작거나 같다.
    = : 같다.
    != : 같지 않다.
    <> : 같지 않다.
    ^= : 같지 않다.
*/

---------------------------------------------------------------------------------------------------------

/* 입문 11
비교 연산자 배우기 2 (BETWEEN)*/
-- 월급이 1000에서 3000 사이인 사원들의 이름과 월급을 출력
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE SAL BETWEEN 1000 AND 3000;
 
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE (SAL >= 1000 AND SAL <= 3000);
 
/* NOT 연산자를 사용하여 1000 이상 3000 이하가 아닌 사람만 조회 */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE SAL NOT BETWEEN 1000 AND 3000;

/* OR 연산자를 사용하여 위와 동일한 결과 출력 */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE (SAL < 1000 OR SAL > 3000);
 
/* 날짜로 범위를 지정할 수 있다. */
 SELECT
        ENAME,
        HIREDATE
   FROM EMP
  WHERE HIREDATE BETWEEN '1982/01/01' AND '1982/12/31';
 
-- BETWEEN 작성시 BETWEEN 하한값 AND 상한값 으로 작성해야 한다.
-- BETWEEN AND를 사용하여 훨씬 가독성 있는 쿼리를 작성하자.

---------------------------------------------------------------------------------------------------------

/* 입문 12
비교 연산자 배우기 3 LKIE*/
-- 이름의 첫 글자가 S로 시작하는 사원들의 이름과 월급을 출력

SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE ENAME LIKE 'S%';
 
SELECT
       ENAME
  FROM EMP
 WHERE ENAME LIKE '_M%';
 
SELECT
       ENAME
  FROM EMP
 WHERE ENAME LIKE '%T';

SELECT
       ENAME
  FROM EMP
 WHERE ENAME LIKE '%A%';
 
-- LIKE 사용시 와일드카드(%), 언더바(_) 사용
-- EX) S% : S로 시작하는, %S% : S가 중간에 포함되어있는
-- % : 0개 이상의 임의 문자와 일치, _ : 하나의 문자와 일치

---------------------------------------------------------------------------------------------------------

/* 입문 13
비교 연산자 배우기 IS NULL*/
-- 커미션이 NULL인 사원들의 이름과 커미션을 출력

SELECT
       ENAME,
       COMM
  FROM EMP
 WHERE COMM IS NULL;
 
SELECT
       ENAME,
       COMM
  FROM EMP
 WHERE COMM IS NULL;
 
-- NULL을 검색하기 위해선 IS NULL을 사용하자
-- NULL이 아닌 데이터 검색 때도 != NULL 과 같이 사용할 수 없다.

---------------------------------------------------------------------------------------------------------

/* 입문 14 
비교 연산자 배우기 IN*/
-- 직업이 SALESMAN, ANALYST,MANAGER인 사원들의 이름, 월급, 직업을 출력

SELECT
       ENAME,
       SAL,
       JOB
  FROM EMP
 WHERE JOB IN ('SALESMAN', 'ANALYST', 'MANAGER');
 
/* IN 연산자를 사용하지 않고 동일한 결과를 출력하려 할때의 쿼리 */
SELECT
       ENAME,
       SAL,
       JOB
  FROM EMP
 WHERE (JOB = 'SALESMAN' OR JOB = 'ANALYST' OR JOB = 'MANAGER');
 
SELECT
       ENAME,
       SAL,
       JOB
  FROM EMP
 WHERE JOB NOT IN ('SALESMAN', 'ANALYST', 'MANAGER');

 /* NOT과 IN을 같이 사용하지 않았을 때 동일한 결과를 출력하는 쿼리 */
 SELECT
        ENAME,
        SAL,
        JOB
   FROM EMP
 WHERE (JOB != 'SALESMAN' OR JOB != 'ANALYST' OR JOB != 'MANAGER');

-- '=' 연산자는 하나의 값만 조회할 수 있는 반면 IN 연산자는 여러개로 조회가 가능하다.
-- NOT 연산자를 같이 사용하면 반대로도 조회를 할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 입문 15
논리 연산자 배우기 (AND, OR, NOT)*/
-- 직업이 SALESMAN이고 월급이 1200 이상인 사원들의 이름, 월급, 직업을 출력

SELECT
       ENAME,
       SAL,
       JOB
  FROM EMP
 WHERE JOB = 'SALESMAN'
   AND SAL >= 1200;

/* 하나라도 조건에 맞지 않는 경우 데이터가 반환되지 않는다. */
SELECT
       ENAME,
       SAL,
       JOB
  FROM EMP
 WHERE JOB = 'ABCDEFG'
   AND SAL >= 1200;
   
-- AND 연산자 사용시 조건 2개가 전부 TRUE여야 데이터를 반환한다.

---------------------------------------------------------------------------------------------------------