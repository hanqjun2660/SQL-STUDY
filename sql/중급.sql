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

/* 중급 67
집합 연산자로 데이터를 위아래로 연결하기 1 (UNION ALL) */
-- 부서 번호와 부서 번호별 토탈 월급을 출력하는데, 맨 아래쪽 행에 토탈 월급을 출력
SELECT
       DEPTNO,
       SUM(SAL)
  FROM EMP
 GROUP BY DEPTNO
UNION ALL
SELECT
       TO_NUMBER(NULL) AS DEPTNO,
       SUM(SAL)
  FROM EMP;
  
-- UNION ALL 연산자는 위아래 쿼리의 결과를 하나로 합쳐 출력하는 집합연산자이다.
-- UNION ALL 사용시 위아래 쿼리의 컬럼 개수와 데이터 타입이 동일해야 함
-- 결과로 출력되는 컬럼명은 위쪽 쿼리의 컬럼명으로 출력됨.
-- ORDER BY절은 아래쪽 쿼리에만 작성이 가능함.

---------------------------------------------------------------------------------------------------------

/* 중급 68
집합 연산자로 데이터를 위아래로 연결하기 2 (UNION) */
-- 부서 번호와 부서 번호별 토탈 월급을 출력하는데, 맨 아래 행에 토탈 월급을 출력
SELECT
       DEPTNO,
      SUM(SAL) 
  FROM EMP
 GROUP BY DEPTNO
  
UNION

SELECT
       NULL AS DEPTNO,
       SUM(SAL)
  FROM EMP;
  
-- UNION과 UNION ALL의 차이점으로 UNION은 중복된 데이터를 하나의 고유한 값으로 출력 (중복 데이터는 1번만 출력),
-- 첫 번째 컬럼의 데이터를 기준으로 내림차순으로 정렬

---------------------------------------------------------------------------------------------------------

/* 중급 69
집합 연산자로 데이터의 교집합을 출력하기 (INTERSECT) */
-- 부서 번호 10번, 20번인 사원들을 출력하는 쿼리의 결과와 부서 번호 20번, 30번을 출력하는 쿼리 결과의 교집합을 출력
SELECT
       ENAME,
       SAL,
       JOB,
       DEPTNO
  FROM EMP
 WHERE DEPTNO IN(10, 20)

INTERSECT

SELECT
       ENAME,
       SAL,
       JOB,
       DEPTNO
  FROM EMP
 WHERE DEPTNO IN(20, 30);
  
-- INTERSECT는 두 테이블간에 교집합 데이터를 출력한다. 위 쿼리에서는 20번의 부서코드가 해당되므로 20번 코드에 해당되는 사원들이 출력된다.
-- INTERSECT도 UNION과 마찬가지로 중복 데이터를 제거하고, 데이터 결과를 내림차순으로 정렬하여 출력한다.

---------------------------------------------------------------------------------------------------------

/* 중급 70
집합 연산자로 데이터의 차이를 출력하기(MINUS) */
-- 부서 번호 10번, 20번을 출력하는 쿼리의 결과에서 부서 번호 20번, 30번을 출력하는 쿼리의 결과 차이를 출력
SELECT
       ENAME,
       SAL,
       JOB,
       DEPTNO
  FROM EMP
 WHERE DEPTNO IN(10, 20)
 
MINUS

SELECT
       ENAME,
       SAL,
       JOB,
       DEPTNO
  FROM EMP
 WHERE DEPTNO IN(20, 30);
 
-- MINUS는 두 테이블 간의 데이터 차이를 출력한다. 위 쿼리에선 10번 부서 번호가 차집합이기 때문에 10번 부서 번호의 사원들이 출력되었다.
-- MINUS 연산자도 중복을 제거하고 출력하며, 내림차순으로 출력한다.
-- 집합연산자중 UNION ALL을 제외한 집합 연산자는 결과 데이터의 중복을 제거한다.

---------------------------------------------------------------------------------------------------------

/* 중급 71
서브 쿼리 사용하기 1 (단일행 서브쿼리) */
-- JONES보다 더 많은 월급을 받는 사원들의 이름과 월급을 출력
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE SAL > (SELECT
                      SAL
                 FROM EMP
                WHERE ENAME = 'JONES');
                
/* SCOTT과 같은 월급을 받는 사원들의 이름과 월급을 출력해보자. */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE SAL = (SELECT
                     SAL
                FROM EMP
               WHERE ENAME = 'SCOTT');
               
/* SCOTT을 제외하고 출력을 해보자 */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE SAL = (SELECT
                     SAL
                FROM EMP
               WHERE ENAME = 'SCOTT')
   AND ENAME != 'SCOTT';
                
