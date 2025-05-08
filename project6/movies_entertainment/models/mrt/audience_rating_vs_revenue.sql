WITH mrt_audience_rating_vs_revenue AS (
    SELECT 
        n.original_rating, 
        COUNT(m.id) AS total_movies, 
        SUM(b.lifetime_gross) AS total_revenue, 
        ROUND(AVG(b.lifetime_gross), 2) AS avg_revenue_per_movie
    FROM {{ ref('Movies_Metadata') }} m
    JOIN {{ ref('Box_Office_Gross') }} b ON m.id = b.id
    JOIN {{ ref('Netflix_Movies_And_Tvshows') }} n 
      ON SAFE_CAST(m.id AS STRING) = n.id
    WHERE n.original_rating IS NOT NULL 
      AND b.lifetime_gross IS NOT NULL
    GROUP BY n.original_rating
    ORDER BY total_revenue DESC
)

SELECT * FROM mrt_audience_rating_vs_revenue
