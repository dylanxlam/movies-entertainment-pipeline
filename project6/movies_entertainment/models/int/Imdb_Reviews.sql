WITH int_imdb_reviews AS (
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
    FROM {{ ref('imdb_reviews') }}
)

SELECT * FROM int_imdb_reviews