-- 서브 쿼리를 사용하면 서브 쿼리에서 검색한 데이터를 받아 메인 쿼리에서 검색을 할 수 있다.
-- 서브 쿼리는 괄호안에서 작성한다.

---------------------------------------------------------------------------------------------------------

/* 중급 72
서브 쿼리 사용하기 2 (다중 행 서브쿼리) */
-- 직업이 SALESMAN인 사원들과 같은 월급을 받는 사원들의 이름과 월급을 출력
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE SAL IN (SELECT
                     SAL
                FROM EMP
               WHERE JOB = 'SALESMAN');
               
-- 다중행 서브쿼리는 여러개의 데이터가 검색되기 때문에 메인쿼리에서 IN을 사용하여야 한다.
/*
    단일 행 서브쿼리 : 서브 쿼리에서 메인 쿼리로 하나의 값이 반환됨
    다중 행 서브쿼리 : 서브 쿼리에서 메인 쿼리로 여러개의 값이 반환됨
    다중 컬럼 서브 쿼리 : 서브 쿼리에서 메인 쿼리로 여러개의 컬럼이 반환됨
    
    단일 행 서브쿼리 연산자 -> -, !=, >, <, >=, <=
    다중 행 서브쿼리 연산자 -> IN, NOT IN, >ANY, <ANY, >ALL, <ALL
*/

---------------------------------------------------------------------------------------------------------

/* 중급 73
서브 쿼리 사용하기 3 (NOT IN) */
-- 관리자가 아닌 사원들의 이름과 월급과 직업을 출력
SELECT
       ENAME,
       SAL,
       JOB
  FROM EMP
 WHERE EMPNO NOT IN(SELECT
                           MGR
                      FROM EMP
                     WHERE MGR IS NOT NULL);
                     
-- 특정 쿼리에서 검색한 데이터 중 다른 쿼리에 없는 데이터를 검색한다.
-- 위 쿼리에서 WHERE절의 조건으로 NOT IN 연산자를 사용하였고 서브쿼리내에서 IS NOT NULL을 사용하였기 때문에
-- NULL이 아닌 사원들만 검색이 되었다. 메인 쿼리에서는 그 결과를 NOT IN을 사용하여 서브쿼리 결과에 없는 사원들을 검색하여 출력하였다.

---------------------------------------------------------------------------------------------------------

/* 중급 74
서브 쿼리 사용하기 4 (EXISTS와 NOT EXISTS) */
-- 부서 테이블에 있는 부서 번호 중에서 사원 테이블에도 존재하는 부서 번호의 부서 번호, 부서명, 부서 위치를 출력
SELECT
       DEPTNO,
       DNAME,
       LOC
  FROM DEPT D
 WHERE EXISTS (SELECT
                      *
                 FROM EMP E
                WHERE E.DEPTNO = D.DEPTNO);
                
/* 사원 테이블에 존재하지 않는 부서 검색 */
SELECT
       DEPTNO,
       DNAME,
       LOC
  FROM DEPT D
 WHERE NOT EXISTS (SELECT
                          *
                     FROM EMP E
                    WHERE E.DEPTNO = D.DEPTNO);
                    
 -- 특정 테이블의 데이터가 다른 테이블에도 존재하는지 여부를 확인할 수 있다.
 
 ---------------------------------------------------------------------------------------------------------
 
 /* 중급 75
 서브 쿼리 사용하기 5 (HAVING절의 서브 쿼리) */
 -- 직업과 직업별 토탈 월급을 출력하는데, 직업이 SALESMAN인 사원들의 토탈 월급보다 더 큰 값들만 출력
 SELECT
        SUM(SAL)
   FROM EMP
 HAVING SUM(SAL) > (SELECT
                           SUM(SAL)
                      FROM EMP
                     WHERE JOB = 'SALESMAN');
                     
-- WHERE절엔 그룹합수 사용이 불가하기 때문에 HAVING절을 사용하였다.
-- SELECT문의 6가지 절(SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY)에서 GROUP BY 절을 제외하고 서브쿼리 사용이 가능하다.

---------------------------------------------------------------------------------------------------------

/* 중급 76
서브 쿼리 사용하기 6 (FROM절의 서브 쿼리) */
-- 이름과 월급과 순위를 출력하는데 순위가 1위인 사원만 출력
SELECT
       V.ENAME,
       V.SAL,
       V.순위
  FROM (SELECT
               ENAME,
               SAL,
               RANK() OVER(ORDER BY SAL DESC) AS "순위"
          FROM EMP) V
 WHERE V.순위 = 1;
 
