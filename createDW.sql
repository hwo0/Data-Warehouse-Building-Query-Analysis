/* Drop table if exists*/
DROP TABLE SALES CASCADE CONSTRAINTS; /*Fact table*/
DROP TABLE CUSTOMER CASCADE CONSTRAINTS; /*Dimension table-Customer*/
DROP TABLE WAREHOUSE CASCADE CONSTRAINTS; /*Dimension table-Warehouse*/
DROP TABLE PRODUCT CASCADE CONSTRAINTS; /*Dimension table-Product*/
DROP TABLE SUPPLIER CASCADE CONSTRAINTS;/*Dimension table-Supplier*/
DROP TABLE DDATE CASCADE CONSTRAINTS;/*Dimension table-Date*/


/* Create dimension tables*/
/* Customer dimension */
CREATE TABLE CUSTOMER (     
CUSTOMER_ID VARCHAR2(4),
CUSTOMER_NAME VARCHAR2(28) NOT NULL,
CONSTRAINT CUSTOMER_PK PRIMARY KEY(CUSTOMER_ID));

/* Warehouse dimension */
CREATE TABLE WAREHOUSE (
WAREHOUSE_ID VARCHAR2(4),
WAREHOUSE_NAME VARCHAR2(20) NOT NULL,
CONSTRAINT WAREHOUSE_PK PRIMARY KEY(WAREHOUSE_ID));

/* Product dimension */
CREATE TABLE PRODUCT (
PRODUCT_ID VARCHAR2(6),
PRODUCT_NAME VARCHAR2(30) NOT NULL,
SALE_PRICE NUMBER(5,2) DEFAULT 0.0,
CONSTRAINT PRODUCT_PK PRIMARY KEY(PRODUCT_ID));

/* Supplier dimension */
CREATE TABLE SUPPLIER (
SUPPLIER_ID VARCHAR2(5),
SUPPLIER_NAME VARCHAR2(30) NOT NULL,
CONSTRAINT SUPPLIER_PK PRIMARY KEY(SUPPLIER_ID));

/* Date dimension */
CREATE TABLE DDATE (
TIME_ID VARCHAR2(8),
T_DATE DATE,
T_YEAR NUMBER(10,0),
T_QUARTER NUMBER(10,0), /* Create name of the day, Monday to Sunday */
T_MONTH CHAR(10),/*Create name of the month, January to December */
T_DAY NUMBER(10,0),/* Quarter 1, 2, 3, 4 */
CONSTRAINT DDATE_PK PRIMARY KEY(T_DATE));


/*Create fact table*/
CREATE TABLE SALES (
DATASTREAM_ID NUMBER(8,0),
CUSTOMER_ID VARCHAR2(4) NOT NULL,
PRODUCT_ID VARCHAR2(6) NOT NULL,
WAREHOUSE_ID VARCHAR2(4) NOT NULL,
SUPPLIER_ID VARCHAR2(5) NOT NULL,
T_DATE DATE NOT NULL,
QUANTITY_SOLD NUMBER(3,0) NOT NULL,
TOTAL_SALE NUMBER (6,2) NOT NULL, /* m.sale_price*d.quantity_sold as total_sale */
CONSTRAINT SALES_CUSTOMER_FK FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
CONSTRAINT SALES_PRODUCT_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID),
CONSTRAINT SALES_WAREHOUSE_FK FOREIGN KEY (WAREHOUSE_ID) REFERENCES WAREHOUSE(WAREHOUSE_ID),
CONSTRAINT SALES_SUPPLIER_FK FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER (SUPPLIER_ID),
CONSTRAINT SALES_DATE_FK FOREIGN KEY (T_DATE) REFERENCES DDATE (T_DATE),
CONSTRAINT SALES_PK PRIMARY KEY(DATASTREAM_ID));







