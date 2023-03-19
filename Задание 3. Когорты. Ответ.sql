select 
YEAR(created_at) as year,
MONTH(created_at) as month,
count(distinct fact_orders.user_id) as users,
count(distinct id) as orders,
sum(payment_sum) as payment_sum,
sum(payment_sum)/count(distinct id) as AOV,
sum(payment_sum)/count(distinct fact_orders.user_id) as ARPC,
t_first_orders.first_order_year,
t_first_orders.first_order_month
from fact_orders
inner join
(
	select 
	[user_id],
	YEAR(min(created_at)) as first_order_year,
	MONTH(min(created_at)) as first_order_month
	from fact_orders 
	group by [user_id]
	having YEAR(min(created_at)) >= 2022 
) t_first_orders on t_first_orders.user_id = fact_orders.user_id
group by 
YEAR(created_at),
MONTH(created_at),
t_first_orders.first_order_year,
t_first_orders.first_order_month