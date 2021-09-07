=================================================
= ============================================= = 
= =  Building a DW for MarketExpress Project  = =
= =  					      = =
= =      Step-by-step Instruction Guide	      =	=					
= ============================================= =
=================================================

# This project contains three SQL scripts 

1. createDW.sql
   This creates the star schema containing dimension tables and fact table.

2. Enrichment.sql
   This creates the PL/SQL procedure to execute the extraction, transformation and loading process.

3. DW_queries.sql
   This performs requested queries.

==================================================

# Step 1 
- Open SQL Developer and connect to Oracle server.

# Step 2
- Open and run 'DataStream_MasterData_Creator' to make sure 
  DATASTREAM and MASTERDATA data have been loaded into the server.

# Step 3
- Open and run 'createDW.sql' to create fact table and dimension tables constructed according to the star schema.
- Tables created are: SALES(Fact), CUSTOMER(Dimension), WAREHOUSE(Dimension), PROUDCT(Dimension), SUPPLIER(Dimension), and DDATE(Dimension).

# Step 4
- Open and run 'Enrichment.sql' to execute INLJ procedure. (Note: run codes excluding the --opertional step-- at the bottom first)
- A cursor will be created to read the tuples from the DATASTREAM table 
  and allow data be extracted, transformed and loaded into DW.
- PL/SQL procedure should be successfully completed.

# (Opertional Step)
- Can run 'SELECT*FROM SALES' statement at the bottom to check if INLJ procedure has been successfully completed.

# Step 5
- Open 'DW_queries.sql' to implement OLAP queries.
- Run line 4-12 for Query 1 -> Determine the top 3 products in Dec 2019 in terms of total sales?
- Run line 16-22 for Query 2 -> Determine which customer produced highest sales in the whole year?
- Run line 30-37 for Query 3 -> How many sales transactions were there for the product that generated maximum sales revenue in 2019?
- Run line 41-54 for Query 4 -> Present the quarterly sales analysis for all warehouses using drill down query concepts.
- Run line 57-64 for Query 5 -> Create a materialised view named "Warehouse_analysis_mv" that presents the productwise sales analysis for each warehouse.

==================================================
# END OF PROJECT
==================================================
 