-- FROM절에 기술된 서브 쿼리를 INLINE VIEW라고 한다. INLINE VIEW의 결과를 가지고 순위를 출력하였다.
-- WHERE절엔 분석함수가 사용이 불가능하다. 그럴땐 위와 같이 INLINE VIEW를 통해 해결할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 77
서브 쿼리 사용하기 7 (SELECT절의 서브 쿼리) */
-- 직업이 SALESMAN인 사원들의 이름과 월급을 출력하는데, 직업이 SALESMAN인 사원들의 최대 월급과 최소 월급을 출력
SELECT
       ENAME,
       SAL,
       (SELECT MAX(SAL) FROM EMP WHERE JOB = 'SALESMAN') AS "최대 월급",
       (SELECT MIN(SAL) FROM EMP WHERE JOB = 'SALESMAN') AS "최소 월급"
  FROM EMP
 WHERE JOB = 'SALESMAN';
 
-- SELECT절의 서브 쿼리는 서브쿼리가 SELECT절로 확장되었다고해서, 스칼라 서브 쿼리라고 불린다.
-- 스칼라 서브 쿼리는 출력되는 행의 갯수만큼 반복되어 실행이 된다.
-- 같은 데이터를 반복해서 출력하므로 첫 행이 출력될때 데이터를 메모리에 올려두고 2행부터 메모리에 있는 데이터를 출력한다. 이것을 서브 쿼리 캐싱이라고 한다.

---------------------------------------------------------------------------------------------------------

/* 중급 78
데이터 입력하기 (INSERT) */
-- 사원 테이블에 데이터를 입력하는데, 사원 번호 2812, 사원 이름 JACK, 월급 3500, 입사일 2019년 6월 5일, 직업은 ANALYST로 한다.
INSERT INTO EMP
(
    EMPNO,
    ENAME,
    SAL,
    HIREDATE,
    JOB
)
VALUES
(
    2812,
    'JACK',
    3500,
    TO_DATE('2019/06/05', 'RRRR/MM/DD'),
    'ANALYST'
);

/* 데이터를 추가 후 조회해보자 */
SELECT
       *
  FROM EMP
 WHERE ENAME = 'JACK';

-- NULL을 입력하는 방법은 암시적 명시적으로 입력하는방법이 있다.
-- 테이블의 데이터를 입력하고 수정 삭제하는 SQL을 DML(DATA MANIPULATION LANGUAGE)문이라고 한다.
-- DML의 종류로는 INSERT(입력), UPDATE(수정), DELETE(삭제), MERGE(데이터 입력, 수정, 삭제를 한번에 수행)가 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 79
데이터 수정하기 (UPDATE) */
-- SCOTT의 월급을 3200으로 수정
UPDATE EMP
   SET SAL = 3200
 WHERE ENAME = 'SCOTT';

/* 업데이트 후 조회해 보자 */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE ENAME = 'SCOTT';
 
/* UPDATE문에서도 서브쿼리를 사용할 수 있다. */
UPDATE EMP
   SET SAL = (SELECT SAL FROM EMP WHERE ENAME = 'KING')
 WHERE ENAME = 'SCOTT';
 
/* UPDATE 후 조회해보자 */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE ENAME IN('SCOTT', 'KING');
 
-- UPDATE문은 저장되어 있는 데이터를 수정할때 사용한다.
-- SET에 수정할 컬럼과 데이터를 입력한다. (서브쿼리 사용가능)
-- SET에서 여러개의 컬럼을 수정할 수 있다. (","로 구분하여 사용)
-- UPDATE문은 모든 절에서 서브쿼리 사용이 가능하다.

---------------------------------------------------------------------------------------------------------

/* 중급 80
데이터 삭제하기 (DELETE, TRUNCATE, DROP) */
-- 사원 테이블에서 SCOTT의 행 데이터를 삭제하자
DELETE
  FROM EMP
 WHERE ENAME = 'SCOTT';
 
/* 삭제 후 조회해보자. */
SELECT
       *
  FROM EMP
 WHERE ENAME = 'SCOTT';

/* TRUNCATE */
-- TRUNCCATE TABLE EMP;
/*
    TRUNCATE는 삭제 후 취소가 불가능 하다.
    모든 데이터를 지우고 테이블 구조만 남는다.
*/

/* DROP */
--DROP TABLE EMP;
/*
    DROP은 테이블 전체를 삭제한다.
    삭제 후 취소가 불가능하지만 FLASHBACK으로 테이블을 복구할 수 있다.
*/

