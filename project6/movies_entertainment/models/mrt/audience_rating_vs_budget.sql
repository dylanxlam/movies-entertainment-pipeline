with mrt_rating_vs_budget as
(
    SELECT
        n.original_rating, 
        COUNT(m.id) AS total_movies, 
        ROUND(AVG(m.budget), 2) AS avg_budget, 
        MAX(m.budget) AS max_budget, 
        MIN(m.budget) AS min_budget
    FROM {{ ref('Movies_Metadata') }} m
    JOIN {{ ref('Netflix_Movies_And_Tvshows') }} n 
      ON SAFE_CAST(m.id AS STRING) = n.id
    WHERE n.original_rating IS NOT NULL AND m.budget IS NOT NULL 
    GROUP BY n.original_rating
    ORDER BY avg_budget DESC
)

select * from mrt_rating_vs_budget

