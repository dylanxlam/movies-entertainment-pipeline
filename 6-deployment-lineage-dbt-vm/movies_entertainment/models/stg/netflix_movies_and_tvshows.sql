WITH stg_netflix_movies_and_tvshows AS (
    SELECT 
        show_id AS id,  -- 👈 promote early!
        type,
        title,
        director,
        `cast`,
        country,
        SAFE.PARSE_DATE('%d-%b-%y', date_added) AS date_added,
        release_year,
        rating AS original_rating,
        duration,
        _data_source,
        _load_time
    FROM {{ source('movies_entertainment_raw', 'netflix_movies_and_tvshows') }}
    WHERE show_id IS NOT NULL
),

deduped AS (
    SELECT *
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num  -- 👈 dedupe on `id` now
        FROM stg_netflix_movies_and_tvshows
    )
    WHERE row_num = 1
)

SELECT
    id,
    type,
    title,
    director,
    `cast`,
    country,
    date_added,
    release_year,
    original_rating,
    duration,
    _data_source,
    _load_time
FROM deduped
