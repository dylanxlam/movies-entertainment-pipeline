with mrt_imdb_movies_metadata as 
(
SELECT 
    m.original_language, 
    COUNT(m.id) AS total_movies, 
    n.original_rating, 
    CASE 
        WHEN m.budget < 1000000 THEN 'Low Budget (<1M)' 
        WHEN m.budget BETWEEN 1000000 AND 50000000 THEN 'Medium Budget (1M-50M)' 
        ELSE 'High Budget (>50M)' 
    END AS budget_category
FROM {{ ref('Movies_Metadata') }} m
LEFT JOIN {{ ref('Netflix_Movies_And_Tvshows') }} n ON SAFE_CAST(m.id as STRING) = n.id
WHERE m.budget IS NOT NULL AND n.original_rating IS NOT NULL
GROUP BY m.original_language, n.original_rating, budget_category
ORDER BY total_movies DESC
)

select * from mrt_imdb_movies_metadata