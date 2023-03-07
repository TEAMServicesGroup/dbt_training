--REMINDER: Staging tables tidy up original tables (we're tidying up the raw.stripe.payment table here)

select
    id AS payment_id,
    orderid AS order_id,
    paymentmethod AS payment_method,
    status,
    amount/100 AS amount,       --Converting cents to dollars
    created AS created_at       --Date/Time Loaded into Snowflake

from {{ source('stripe', 'payment') }}
