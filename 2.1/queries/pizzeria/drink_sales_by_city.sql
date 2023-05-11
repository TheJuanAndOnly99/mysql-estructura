select stores.city as citys, SUM(products_ordered.quantity) as drinksSold from ordered_products
join products on ordered_products.product = products.id 
join comandes on ordered_products.order = orders.id
join stores on orders.store = stores.id
where products.type = 'drink'
group by stores.city