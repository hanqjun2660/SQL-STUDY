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