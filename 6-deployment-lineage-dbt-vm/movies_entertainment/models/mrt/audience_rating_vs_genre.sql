WITH mrt_audience_rating_vs_genre AS (
    SELECT 
        m.genre, 
        n.original_rating, 
        COUNT(m.id) AS total_movies
    FROM {{ ref('Movies_Metadata') }} m
    JOIN {{ ref('Netflix_Movies_And_Tvshows') }} n 
      ON SAFE_CAST(m.id AS STRING) = n.id
    WHERE n.original_rating IS NOT NULL AND m.genre IS NOT NULL
    GROUP BY m.genre, n.original_rating
    ORDER BY m.genre, total_movies DESC
)

SELECT * FROM mrt_audience_rating_vs_genre
