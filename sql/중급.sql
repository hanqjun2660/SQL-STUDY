/* 중급 56
 출력되는 행 제한하기 1 (ROWNUM) */
-- 사원 테이블에서 사원 번호, 이름, 직업, 월급을 상단 5개만 출력하자.
SELECT
       ROWNUM
       EMPNO,
       ENAME,
       JOB,
       SAL
  FROM EMP
 WHERE ROWNUM <= 5;

-- 데이터가 많은 테이블을 잠깐 살펴볼때 테이블 내 일부 데이터만 제한하여 조회할 수 있는 용도로 사용이 가능하다.
-- 출력되는 데이터에 번호를 부여할 수 있다.
-- ROWNUM은 감춰진 컬럼으로 조회시 ROWNUM을 추가하면 출력시 볼 수 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 57
출력되는 행 제한하기 2 (SIMPLE TOP-N QUERIES) */
-- 월급이 높은 사원순으로 사원 번호, 이름, 직업, 월급을 4개의 행의로 제한하여 출력
SELECT
       EMPNO,
       ENAME,
       JOB,
       SAL
  FROM EMP
 ORDER BY SAL DESC FETCH FIRST 4 ROWS ONLY;
 
-- 월급이 높은 사원들 중 20%에 해당하는 사원만 출력
SELECT
       EMPNO,
       ENAME,
       JOB,
       SAL
  FROM EMP
 ORDER BY SAL DESC FETCH FIRST 20 PERCENT ROWS ONLY; -- 20 PERCENT라니 친절하다.
 
/* FETCH FIRST로 행을 2개로 제한하고 WITH TIES 옵션을 사용하여 값이 동일한게 있으면 출력을 해보겠다. */
SELECT
       EMPNO,
       ENAME,
       JOB,
       SAL
  FROM EMP
 ORDER BY SAL DESC FETCH FIRST 2 ROWS WITH TIES;  -- WITH TIES 옵션을 쓰니 2개로 제한한 행이 3개로 출력되었다.
 
/* OFFSET을 사용하면 출력이 시작되는 위치를 지정할 수 있다. */
SELECT
       EMPNO,
       ENAME,
       JOB,
       SAL
  FROM EMP
 ORDER BY SAL DESC OFFSET 9 ROWS; -- 지정한 위치부터 끝까지 출력이 시작된다.
 
 /* OFFSET과 FETCH를 조합하여 사용해보자 */
 SELECT
        EMPNO,
        ENAME,
        JOB,
        SAL
   FROM EMP
 ORDER BY SAL DESC OFFSET 9 ROWS -- 9번째 ROW부터 시작해서
 FETCH FIRST 2 ROWS ONLY;        -- 2개의 행만 조회한다.
 
-- 위의 SQL을 SIMPLE TOP-N QUERIES라고 한다. 정렬된 결과로부터 위쪽 또는 아래쪽의 N개의 행을 반환한다.
-- 정렬된 결과로부터 N개를 반환하기 때문에 ORDER BY 절에 쓰인다.
-- WITH TIES 옵션을 사용하면 여러행이 N번째 행의 값과 동일하다면 같이 출력을 해준다.
-- OFFSET 옵션을 사용하면 출력이 시작될 위치를 지정할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 58
여러 테이블의 데이터를 조인해서 출력하기 1 (EQUL JOIN) */
-- 사원(EMP) 테이블과 부서(DEPT) 테이블을 조인하여 이름과 부서 위치를 출력해보자
SELECT
       ENAME,
       LOC
  FROM EMP, DEPT
 WHERE EMP.DEPTNO = DEPT.DEPTNO;
 
/* WHERE절에 조건을 주지않고 아래와 같이 실행하면 전부다 조인이 되어(14X4)행이 출력된다. */
SELECT
       ENAME,
       LOC
  FROM EMP, DEPT;
  
/* 이퀄 조인을 사용하고 AND 연산자로 조건을 추가하여 직업이 ANALYST인 사원들만 출력하자 */
SELECT
       ENAME,
       LOC,
       JOB,
       EMP.DEPTNO       -- 해당 컬럼은 두 테이블 모두 존재하기 때문에 어떤 테이블의 컬럼인지 명시해야 에러가 발생하지 않는다.
  FROM EMP, DEPT
 WHERE EMP.DEPTNO = DEPT.DEPTNO
   AND EMP.JOB = 'ANALYST';
   
/* 테이블 명을 명시하다 보니 코드가 길어진다 테이블에 별칭을 붙여 간소화하자 */
SELECT
       E.ENAME,
       D.LOC,
       E.JOB
  FROM EMP E, DEPT D            -- 테이블 별 별칭을 달아 코드가 간소해졌다.
 WHERE E.DEPTNO = D.DEPTNO
   AND E.JOB = 'ANALYST';
 
