-- 1. 국제시장을 감독한 감독의 다른 영화 조회
SELECT DIRECTOR, TITLE
FROM MOVIE
WHERE DIRECTOR = (SELECT DIRECTOR
                    FROM MOVIE
                    WHERE TITLE = '국제시장')
    AND TITLE != '국제시장';
-- 2. 서울에 사는 사용자들이 리뷰를 남긴 영화 조회
SELECT DISTINCT(TITLE)
FROM REVIEW
    JOIN MOVIE USING(MOVIE_ID)
WHERE USER_ID IN (SELECT USER_ID
                    FROM USER_INFO
                        JOIN REVIEW USING(USER_ID)
                    WHERE ADDRESS LIKE '%서울%');
                    
-- JOIN으로 했을 시
SELECT DISTINCT(TITLE)
FROM REVIEW
    JOIN MOVIE USING(MOVIE_ID)
    JOIN USER_INFO USING(USER_ID)
WHERE ADDRESS LIKE '서울%';
-- 3. 봉준호 감독 영화 중 평균 평점이 3.0 이상인 영화 조회
WITH THREEMOVIE AS (SELECT TITLE, AVG(NVL(RATING, 0)) RATING4
                    FROM MOVIE
                        JOIN REVIEW USING(MOVIE_ID)
                    WHERE DIRECTOR = '봉준호'
                    GROUP BY TITLE
)
SELECT *
FROM THREEMOVIE
WHERE RATING4 >= 3;
---------------------------------------------------------------
SELECT MOVIE_ID, AVG(RATING)
FROM REVIEW
WHERE MOVIE_ID IN (SELECT MOVIE_ID 
                    FROM MOVIE
                    WHERE DIRECTOR = '봉준호')
GROUP BY MOVIE_ID
HAVING AVG(RATING) >= 3;
-- 4. 가장 리뷰 수가 많은 영화 조회
WITH COUNTMV AS (
    SELECT TITLE, COUNT(RATING) 리뷰수
    FROM MOVIE
        JOIN REVIEW USING (MOVIE_ID)
    GROUP BY TITLE
    ORDER BY COUNT(RATING) DESC
)
SELECT *
FROM COUNTMV
WHERE ROWNUM = 1;
------------------------------------------------------------------------
SELECT TITLE, REVIEW_NUM 리뷰수
FROM (SELECT TITLE, COUNT(REVIEW_ID) REVIEW_NUM
        FROM REVIEW
            JOIN MOVIE USING(MOVIE_ID)
        GROUP BY TITLE
        ORDER BY COUNT(REVIEW_ID) DESC)
WHERE ROWNUM = 1;
-- 4-1. 만약 리뷰수가 두 번째로 많은 영화들 조회
SELECT TITLE, REVIEW_NUM 리뷰수
FROM (SELECT TITLE, COUNT(REVIEW_ID) REVIEW_NUM, DENSE_RANK() OVER(ORDER BY COUNT(REVIEW_ID) DESC) RANK
        FROM REVIEW
            JOIN MOVIE USING(MOVIE_ID)
GROUP BY TITLE)
WHERE RANK = 2;
-- 5. 전체 리뷰 평균 평점보다 높은 순으로 3위까지 영화 조회
WITH SUBMOVIE AS (
    SELECT TITLE, AVG(RATING)
    FROM MOVIE
        JOIN REVIEW USING (MOVIE_ID)
    GROUP BY TITLE
    HAVING AVG(RATING) >= (SELECT AVG(RATING)
                            FROM REVIEW)
                            ORDER BY AVG(RATING) DESC
)
SELECT *
FROM SUBMOVIE
WHERE ROWNUM <= 3;
-----------------------------------------------------------------
SELECT TITLE
FROM (SELECT 
            TITLE, 
            AVG(RATING),
            DENSE_RANK() OVER(ORDER BY AVG(RATING) DESC) RANK
        FROM REVIEW
            JOIN MOVIE USING(MOVIE_ID)
        GROUP BY TITLE
        HAVING AVG(RATING) > (SELECT AVG(RATING)
                        FROM REVIEW))
WHERE RANK <= 3;