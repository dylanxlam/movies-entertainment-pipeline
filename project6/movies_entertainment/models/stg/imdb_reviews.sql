WITH stg_imdb_reviews AS (
    SELECT
        filename,
        CASE movie_name WHEN 'N/A' THEN NULL ELSE movie_name END AS movie_name,
        sentiment,
        key_themes,
        named_entities,
        emotional_tone,
        star_rating,
        _data_source,
        _load_time
    FROM {{ source('movies_entertainment_raw', 'imdb_reviews') }}
    WHERE filename IS NOT NULL
),

deduped AS (
    SELECT *
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY filename ORDER BY filename) AS row_num
        FROM stg_imdb_reviews
    )
    WHERE row_num = 1
)

--  Explicit column list to prevent leaking row_num
SELECT 
    filename,
    movie_name,
    sentiment,
    key_themes,
    named_entities,
    emotional_tone,
    star_rating,
    _data_source,
    _load_time
FROM deduped