-- TRUNCATE, DROP문은 DDL문이다. (DELETE는 DML문)
-- DELETE는 잘 쓰지않는다. (보통 UPDATE로 상태 컬럼을 변경하는것으로 한다.)
-- WHERE절을 사용하지 않으면 테이블 내 모든행이 삭제된다.

---------------------------------------------------------------------------------------------------------

/* 중급 81
데이터 저장 및 취소하기 (COMMIT, ROLLBACK) */
-- 사원 테이블에 사원 테이블에 입력한 데이터가 데이터베이스에 저장되도록 해보자
INSERT INTO EMP(
    EMPNO,
    ENAME,
    SAL,
    DEPTNO
)
VALUES(
    1122,
    'JACK',
    3000,
    20
);

COMMIT;

UPDATE EMP
   SET SAL = 4000
 WHERE ENAME = 'SCOTT';
 
ROLLBACK;

-- 변경한 데이터를 데이터베이스에 저장하거나 취소하는 방법이다.
/*
    COMMIT : 모든 변경 사항을 데이터베이스에 저장한다.
    ROLLBACK : 모든 변경 사항을 취소한다.
    SAVEPOINT : 특정 지점까지의 변경을 취소한다.
*/

---------------------------------------------------------------------------------------------------------

/* 중급 82
데이터 입력, 수정, 삭제 한번에 하기 (MERGE) */
/* 
    사원 테이블에 부서 위치 컬럼을 추가하고, 부서 테이블을 이용하여 해당 사원의
    부서 위치로 값이 갱신되도록 해보자. 만약 부서 테이블에는 존재하는 부서인데,
    사원 테이블에 없는 부서 번호라면 새롭게 사원 테이블에 입력되도록 하자.
*/

-- 사원테이블에는 부서 위치 컬럼이 없기 때문에 먼저 만들어주자.
ALTER TABLE EMP
  ADD LOC VARCHAR2(10);

MERGE INTO EMP E
USING DEPT D
ON (E.DEPTNO = D.DEPTNO)
WHEN MATCHED THEN           -- MERGE INSERT절
UPDATE SET E.LOC = D.LOC
WHEN NOT MATCHED THEN       -- MERGE UPDATE절
INSERT (E.EMPNO, E.DEPTNO, E.LOC) VALUES(1111,D.DEPTNO, D.LOC);

-- MERGE문은 입력, 수정, 삭제를 한 쿼리내에서 전부 실행할 수 있는 방법이다.

---------------------------------------------------------------------------------------------------------

/* 중급 83
락(LOCK) 이해하기 */
-- 같은 데이터를 동시에 갱신할 수 없도록 하는 락(LOCK)을 이해해 보자
-- LOCK은 데이터의 일관성을 유지하기 위해 사용된다.(데이터 정합성)
-- LOCK은 터미널 1, 2를 동시에 열어두고 해본다면 쉽게 파악할 수 있다.

/* 터미널 1 에서 SAL 컬럼의 값을 3000으로 UPDATE한다. */
UPDATE EMP
   SET SAL = 3000
 WHERE ENAME = 'JONES';
 
/* 터미널 2 에서 SAL 컬럼의 값을 9000으로 UPDATE한다. */
UPDATE EMP
   SET SAL = 9000
 WHERE ENAME = 'JONES'; -- 터미널 1에서 COMMIT을 하지 않았기 때문에 해당 행이 LOCK이 걸린다.
 
-- 오라클은 LOCK을 사용하여 데이터 정합성을 지키기 위해 COMMIT전 UPDATE가 한번 더 실행되면 LOCK을 건다.

---------------------------------------------------------------------------------------------------------

/* 중급 84
SELECT FOR UPDATE절 이해하기 */
-- JONES의 이름과 월급과 부서 번호를 조회하는 동안 다른 세션에서 JONES의 데이터를 갱신하지 못하도록 해보자
SELECT
       ENAME,
       SAL,
       DEPTNO
  FROM EMP
 WHERE ENAME = 'JONES'
   FOR UPDATE;  -- 검색하는 행에 LOCK을 건다.
   
UPDATE EMP
   SET SAL = 9000
 WHERE ENAME = 'JONES';      -- LOCK이 걸려 실행이 멈춘다.
 
-- LOCK과 마찬가지로 먼저 조회된 세션에서 COMMIT시 LOCK이 해제되고, 후에 UPDATE한 세션에서 UPDATE가 실행된다.
   
---------------------------------------------------------------------------------------------------------

