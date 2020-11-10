-- 1) Write a procedure to fetch data from table SALES for a given parameter orderid and
-- display the data(use ROWTYPE to capture the data)

CREATE or REPLACE PROCEDURE proc (p_order_id IN number)
IS
rec sales%ROWTYPE;
BEGIN
SELECT sales_date, order_id, product_id, customer_id, salesperson_id, quantity,
unit_price, sales_amount, tax_amount, total_amount
INTO rec
FROM sales 
WHERE order_id = p_order_id;

 dbms_output.put_line (rec.sales_date);
 dbms_output.put_line (rec.order_id);
 dbms_output.put_line (rec.product_id);
 dbms_output.put_line (rec.customer_id);
 dbms_output.put_line (rec.salesperson_id);
 dbms_output.put_line (rec.quantity);
 dbms_output.put_line (rec.unit_price);
 dbms_output.put_line (rec.sales_amount);
 dbms_output.put_line (rec.tax_amount);
 dbms_output.put_line (rec.total_amount);

EXCEPTION
    WHEN no_data_found THEN 
        dbms_output.put_line('No order exists with this id');
    WHEN too_many_rows THEN
        dbms_output.put_line('>1 row returned');
    WHEN others THEN
        dbms_output.put_line('Other error');
END;
/
--successful retrieval
begin
proc(1269);
end;
/
--error test case
begin
proc(1267);
end;

-- 2) Modify the above procedure to return the row you have stored in the ROWTYPE
-- variable using an OUT parameter.
-- 3) Write a procedure to call the above procedure and display the data.

CREATE or REPLACE PROCEDURE proc (p_order_id IN number, x_rec OUT sales%ROWTYPE)
IS
rec sales%ROWTYPE;
BEGIN
SELECT sales_date, order_id, product_id, customer_id, salesperson_id, quantity,
unit_price, sales_amount, tax_amount, total_amount
INTO rec
FROM sales 
WHERE order_id = p_order_id;

x_rec := rec;
EXCEPTION
    WHEN no_data_found THEN 
        dbms_output.put_line('No order exists with this id');
    WHEN too_many_rows THEN
        dbms_output.put_line('>1 row returned');
    WHEN others THEN
        dbms_output.put_line('Other error');
END;
/
--successful retrieval
declare
    rec sales%ROWTYPE;
begin
 proc(1269, rec);
 dbms_output.put_line (rec.sales_date);
 dbms_output.put_line (rec.order_id);
 dbms_output.put_line (rec.product_id);
 dbms_output.put_line (rec.customer_id);
 dbms_output.put_line (rec.salesperson_id);
 dbms_output.put_line (rec.quantity);
 dbms_output.put_line (rec.unit_price);
 dbms_output.put_line (rec.sales_amount);
 dbms_output.put_line (rec.tax_amount);
 dbms_output.put_line (rec.total_amount);
end;
/
--error test case
declare
    rec sales%ROWTYPE;
begin
proc(1267, rec);
 dbms_output.put_line (rec.sales_date);
 dbms_output.put_line (rec.order_id);
 dbms_output.put_line (rec.product_id);
 dbms_output.put_line (rec.customer_id);
 dbms_output.put_line (rec.salesperson_id);
 dbms_output.put_line (rec.quantity);
 dbms_output.put_line (rec.unit_price);
 dbms_output.put_line (rec.sales_amount);
 dbms_output.put_line (rec.tax_amount);
 dbms_output.put_line (rec.total_amount);
end;


-- 4) Perform the following steps.
--  Create a table SALES_COPY which is similar to SALES table.
--  Write a procedure to call the procedure you have created in #2 and insert the
-- data in the SALES_COPY table.

CREATE TABLE sales_copy_table
AS
select * from sales where 1=2;
/
CREATE OR REPLACE PROCEDURE insert_sales_data (p_order_num NUMBER)
AS
rec sales%ROWTYPE;
BEGIN
proc(p_order_num, rec);

INSERT INTO sales_copy_table VALUES(
    rec.SALES_DATE,
    rec.ORDER_ID,
    rec.PRODUCT_ID,
    rec.CUSTOMER_ID,
    rec.SALESPERSON_ID,
    rec.QUANTITY,
    rec.UNIT_PRICE,
    rec.SALES_AMOUNT,
    rec.TAX_AMOUNT,
    rec.TOTAL_AMOUNT        
);
COMMIT;
END;
/
EXEC insert_sales_data(1269);
/
select * from sales_copy_table;


-- 5) Write a procedure to call the procedure you have created in #2 and update the column
-- TOTAL_AMOUNT to SALES_AMOUNT + TAX_AMOUNT in the SALES table.

CREATE OR REPLACE PROCEDURE amount_update (order_num NUMBER)AS
total NUMBER:=0;
rec sales%ROWTYPE;
begin
    proc(order_num, rec);
    total := rec.sales_amount + rec.tax_amount;
    
    UPDATE sales set total_amount = total where order_id = order_num;
    commit;
end;
/
exec amount_update(1269);
/
select * from sales where order_id = 1269;


-- 6) Write a procedure to fetch SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID and
-- QUANTITY from SALES table and display the data. (Use a User defined record type).

CREATE OR REPLACE PROCEDURE show_data (order_num NUMBER)AS
TYPE sales_rec IS RECORD 
(
    sales_date sales.sales_date%type,
    order_id sales.order_id%type,
    product_id sales.product_id%type,
    customer_id sales.customer_id%type,
    quantity sales.quantity%type
);
rec sales_rec;
begin
    
    SELECT sales_date, order_id, product_id, customer_id, quantity
    INTO rec FROM sales where order_id = order_num;
    
    dbms_output.put_line('Sales date: ' || rec.sales_date);
    dbms_output.put_line('Order id: ' || rec.order_id);
    dbms_output.put_line('Product Id: ' || rec.product_id);
    dbms_output.put_line('Customer id: ' || rec.customer_id);
    dbms_output.put_line('Quantity: ' || rec.quantity);
end;
/
exec show_data(1269);