-- 서로 다른 테이블에 있는 컬럼을 하나의 결과로 출력하기 위해선 JOIN이 필요하다.
-- 조인할 테이블에 서로 참조키가 동일하게 존재하여야 한다.
-- 가급적 어떤 테이블의 컬럼을 조회할 것인지 명시하여 검색 속도를 향상시키자. (명시하지 않아도 두 테이블 중 존재만 하면 조회가 되긴한다.)

---------------------------------------------------------------------------------------------------------

/* 중급 59
여러 테이블의 데이터를 조인해서 출력하기 2 (NON EQUL JOIN) */
-- 사원(EMP) 테이블과 급여 등급(SALGRADE) 테이블을 조인하여 이름, 월급, 급여 등급을 출력하자
SELECT
       E.ENAME,
       E.SAL,
       S.GRADE
  FROM EMP E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;   -- 동일한 컬럼이 존재하지 않는 테이블을 조인하기 위해서 사용하였다.
 
/* 
    동일한 컬럼이 존재하지 않는 테이블끼리의 조인은 EQUL JOIN으로 불가능하다.
    하지만, EMP 테이블에 존재하는 SAL 컬럼의 데이터는 SALGRADE LOSAL/HISAL 컬럼의 사이 값이다
    이를 해결하기 위해서 WHERE절에 조건을 위와 같이 작성하여 조인한다. (NON EQUL JOIN)
*/

-- 조인할 두 테이블에 동일한 컬럼이 없을땐 WHERE절에 조건을 작성하여 조인할 수 있다. (NON EQUL JOIN)

---------------------------------------------------------------------------------------------------------

/* 중급 60
여러 테이블의 데이터를 조인해서 출력하기 3 (OUTER JOIN) */
-- 사원(EMP) 테이블과 부서(DEPT) 테이블을 조인하여 이름과 부서 위치를 출력하는데, BOSTON도 같이 출력
SELECT
       E.ENAME,
       D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO (+) = D.DEPTNO;     -- EQUL JOIN과 다르게 BOSTON도 나오고 있다.

-- EQUL JOIN시에는 양쪽 테이블 둘다 가지고 있는 정보들만 JOIN된다.
-- OUTER JOIN은 LEFT/RIGHT로 나뉜다. (LEFT OUTER JOIN -> E.DEPTNO (+) = D.DEPTNO / RIGHT OUTER JOIN -> E.DEPTNO = (+) D.DEPTNO)
-- OUTER JOIN은 양쪽중 한쪽에 데이터가 없더라도 LEFT/RIGHT로 인해 한쪽만 있는 데이터도 출력된다.

---------------------------------------------------------------------------------------------------------

/* 중급 61
여러 테이블의 데이터를 조인해서 출력하기 4 (SELF JOIN) */
-- 사원(EMP) 테이블 자기 자신의 테이블과 조인하여 이름, 직업, 해당 사원의 관리자 이름과 관리자 직업을 출력
SELECT
       E.ENAME AS "사원",
       E.JOB AS "직업",
       M.ENAME AS "관리자",
       M.JOB AS "직업"
  FROM EMP E, EMP M
 WHERE E.MGR = M.EMPNO AND E.JOB='SALESMAN';
 
-- SELF JOIN을 사용하면 정규화가 되어있지 않은 경우에도 타 테이블을 조인하지 않고 위 쿼리와 같이 출력을 할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 62 
여러 테이블의 데이터를 조인해서 출력하기 5 (ON절) */
-- ON절을 사용한 조인 방법으로 이름과 직업, 월급, 부서 위치를 출력
SELECT
       E.ENAME,
       E.SAL,
       D.LOC
  FROM EMP E
  JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
 WHERE E.JOB = 'SALESMAN';
 
/* 여러 테이블을 ANSI 조인으로 조인해보자 */
SELECT
       E.ENAME,
       D.LOC,
       S.GRADE
  FROM EMP E
  JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)
  JOIN SALGRADE S ON (E.SAL BETWEEN S.LOSAL AND S.HISAL);

/*
    조인 작성법은 크게 오라클 조인과 ANSI 조인 작성법 두가지로 나뉜다
        ORCLE JOIN : EQUL, NON EQUAL, OUTER, SELF
        ANSI : ON, LEFT/RIGHT/FULL OUTER, USING, NATURAL, CROSS
    성능차이는 없다.
    개인적으로 ANSI 조인 작성법이 직관적으로 어떤 테이블이 조인되었는지 보기 좋다.
*/

---------------------------------------------------------------------------------------------------------

/* 중급 63
여러 테이블의 데이터를 조인해서 출력하기 6 (USING절) */
-- USING절을 사용한 조인 방법으로 이름, 직업, 월급, 부서 위치를 출력
SELECT
       E.ENAME AS "이름",
       E.JOB AS "직업",
       E.SAL AS "월급",
       D.LOC AS "부서 위치"
  FROM EMP E
  JOIN DEPT D
 USING (DEPTNO)
 WHERE E.JOB = 'SALESMAN';

