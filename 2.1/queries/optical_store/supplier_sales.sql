select suppliers.name as supplierSales
from GLASSES
inner join suppliers on suppliers.id = glasses.supplier
inner join sales on sales.glasses = glasses.id
group by suppliers.name;