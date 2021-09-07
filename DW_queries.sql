

/* 1. Determine the top 3 products in Dec 2019 in terms of total sales */
select product_name, "SUM( TOTAL_SALES )", rank from(
   select p.product_id, p.product_name,s.t_date, sum(s.total_sale) as "SUM( TOTAL_SALES )",
       rank() over (order by sum(s.total_sale) desc) as rank
   from sales s inner join product p 
   on s.product_id = p.product_id
   where t_date between to_date('01/12/2019') and to_date('31/12/2019')
   group by p.product_id,p.product_name, s.t_date
) TAB
   where rank <= 3;
   
   
/* 2.Determine which customer produced highest sales in the whole year? */
select * from (
      select c.customer_name, sum(s.total_sale) as "SUM( TOTAL_SALES )"
      from sales s inner join customer c
      on s.customer_id = c.customer_id
      group by c.customer_id, c.customer_name
      order by "SUM( TOTAL_SALES )" desc)TAB
where rownum=1;


/* 3. How many sales transactions were there for the product that 
generated maximum sales revenue in 2019? 
Also identify the:
a) product quantity sold and
b) supplier name */
select * from (
select s.product_id, su.supplier_name,count(*), sum(s.quantity_sold) as "SUM( QUANTITY )",
       rank() over (order by sum(s.total_sale) desc) as rank
from sales s 
inner join supplier su
on s.supplier_id = su.supplier_id
group by s.product_id,su.supplier_name) tab
where rank =1;


/* 4. Present the quarterly sales analysis for all warehouses using drill down query concepts */
select warehouse_name,
       sum(case when t_quarter = 1 then total_sale end) as q1_2019,
       sum(case when t_quarter = 2 then total_sale end) as q2_2019,
       sum(case when t_quarter = 3 then total_sale end) as q3_2019,
       sum(case when t_quarter = 4 then total_sale end) as q4_2019
from (
      select w.warehouse_id, w.warehouse_name, d.t_quarter, sum(s.total_sale) as total_sale
      from warehouse w, ddate d, sales s
           where s.warehouse_id = w.warehouse_id
           and s.t_date = d.t_date
      group by w.warehouse_id, w.warehouse_name, d.t_quarter
      )
group by warehouse_id, warehouse_name
order by warehouse_id;

/* 5. Create a materialised view named “Warehouse_Analysis_mv” that presents the productwise sales analysis for each warehouse. */
DROP MATERIALIZED VIEW Warehouse_Analysis_mv;
CREATE MATERIALIZED VIEW Warehouse_Analysis_mv
as 
   select s.warehouse_id, s.product_id, sum(s.total_sale) as "SUM( WAREHOUSE_TOTAL )"
   from sales s
   group by rollup (s.warehouse_id, s.product_id) /* using rollup concept */
   order by s.warehouse_id, s.product_id;

select * from Warehouse_Analysis_mv /* check materialised view */