/* USING절을 사용하여 여러 테이블을 조인하여 출력해보자 */
SELECT
       E.ENAME,
       D.LOC,
       S.GRADE
  FROM EMP E
  JOIN DEPT D USING(DEPTNO)
  JOIN SALGRADE S ON(E.SAL BETWEEN S.LOSAL AND S.HISAL);
 
-- WHERE절 대신 USING절을 사용하였다.
-- USING절엔 조인 조건 대신 두 테이블을 연결할 때 사용할 컬럼만 기술하면 된다.
-- USING절에 기술한 컬럼엔 별칭을 사용할 수 없다.
-- USING절엔 반드시 괄호를 사용한다.

---------------------------------------------------------------------------------------------------------

/* 중급 64
여러 테이블의 데이터를 조인해서 출력하기 7 (NATURAL JOIN)*/
-- NATURAL JOIN 방법으로 이름, 직업, 월급과 부서 위치를 출력
SELECT
       E.ENAME AS "이름",
       E.JOB AS "직업",
       E.SAL AS "월급",
       D.LOC AS "부서 위치"
  FROM EMP E NATURAL JOIN DEPT D
 WHERE E.JOB = 'SALESMAN';
 
/* 연결고리가 되는 컬럼에 테이블 별칭을 달아 실행해보자 */
SELECT
       E.ENAME AS "이름",
       E.JOB AS "직업",
       E.SAL AS "월급",
       D.LOC AS "부서 위치"
  FROM EMP E NATURAL JOIN DEPT D
 WHERE E.JOB = 'SALESMAN' AND D.DEPTNO = 30;    -- NATURAL 조인에 사용된 열은 별칭을 가질 수 없다는 에러가 출력된다.
 /* WHERE E.JOB = 'SALESMAN' AND DEPTNO = 30; */ -- 아래와 같이 기술해야 정상적으로 출력된다.
 
-- 조인 조건을 주지 않고 조인하려면 NATURAL JOIN을 사용한다.
-- NATURAL JOIN은 조건을 주지 않아도 두 테이블에 둘 다 존재하는 동일한 컬럼을 기반으로 암시적으로 조인을 수행한다.
-- NATURAL JOIN의 연결고리가 되는 컬럼은 테이블 별칭없이 기술해야 한다.

---------------------------------------------------------------------------------------------------------

/* 중급 65
여러 테이블의 데이터를 조인해서 출력하기 8 (LEFT/RIGHT OUTER JOIN) */
-- RIGHT OUTER 조인 방법으로 이름, 직업, 월급, 부서 위치를 출력
SELECT
       E.ENAME AS "이름",
       E.JOB AS "직업",
       E.SAL AS "월급",
       D.LOC AS "부서위치"
  FROM EMP E
 RIGHT JOIN DEPT D ON (E.DEPTNO = D.DEPTNO);
 
/* LEFT OUTER JOIN을 위해 DEPT 테이블에 없는 부서 번호를 넣어보자 */
INSERT
  INTO EMP(
    EMPNO,
    ENAME,
    SAL,
    JOB,
    DEPTNO
  )
  VALUES(
    8282,
    'JACK',
    3000,
    'ANALYST',
    50
  );
  
  /* LEFT OUTER JOIN으로 출력해보자 */
  SELECT
         E.ENAME AS "이름",
         E.JOB AS "직업",
         E.SAL AS "월급",
         D.LOC AS "부서위치"
    FROM EMP E
    LEFT OUTER JOIN DEPT D ON (E.DEPTNO = D.DEPTNO);

-- EQUL JOIN으로 조인이 안되는 결과를 출력하기 위해선 LEFT/RIGHT/FULL OUTER JOIN을 쓰자

---------------------------------------------------------------------------------------------------------

/* 중급 66 
여러 테이블의 데이터를 조인해서 출력하기 9 (FULL OUTER JOIN) */
-- FULL OUTER 조인 방법으로 이름, 직업, 월급, 부서 위치를 출력
SELECT
       E.ENAME AS "이름",
       E.JOB AS "직업",
       E.SAL AS "월급",
       D.LOC AS "부서 위치"
  FROM EMP E
  FULL OUTER JOIN DEPT D ON(E.DEPTNO = D.DEPTNO);

/* FULL OUTER JOIN을 사용하지 않고 동일한 결과를 출력해보자 */
SELECT
       E.ENAME AS "이름",
       E.JOB AS "직업",
       E.SAL AS "월급",
       D.LOC AS "부서 위치"
  FROM EMP E
  LEFT OUTER JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)

UNION

SELECT
      E.ENAME,
      E.JOB,
      E.SAL,
      D.LOC
  FROM EMP E RIGHT OUTER JOIN DEPT D ON(E.DEPTNO = D.DEPTNO);
  
-- FULL OUTER JOIN을 사용하면 한번에 LEFT/RIGHT OUTER JOIN을 수행한다.
-- 오라클 조인 작성법으로 작성하면 에러가 난다.

---------------------------------------------------------------------------------------------------------