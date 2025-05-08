with mrt_company_revenue as
(
SELECT 
    c.brand, 
    SUM(b.lifetime_gross) AS total_lifetime_gross
FROM {{ ref('Companies') }} c
JOIN {{ ref('Box_Office_Gross') }} b ON c.brand = b.brand
GROUP BY c.brand
ORDER BY total_lifetime_gross DESC
)

select * from mrt_company_revenue