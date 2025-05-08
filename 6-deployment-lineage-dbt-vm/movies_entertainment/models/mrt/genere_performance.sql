with mrt_genre_performance as
(
    SELECT 
        m.genre, 
        COUNT(m.id) AS total_movies, 
        SUM(b.lifetime_gross) AS total_revenue, 
        ROUND(AVG(b.lifetime_gross), 2) AS avg_revenue_per_movie
    FROM {{ ref('Movies_Metadata') }} m
    JOIN {{ ref('Box_Office_Gross') }} b ON m.id = b.id
    WHERE m.genre IS NOT NULL AND b.lifetime_gross IS NOT NULL
    GROUP BY m.genre
    ORDER BY total_movies DESC, total_revenue DESC

)

select * from mrt_genre_performance