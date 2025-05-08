with mrt_netflix_performance as
(
SELECT 
    n.original_type, 
    m.genre, 
    n.original_release_year, 
    n.original_rating, 
    COUNT(n.id) AS total_titles
FROM {{ ref('Netflix_Movies_And_Tvshows') }} n
JOIN {{ ref('Movies_Metadata') }} m ON n.id = SAFE_CAST(m.id as STRING)
WHERE n.original_rating IS NOT NULL
GROUP BY n.original_type, m.genre, n.original_release_year, n.original_rating
ORDER BY total_titles DESC
)

select * from mrt_netflix_performance