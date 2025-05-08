with int_box_office_gross as
(
    select id, brand, number_1_release, lifetime_gross, _data_source, _load_time from
        (select t2.id, t2.original_title, t1.brand, t1.number_1_release, t1.lifetime_gross, t1._data_source, t1._load_time
        FROM {{ ref('box_office_gross') }} t1
        INNER JOIN {{ ref('movies_metadata') }} t2
            ON t1.number_1_release = t2.original_title
        )
)

select * from int_box_office_gross