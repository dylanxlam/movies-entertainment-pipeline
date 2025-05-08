with int_companies as
(
    select brand, total, releases
    FROM {{ ref('box_office_gross') }}

)

select * from int_companies