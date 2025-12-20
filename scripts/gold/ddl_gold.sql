/*
Gold Views
>> 3 Vies >> gold.dim_customers/ gold.dim_products/ gold.fact_sales.
*/
/*select column_name
from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = 'silver' and table_name = 'crm_cust_info';

select column_name from INFORMATION_SCHEMA.columns
where table_schema = 'silver' and table_name = 'erp_loc_a101';
1. Aggregation: get data for gender from crm and after in erp and save them
as gender
2. Changing the names came from other tables to new and more usndrstandble name
3. Some repositiones for columns counrtry after last_name and birthdate before
create date.
4.1. for this table and as we can see all are dimention we need a primary key rather than the one
is alreasy existed from other tables.
4.2. "Surrogate Key" which is the System_generated unique identifier assigned to each record in a tabel
5. All object in gold layer are view
*/
if object_id('gold.dim_customers', 'V') is not null
	drop view gold.dim_customers;
GO
create view gold.dim_customers as
select 
	 row_number() over(order by ci.cst_id) as customer_key
	,ci.cst_id as customer_id
	,ci.cst_key as customer_number
	,ci.cst_firstname as first_name
	,ci.cst_lastname as last_name
	,la.cntry as country
	,ci.cst_marital_status as marital_status
	,case when ci.cst_gndr != 'N/A' then ci.cst_gndr
		else coalesce(ca.gen, 'N/A')
	 end as gender
	,ca.bdate as birthdate
	,ci.cst_create_date as create_date
		from silver.crm_cust_info as ci
left join silver.erp_cust_az12 as ca
	on ci.cst_key = ca.cid
left join silver.erp_loc_a101 as la
	on ci.cst_key = la.cid;
-----------------------------------------------
-----------------------------------------------
/*
-----------------
select COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS
where table_schema = 'silver' and table_name = 'crm_prd_info'
----------------
1. To find the correct information in this table is good to go with end date(prd_end_dt)
 which is refare to the time ans as it is NULL means they are still active and good to have
 "" Filtering out all historical data ""
 also we can remove the prd_end_dt >> all of them NULL
2. joining silver.crm_prd_info with erp_px_g1v2 (Category table). join with cat_id
3. Checking for quality of data with subquery.. Expectation >> NO Result >> GOOD. frist two left join
4. Checking for duplicated colouns (are the same info) >>> Nothing Found >> GOOD>
5. Columns order by relative names prd_id, cat_id ...............
6. Making understandble names for each columns 
7. Making Primary Key "Surrogate Key".
8. Creating View
*/
GO
if object_id('gold.dim_products', 'V') is not null
	drop view gold.dim_products;
GO

create view gold.dim_products as
select 
	 ROW_NUMBER() over (order by pi.prd_start_dt, pi.prd_key) as product_key
	,pi.prd_id as product_id
	,pi.prd_key as product_number
	,pi.prd_nm as product_name
	,pi.cat_id as category_id
	,cg.cat as category
	,cg.subcat as subcategory
	,cg.maintenance as maintenance
	,pi.prd_cost as cost
	,pi.prd_line as product_line
	,pi.prd_start_dt as start_date
	
from silver.crm_prd_info as pi

left join silver.erp_px_cat_g1v2 as cg
on pi.cat_id = cg.id
where pi.prd_end_dt is null;
  --------------------------------------------
  --------------------------------------------
  /*
select column_name
from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = 'silver' and TABLE_NAME = 'crm_sales_details'
--------------------------------------------
1. We are going to first switch sls_prd_key and sls_cust_id to surrogate keys which created
for new gold views and use them >> Data Lookup joining tables just toget this information.
2. Left join with gold.dim_products and gold.dim_customer and added product_key and customer_key
 rather than sls_prd_key, sls_cust_id.
3. Name columns to new understandable names.
4. make sure they are in group order like >> Dimension keys[order_number, product_key, customer_ke]
 dates[order_date, shipping_date, due_date], Measures[sales_amount, quntity, price].
5. Creating the view
*/
GO
if object_id('gold.fact_sales', 'V') is not null
	drop view gold.fact_sales;
GO
create view gold.fact_sales as
select
	sd.sls_ord_num as order_number
	,dp.product_key
	,dc.customer_key
	,sd.sls_order_dt as order_date
	,sd.sls_ship_dt as shipping_date
	,sd.sls_due_dt as due_date
	,sd.sls_sales as sales_amount
	,sd.sls_quantity as quantity
	,sd.sls_price as price
from silver.crm_sales_details as sd
left join gold.dim_products as dp
	on sd.sls_prd_key = dp.product_number
left join gold.dim_customers dc
	on sd.sls_cust_id = dc.customer_id;
------------------------------------------------
------------------------------------------------