/* 중급 85 
서브 쿼리를 사용하여 데이터 입력하기 */
-- EMP 테이블의 구조를 그대로 복제한 EMP2 테이블에 부서 번호가 10번인 사원들의 사원 번호, 이름, 월급, 부서 번호를 한 번에 입력해보자.
/* EMP2 테이블이 없기 때문에 먼저 만들자 (EMP 테이블의 구조만 가져온다.) */
CREATE TABLE EMP2
AS
    SELECT * 
      FROM EMP
     WHERE 1 = 2;

INSERT INTO EMP2(EMPNO, ENAME, SAL, DEPTNO)
SELECT
       EMPNO,
       ENAME,
       SAL,
       DEPTNO
  FROM EMP
 WHERE DEPTNO = 10;
 
/* 조회해보자 */
SELECT * FROM EMP2;

-- INSERT절의 VALUES 대신 서브쿼리를 기술하자.
-- WHERE 1 = 2는 FALSE로 테이블 구조만 복사된다. WHERE 1 = 1은 TRUE로 구조 + 데이터가 복사된다.

---------------------------------------------------------------------------------------------------------

/* 중급 86
서브 쿼리를 사용하여 데이터 수정하기 */
-- 직업이 SALESMAN인 사원들의 월급을 ALLEN의 월급으로 변경
UPDATE EMP
   SET SAL = (SELECT
                     SAL
                FROM EMP
               WHERE ENAME = 'ALLEN')
 WHERE JOB = 'SALESMAN';

/* UPDATE후 조회해보자 */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE JOB = 'SALESMAN'
    OR ENAME = 'ALLEN';     -- ALLEN도 같이 조회해서 비교해보자
    
---------------------------------------------------------------------------------------------------------

/* 중급 87
서브 쿼리를 사용하여 데이터 삭제하기 */
-- SCOTT보다 더 많은 월급을 받는 사원들을 삭제해보자
DELETE
  FROM EMP
 WHERE SAL > (SELECT
                     SAL
                FROM EMP
               WHERE ENAME = 'SCOTT');
               
/* 조회하면 2명의 데이터가 삭제되어있다. */
SELECT
       *
  FROM EMP;
  
ROLLBACK;

-- 서브쿼리를 사용하여 데이터 삭제 조건을 사용할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 88
서브 쿼리를 사용하여 데이터 합치기 */
/* 
    부서 테이블에 숫자형으로 SUMSAL컬럼을 추가합니다. 그리고 사원 테이블을 이용하여
    SUMSAL 컬럼의 데이터를 부서 테이블의 부서 번호별 토탈 월급으로 갱신합니다.
*/

/* 부서 테이블에 SUMSAL 컬럼이 존재하지 않으니 먼저 추가해주자 */
ALTER TABLE DEPT ADD SUMSAL NUMBER(10);
COMMIT;

 MERGE INTO DEPT D
 USING (SELECT                          -- USING절에서 서브쿼리를 사용하여 출력되는 데이터를 가지고 DEPT테이블에 MERGE하였다.
               DEPTNO,
               SUM(SAL) AS "SUMSAL"
          FROM EMP
         GROUP BY DEPTNO) V
    ON (D.DEPTNO = V.DEPTNO)            -- 서브 쿼리에서 반환하는 부서 번호와, 사원테이블의 부서번호로 조인을 한다.
  WHEN MATCHED THEN                     -- 두 테이블의 부서 번호가 서로 일치하는지 확인
UPDATE
   SET D.SUMSAL = V.SUMSAL;             -- 일치하면 해당 부서 번호의 토탈 월급으로 값을 UPDATE

COMMIT;

/* DEPT 테이블을 조회해보자 */
SELECT
       *
  FROM DEPT;

/* MERGE문으로 수행하지 않고 동일한 수행을할 때 */
UPDATE DEPT D
   SET SUMSAL = (SELECT
                        SUM(SAL)
                   FROM EMP E
                  WHERE E.DEPTNO = D.DEPTNO);

---------------------------------------------------------------------------------------------------------

/* 중급 89
계층형 질의문으로 서열을 주고 데이터 출력하기 1 */
-- 계층형 질의문을 이용하여 사원 이름, 월급, 직업을 출력하는데 사원들 간의 서열(LEVEL)을 같이 출력
SELECT
       RPAD(' ', LEVEL*3) ||
       ENAME AS EMPLOYEE,
       LEVEL, 
       SAL,
       JOB
  FROM EMP
 START WITH ENAME = 'KING'          -- KING이 최상위 계층이 된다.
CONNECT BY PRIOR EMPNO = MGR;       -- 부모노드와 자식노드를 지정

-- CONNECT BY와 START WITH절을 사용하면 LEVEL 컬럼을 출력할 수 있다.
-- LEVEL은 트리 구조에서의 계층을 뜻한다.

