-- Active: 1728371458573@@127.0.0.1@3306@inflearn-bigquery

# 1. 포켓몬의 'speed'가 70이상이면 '빠름', 그렇지 않으면 '느림'으로 표시하는 새로운 컬럼 'Speed_Category'를 만들어주세요.(pokemon)

SELECT *
FROM pokemon
LIMIT 1

SELECT
    kor_name,
    speed,
    CASE 
        WHEN speed >= 70 THEN  '빠름'
        ELSE  '느림'
    END AS 'Speed_Category'
FROM pokemon



# 2. 포켓몬의 'type1'에 따라 'Water', 'Fire', 'Electric' 타입은 각각 '물', '불', '전기'로, 그 외 타입은 '기타'로 분류하는 새로운 컬럼 'type_Korean'을 만들어주세요.(pokemon)

SELECT *
FROM pokemon
LIMIT 1

SELECT
    DISTINCT(type1),
    COUNT(id) AS cnt
FROM pokemon
GROUP BY 1
ORDER BY 2 DESC

SELECT
    kor_name,
    type1,
    CASE 
        WHEN type1 = 'Water' THEN  '물'
        WHEN type1 = 'Fire' THEN '불'
        WHEN type1 = 'Electric' THEN '전기'
        ELSE  '기타'
    END AS 'type_Korean'
FROM pokemon



# 3. 각 포켓몬의 총점(total)을 기준으로, 300 이하면 'Low', 301에서 500 사이면 'Medium', 501 이상이면 'High'로 분류해주세요.(pokemon)

SELECT *
FROM pokemon
LIMIT 1

SELECT
    kor_name,
    total,
    CASE 
        WHEN total >= 501 THEN 'High' 
        WHEN total BETWEEN 301 AND 500 THEN 'Medium' 
        ELSE 'Low'
    END AS 'total_level'
FROM pokemon



# 4. 각 트레이너의 배지 개수(badge_count)를 기준으로, 5개 이하면 'Beginner', 6개에서 8개 사이면 'Intermediate', 그 이상이면 'Advanced'로 분류해주세요.(trainer)

SELECT *
FROM trainer
LIMIT 1

SELECT
    name,
    badge_count,
    CASE 
        WHEN badge_count > 8 THEN 'Advanced'
        WHEN badge_count BETWEEN 6 AND 8 THEN 'Intermediate'
        ELSE 'Beginner'
    END AS 'badge_level'
FROM trainer



# 5. 트레이너가 포켓몬을 포획한 날짜(catch_date)가 '2023-01-01' 이후이면 'Recent', 그렇지 않으면 'Old'로 분류해주세요.(trainer_pokemon)

SELECT *
FROM trainer_pokemon
LIMIT 1

SELECT
    catch_datetime
FROM trainer_pokemon
WHERE catch_datetime < '2023-01-01'

SELECT
    *,
    CASE 
        WHEN catch_datetime_kr > '2023-01-01' THEN 'Recent'
        ELSE 'Old'
    END AS recent_old
FROM(
    SELECT
        *,
        DATE_ADD(catch_datetime, INTERVAL 9 HOUR) AS catch_datetime_kr
    FROM trainer_pokemon
) AS subquery



SELECT
  *,
  IF(DATE(DATE_ADD(catch_datetime, INTERVAL 9 HOUR)) > '2023-01-01', 'Recent', 'Old') AS recent_or_old
FROM trainer_pokemon



# 6. 배틀에서 승자(winner_id)가 player1_id와 같으면 'Player 1 Wins', player2_id와 같으면 'Player 2 Wins', 그렇지 않으면 'Draw'로 결과가 나오게 해주세요.(battle)

SELECT *
FROM battle
LIMIT 1

SELECT
    player1_id,
    player2_id,
    winner_id,
    CASE 
        WHEN winner_id = player1_id THEN 'Player 1 Wins' 
        WHEN winner_id = player2_id THEN 'Player 2 Wins' 
        ELSE 'Draw'
    END AS battle_result
FROM battle
