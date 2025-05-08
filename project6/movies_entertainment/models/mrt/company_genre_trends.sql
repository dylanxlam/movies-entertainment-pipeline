WITH mrt_company_genre_trends AS (

    SELECT 
        c.brand, 
        m.genre, 
        COUNT(m.id) AS total_movies, 
        SUM(b.lifetime_gross) AS total_revenue, 
        ROUND(AVG(b.lifetime_gross), 2) AS avg_revenue_per_movie
    FROM {{ ref('Movies_Metadata') }} m
    JOIN {{ ref('Box_Office_Gross') }} b ON m.id = b.id
    JOIN {{ ref('Companies') }} c ON b.brand = c.brand
    WHERE m.genre IS NOT NULL 
      AND b.lifetime_gross IS NOT NULL
    GROUP BY c.brand, m.genre
    ORDER BY total_revenue DESC

)

SELECT * FROM mrt_company_genre_trends