---------------------------------------------------------------------------------------------------------

/* 중급 90
계층형 질의문으로 서열을 주고 데이터 출력하기 2 */
-- 예제 89 결과에서 BLAKE와 BLAKE의 직속 부하들은 출력되지 않도록 해보자
SELECT
       RPAD(' ', LEVEL*3) ||
       ENAME AS "EMPLOYEE",
       LEVEL,
       SAL,
       JOB
  FROM EMP
 START WITH ENAME = 'KING'
CONNECT BY PRIOR EMPNO = MGR
   AND ENAME != 'BLAKE';
   
-- BLAKE의 팀원들까지 전부 안나오게 하려면 CONNECT BY절에 조건을 걸어야한다.

---------------------------------------------------------------------------------------------------------

/* 중급 91
계층형 질의문으로 서열을 주고 데이터 출력하기 3 */
-- 계층형 질의문을 이용하여 사원 이름, 월급, 직업을 서열과 같이 출력하는데, 서열 순서를 유지하면서 월급이 높은 사원부터 출력
SELECT
       RPAD(' ', LEVEL * 3) ||
       ENAME AS "EMPLOYEE",
       LEVEL,
       SAL,
       JOB
  FROM EMP
 START WITH ENAME = 'KING'
CONNECT BY PRIOR EMPNO = MGR
 ORDER SIBLINGS BY SAL DESC;
 
-- ORDER BY 사이에 SIBLINGS를 사용하면 계층형 질의문 순서를 깨뜨리지 않으면서 조건대로 정렬하여 출력할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 92
계층형 질의문으로 서열을 주고 데이터 출력하기 4 */
-- 계층형 질의문과 SYS_CONNECT_BY 함수를 이용하여 서열 순서를 가로로 출력
SELECT
       ENAME,
       SYS_CONNECT_BY_PATH(ENAME, '/') AS "PATH"
  FROM EMP
 START WITH ENAME = 'KING'
CONNECT BY PRIOR EMPNO = MGR;

/* LTRIM을 사용해서 제일 앞에 붙는'/'를 지우고 출력을 해보자 */
SELECT
       ENAME,
       LTRIM(SYS_CONNECT_BY_PATH(ENAME, '/'), '/') AS "PATH"
  FROM EMP
 START WITH ENAME = 'KING'
CONNECT BY PRIOR EMPNO = MGR;

-- SYS_CONNECT_BY_PATH 함수에 두번째 인자를 입력하면 조회하는 컬럼사이에 두번째 인자가 출력되며 구분해준다.

---------------------------------------------------------------------------------------------------------

/* 중급 93
일반 테이블 생성하기 (CREATE TABLE) */
-- 사원 번호, 이름, 월급, 입사일을 저장할 수 있는 테이블을 생성
CREATE TABLE EMP01
(
    EMPNO NUMBER(10),
    ENAME VARCHAR2(10),
    SAL NUMBER(10,2),
    HIREDATE DATE
);

/* 
    CHAR : 고정 길이 문자 데이터 유형, 최대 길이는 2000
    VARCHAR2 : 가변 길이 문자 데이터 유형, 최대 길이는 4000
    LONG : 가변 길이 문자 데이터 유형, 최대 2GB 문자 데이터 허용
    CLOB : 문자 데이터 유형, 최대 4GB 문자 데이터 허용
    BLOB : 바이너리 데이터 유형, 최대 4GB 바이너리 데이터 허용
    NUMBER : 숫자 데이터 유형, 십진 숫자의 자리수는 최대 38자리까지, 소수점 이하 자리는 -84 ~ 127까지 허용
    DATE : 날짜 데이터 유형 기원전 4712년 01월 01일 부터 기원 후 9999년 12월 31일까지 날짜를 허용
*/

---------------------------------------------------------------------------------------------------------

/* 중급 94
임시 테이블 생성하기 (CREATE TEMPORARY TABLE) */
-- 사원 번호, 이름, 월급을 저장할 수 있는 테이블을 생성하는데 COMMIT할 때 까지만 데이터를 저장할 수 있도록 하자
CREATE GLOBAL TEMPORARY TABLE EMP37
(
    EMPNO NUMBER(10),
    ENAME VARCHAR2(10),
    SAL NUMBER(10)
)
ON COMMIT DELETE ROWS;

/* 만든 임시테이블에 데이터를 넣어보고 확인해보자 */
INSERT INTO EMP37(EMPNO, ENAME, SAL) SELECT EMPNO, ENAME, SAL FROM EMP;

