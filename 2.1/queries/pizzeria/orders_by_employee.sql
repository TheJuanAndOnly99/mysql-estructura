select employees.name as Employee, count(orders.id) as orderTotals from orders
join employees on orders.delivered_by = employees.id
group by employees.name