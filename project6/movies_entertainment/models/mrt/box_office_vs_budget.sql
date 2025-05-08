WITH mrt_box_office_vs_budget AS (

    SELECT 
        m.id AS movie_id,
        m.original_title,
        m.genre,
        m.budget,
        b.lifetime_gross,
        CASE 
            WHEN m.budget = 0 THEN NULL
            ELSE ROUND((b.lifetime_gross - m.budget) / NULLIF(m.budget, 0), 2) 
        END AS roi_percentage
    FROM {{ ref('Movies_Metadata') }} m
    JOIN {{ ref('Box_Office_Gross') }} b 
      ON m.id = b.id
    WHERE m.budget IS NOT NULL 
      AND b.lifetime_gross IS NOT NULL
      AND m.budget > 0
    ORDER BY roi_percentage DESC

)

SELECT * FROM mrt_box_office_vs_budget