SELECT * FROM EMP37;    -- 데이터가 잘 들어가 있다. COMMIT후 확인해보자

COMMIT;     -- COMMIT 후 다시 임시테이블을 조회하면 데이터가 삭제되어있다.

/* ON COMMIT PRESERVE ROW 옵션도 사용해서 테스트 해보자 */
CREATE GLOBAL TEMPORARY TABLE EMP38
(
    EMPNO NUMBER(10),
    ENAME VARCHAR2(10),
    SAL NUMBER(10)
)
ON COMMIT PRESERVE ROWS;

INSERT INTO EMP38(EMPNO, ENAME, SAL) SELECT EMPNO, ENAME, SAL FROM EMP;
COMMIT;

SELECT * FROM EMP38;    -- 아직 잘 들어있다 세션을 종료하고 다시 확인해보자.

-- TEMPORARY TABLE은 임시 테이블을 뜻한다. 임시 테이블은 데이터를 임시로 보관하기 위해 사용한다.
-- TEMPORARY TABLE에는 옵션이 존재한다. (ON COMMIT DELETE ROWS(COMMIT할때까지만 데이터 보관), ON COMMIT PRESERVE ROWS(세션이 종료될때까지 데이터 보관))

---------------------------------------------------------------------------------------------------------

/* 중급 95
복잡한 쿼리를 단순하게 하기 1 (VIEW) */
-- 직업이 SALESMAN인 사원들의 사원 번호, 이름, 월급, 직업, 부서 번호를 출력하는 VIEW를 생성해보자

/* VIEW를 만들 권한이 없다면 SYSTEM 계정에서 해당 계정에 VIEW 생성 권한을 부여하자 */
GRANT CREATE VIEW TO C##SCOTT;

CREATE VIEW EMP_VIEW
AS
SELECT
       EMPNO,
       ENAME,
       SAL,
       JOB,
       DEPTNO
  FROM EMP
 WHERE JOB = 'SALESMAN';
 
 /* 조회해보자 */
 SELECT * FROM EMP_VIEW;
 
 -- VIEW는 VIEW를 통해 보여줘야 할 테이블을 AS 이후에 작성한다.
 -- VIEW는 보여주어야하는 테이블의 일부 컬럼들만 공개할 수 있기 때문에 보안상 공개되지 않아야하는 데이터가 있을 때 유용하다.
 -- VIEW에 있는 데이터를 변경하면 실제 테이블의 데이터가 변경된다.
 
 ---------------------------------------------------------------------------------------------------------
 
 /* 중급 96
 복잡한 쿼리를 단순하게 하기 2 (VIEW) */
 -- 부서 번호와 부서 번호별 평균 월급을 출력하는 VIEW를 생성해보자
 CREATE VIEW EMP_VIEW2
 AS
 SELECT
        DEPTNO,
        ROUND(AVG(SAL)) AS "평균 월급"
  FROM EMP
 GROUP BY DEPTNO;
 
SELECT * FROM EMP_VIEW2;
 
-- VIEW 생성시 함수나 그룹함수 작성 시 반드시 별칭을 사용해야 한다.
-- 위와같이 함수나 그룹함수가 포함되어 있는 VIEW를 복합 VIEW라고 함
-- 복합 VIEW의 경우 데이터가 수정이 불가능할 수 있음

---------------------------------------------------------------------------------------------------------

/* 중급 97
데이터 검색 속도를 높이기 (INDEX) */
-- 월급을 조회할 때 검색 속도를 높이기 위해 월급에 인덱스를 생성해보자
CREATE INDEX EMP_SAL
    ON EMP(SAL);

/* 조회해보자 */
SELECT
       ENAME,
       SAL
  FROM EMP
 WHERE SAL = 1600;
  
-- 인덱스가 없을 경우 데이터 검색시 월급 컬럼을 처음부터 스캔하고 중간에 1600을 찾은 후 남은 데이터중 1600이 또 있을지 모르니 테이블을 끝까지 스캔한다.
-- 인덱스가 생성된 경우 데이터를 검색하면 컬럼의 데이터를 내림차순으로 정렬하고 인덱스의 ROWID로 테이블의 ROWID를 찾아 조회한다.
-- 조회 빈도수가 많은 경우 인덱스를 활용하면 속도를 높일 수 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 98
절대로 중복되지 않는 번호 만들기 (SEQUENCE) */
-- 숫자 1번부터 100번까지 출력하는 시퀀스를 만들어보자
CREATE SEQUENCE SEQ1
       START WITH 1
       INCREMENT BY 1
       MAXVALUE 100
       NOCYCLE;
       
