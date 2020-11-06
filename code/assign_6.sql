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


-- 5) Write a procedure to call the procedure you have created in #2 and update the column
-- TOTAL_AMOUNT to SALES_AMOUNT + TAX_AMOUNT in the SALES table.


-- 6) Write a procedure to fetch SALES_DATE, ORDER_ID, PRODUCT_ID, CUSTOMER_ID and
-- QUANTITY from SALES table and display the data. (Use a User defined record type).