WITH stg_movies_metadata AS (
    SELECT 
        adult,
        budget,
        genres,
        CAST(id AS STRING) AS id,  -- 👈 force consistent typing
        imdb_id,
        original_language,
        original_title,
        overview,

        CASE WHEN genres LIKE '%Action%' THEN 1 ELSE 0 END AS action,
        CASE WHEN genres LIKE '%Adventure%' THEN 1 ELSE 0 END AS adventure,
        CASE WHEN genres LIKE '%Animation%' THEN 1 ELSE 0 END AS animation,
        CASE WHEN genres LIKE '%Comedy%' THEN 1 ELSE 0 END AS comedy,
        CASE WHEN genres LIKE '%Crime%' THEN 1 ELSE 0 END AS crime,
        CASE WHEN genres LIKE '%Documentary%' THEN 1 ELSE 0 END AS documentary,
        CASE WHEN genres LIKE '%Drama%' THEN 1 ELSE 0 END AS drama,
        CASE WHEN genres LIKE '%Family%' THEN 1 ELSE 0 END AS family,
        CASE WHEN genres LIKE '%Fantasy%' THEN 1 ELSE 0 END AS fantasy,
        CASE WHEN genres LIKE '%Foreign%' THEN 1 ELSE 0 END AS foreign,
        CASE WHEN genres LIKE '%History%' THEN 1 ELSE 0 END AS history,
        CASE WHEN genres LIKE '%Horror%' THEN 1 ELSE 0 END AS horror,
        CASE WHEN genres LIKE '%Music%' THEN 1 ELSE 0 END AS music,
        CASE WHEN genres LIKE '%Mystery%' THEN 1 ELSE 0 END AS mystery,
        CASE WHEN genres LIKE '%Romance%' THEN 1 ELSE 0 END AS romance,
        CASE WHEN genres LIKE '%Science Fiction%' THEN 1 ELSE 0 END AS scifi,
        CASE WHEN genres LIKE '%TV Movie%' THEN 1 ELSE 0 END AS tv_movie,
        CASE WHEN genres LIKE '%Thriller%' THEN 1 ELSE 0 END AS thriller,
        CASE WHEN genres LIKE '%War%' THEN 1 ELSE 0 END AS war,
        CASE WHEN genres LIKE '%Western%' THEN 1 ELSE 0 END AS western,
        _data_source,
        _load_time
    FROM {{ source('movies_entertainment_raw', 'movies_metadata') }}
    WHERE id IS NOT NULL
),

deduped AS (
    SELECT *
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
        FROM stg_movies_metadata
    )
    WHERE row_num = 1
)

-- ✅ Final SELECT should exclude row_num
SELECT
    id,
    adult,
    budget,
    genres,
    imdb_id,
    original_language,
    original_title,
    overview,
    action, adventure, animation, comedy, crime, documentary, drama,
    family, fantasy, foreign, history, horror, music, mystery, romance,
    scifi, tv_movie, thriller, war, western,
    _data_source,
    _load_time
FROM deduped
