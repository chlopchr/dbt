{{ config(materialized='table') }}

with sales as (
    select
        s.sale_date,
        s.quantity,
        p.price,
        p.category
    from {{ ref('stg_sales') }} s
    join {{ ref('stg_products') }} p
    on s.product_id = p.product_id
)

select
    sale_date,
    category,
    sum(quantity * price) as daily_revenue
from sales
group by sale_date, category;
