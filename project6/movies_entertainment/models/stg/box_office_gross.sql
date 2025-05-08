with stg_box_office_gross as
(
    SELECT * FROM {{ source('movies_entertainment_raw', 'box_office_gross') }}
    WHERE brand NOT IN ("","Platinum Dunes", "Vertigo Entertainment", "Bad Robot")
)

select * from stg_box_office_gross