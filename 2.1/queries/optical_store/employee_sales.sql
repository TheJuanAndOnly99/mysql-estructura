SELECT employees.name as Employee, glasses.brand as glasses_sold
FROM SALES
INNER JOIN employees ON sales.sales_person = employees.id
INNER JOIN glasses ON sales.glasses = glasses.id
WHERE ventes.date_sold between '2023-01-01' and '2024-01-01'
order by employees.name;