/* 테이블을 만들어 시퀀스를 사용해보자 */
CREATE TABLE EMP02
(
    EMPNO NUMBER(10),
    ENAME VARCHAR2(10),
    SAL NUMBER(10)
);

INSERT INTO EMP02 VALUES(SEQ1.NEXTVAL, 'JACK', 3500);
INSERT INTO EMP02 VALUES(SEQ1.NEXTVAL, 'JAMES', 4500);
COMMIT;

SELECT * FROM EMP02;

-- 시퀀스는 일련번호 생성기이다.
-- 시퀀스를 사용하여 NEXTVAL을 사용하면 시퀀스의 현재 번호 다음 번호로 자동으로 넘어간다.

---------------------------------------------------------------------------------------------------------
  
/* 중급 99
실수로 지운 데이터 복구하기 1 (FLASHBACK QUERY) */
  
/* 사원테이블에 5분 전 KING 데이터를 검색해보자 */

SELECT * FROM EMP WHERE ENAME = 'KING';

UPDATE EMP SET SAL = 2000;
ROLLBACK;

SELECT
       *
  FROM EMP
AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE)
 WHERE ENAME = 'KING';
 
/* 플래쉬백 시간 확인하기 */
SELECT NAME, VALUE FROM V$PARAMETER WHERE NAME = 'UDNO_RENTENTION';
 
-- AS OF TIMESTAMP절에서 SYSTIMESTAMP - INTERVAL '5' MINUTE은 현재시간에서 5분을 뺀 시간을 의미한다.
-- 테이블을 플래쉬백 할 수 있는 시간은 기본이 15분이다. 이 시간을 확인하는데는 UNDO_RETENTION으로 확인이 가능하다.

---------------------------------------------------------------------------------------------------------

/* 중급 100
실수로 지운 데이터 복구하기 2 (FLASHBACK TABLE) */
-- 사원 테이블을 5분 전으로 되돌려보자
ALTER TABLE EMP ENABLE ROW MOVEMENT;

SELECT * FROM EMP;

FLASHBACK TABLE EMP TO TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE);
COMMIT;

/* TO_TIMESTAMP 함수를 사용해 지정한 시점으로 되돌릴 수 있다. */
FLASHBACK TABLE EMP TO TIMESTAMP
TO_TIMESTAMP('19/06/30 07:20:59', 'RR/MM/DD HH24:MI:SS');

-- FLASHBACK TABLE을 사용하면 현재까지 수행했던 DML작업을 반대로 수행하며 되돌린다.
-- FLASHBACK을 사용하여 성공적으로 수행되었다면 COMMIT을 하여 영구히 저장해야 한다.
-- TO_TIMESTAMP는 시점을 지정하여 되돌릴 수 있지만 현재시점부터 지정된 시점 사이 DDL/DCL문을 수행하였다면 에러가 발생하고 FLASHBACK이 수행되지 않는다.

---------------------------------------------------------------------------------------------------------

/* 중급 101
실수로 지운 데이터 복구하기 3 (FLASHBACK DROP) */
-- DROP된 사원 테이블을 복구해보자
DROP TABLE EMP;

/* 아래 쿼리를 실행하면 휴지통에 있는 테이블을 확인할 수 있다. */
SELECT ORIGINAL_NAME, DROPTIME FROM USER_RECYCLEBIN;

/* 테이블을 FLASHBACK 해보자 */
FLASHBACK TABLE EMP TO BEFORE DROP RENAME TO EMP;

/* 테이블이 복구되어 정상적으로 조회된다. */
SELECT * FROM EMP;

-- FLASHBACK TABLE 테이블명 TO DROP RENAME TO 테이블명 으로 DROP된 테이블을 복구할 수 있다.

---------------------------------------------------------------------------------------------------------

/* 중급 102
실수로 지운 데이터 복구하기 4 (FLASHBACK VERSION QUERY) */
-- 사원 테이블의 데이터가 과거 특정 시점부터 지금까지 어떻게 변경되어 왔는지 이력 정보를 출력
SELECT
       ENAME,
       SAL,
       VERSIONS_STARTTIME,
       VERSIONS_ENDTIME,
       VERSIONS_OPERATION
  FROM EMP
VERSIONS BETWEEN TIMESTAMP
         TO_TIMESTAMP('2023-08-04 21:40:00', 'RRRR-MM-DD HH24:MI:SS')
         AND MAXVALUE
 WHERE ENAME = 'KING'
 ORDER BY VERSIONS_STARTTIME;
 
-- VERSION절에 보고싶은 기간을 지정할 수 있다. 시분초까지 상세히 설정이 가능하다.