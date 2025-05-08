WITH netflix AS (
    SELECT * FROM {{ ref('netflix_movies_and_tvshows') }}
),

metadata_deduped AS (
    SELECT *
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY original_title ORDER BY id) AS row_num
        FROM {{ ref('movies_metadata') }}
    )
    WHERE row_num = 1
),

joined AS (
    SELECT
        CASE
            WHEN SAFE_CAST(m.id AS STRING) IS NULL THEN n.id
            ELSE SAFE_CAST(m.id AS STRING)
        END AS id,
        n.title,
        n.type AS original_type,
        n.director AS original_director,
        n.cast AS original_cast,
        n.country AS original_country,
        n.date_added AS original_date_added,
        n.release_year AS original_release_year,
        n.original_rating,
        n.duration AS original_duration,
        n._data_source AS original_data_source,
        n._load_time AS original_load_time
    FROM netflix n
    LEFT JOIN metadata_deduped m
        ON m.original_title = n.title
),

deduped AS (
    SELECT *
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY id ORDER BY title) AS row_num
        FROM joined
    )
    WHERE row_num = 1
)

SELECT * EXCEPT(row_num)
FROM deduped
