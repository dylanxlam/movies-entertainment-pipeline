WITH genres AS (
    SELECT
        SPLIT(genres, ',') AS genres_array,
        adult,
        budget,
        id,
        imdb_id,
        original_language,
        original_title,
        overview,
        _data_source,
        _load_time
    FROM {{ ref('movies_metadata') }}
),

int_movies_metadata AS (
    SELECT
        id,
        original_title,
        genre,
        budget,
        adult,
        imdb_id,
        original_language,
        overview,
        _data_source,
        _load_time
    FROM genres, UNNEST(genres_array) AS genre
)

SELECT * FROM int_movies_metadata
