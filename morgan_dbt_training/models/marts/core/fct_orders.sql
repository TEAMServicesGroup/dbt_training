with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

order_payments as (
    select
        order_id
        , sum(case when status = 'success' then amount else 0 end) as amount
    from payments
    group by 1
),

final as (
    select
        orders.order_id
        , orders.customer_id
        , orders.order_date
        , coalesce(order_payments.amount, 0) AS amount  --workaround for nulls
    from orders
    left join order_payments USING(order_id)
)

select * from final