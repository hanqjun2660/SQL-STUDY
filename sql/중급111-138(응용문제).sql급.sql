/* 중급 111
SQL로 알고리즘 문제 풀기 1 (구구단 2단 출력) */
-- SQL을 이용하여 구구단 2단을 출력해보자. 계층형 질의문을 이용하면 루프(LOOP)문을 SQL로 구현할 수 있다.
WITH LOOP_TABLE AS (SELECT
                           LEVEL AS "NUM"
                      FROM DUAL
                    CONNECT BY LEVEL <= 9)
SELECT
       '2' || 'X' || NUM || '=' || 2 * NUM AS "2단"
  FROM LOOP_TABLE;
  
---------------------------------------------------------------------------------------------------------

/* 중급 112
SQL로 알고리즘 문제 풀기 2 (구구단 1단 ~ 9단 출력) */
-- SQL을 이용하여 구구단 1단부터 9단까지 출력
WITH LOOP_TABLE AS (SELECT
                           LEVEL AS "NUM"
                      FROM DUAL
                    CONNECT BY LEVEL <= 9),
     GUGU_TABLE AS (SELECT
                           LEVEL+1 AS "GUGU"
                      FROM DUAL
                    CONNECT BY LEVEL <= 8)
SELECT
       TO_CHAR(A.NUM) || 'X' || TO_CHAR(B.GUGU) || '=' || TO_CHAR(B.GUGU * A.NUM) AS "구구단"
  FROM LOOP_TABLE A, GUGU_TABLE B;