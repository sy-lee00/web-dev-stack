-- 1. 국제시장을 감독한 감독의 다른 영화 조회
SELECT DIRECTOR, TITLE
FROM MOVIE
WHERE DIRECTOR = (SELECT DIRECTOR
                    FROM MOVIE
                    WHERE TITLE = '국제시장');
-- 2. 서울에 사는 사용자들이 리뷰를 남긴 영화 조회
SELECT DISTINCT(TITLE)
FROM USER_INFO
    JOIN REVIEW USING(USER_ID)
    JOIN MOVIE USING(MOVIE_ID)
WHERE ADDRESS LIKE '%서울%';
-- 3. 봉준호 감독 영화 중 평균 평점이 3.0 이상인 영화 조회
WITH FOURMOVIE AS (SELECT TITLE, AVG(NVL(RATING, 0)) RATING4
                    FROM MOVIE
                        JOIN REVIEW USING(MOVIE_ID)
                    WHERE DIRECTOR = '봉준호'
                    GROUP BY TITLE
)
SELECT *
FROM FOURMOVIE
WHERE RATING4 >= 3;
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