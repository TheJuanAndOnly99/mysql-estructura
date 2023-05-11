select clients.name, count(sales.id) as total from sales
left join clients on sales.buyer = clients.id
group by clients.nom;