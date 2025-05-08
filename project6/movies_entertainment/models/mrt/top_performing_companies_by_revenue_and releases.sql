with mrt_top_performing_companies_by_revenue_and_releases as
(
    SELECT 
        c.brand, 
        SUM(b.lifetime_gross) AS total_lifetime_gross, 
        COUNT(b.id) AS total_releases
    FROM {{ ref('Companies') }} c
    JOIN {{ ref('Box_Office_Gross') }} b ON c.brand = b.brand
    GROUP BY c.brand
    ORDER BY total_lifetime_gross DESC, total_releases DESC
)

select * from mrt_top_performing_companies_by_revenue_and_releases