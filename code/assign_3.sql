-- 1) Write a procedure to fetch data from table SALES for a given parameter orderid and
-- display the data.

create or replace procedure get_order_data (p_order_id IN number)
as
    v_sales_date sales.sales_date%type;
    v_order_id sales.order_id%type; 
    v_product_id sales.product_id%type;
    v_customer_id sales.customer_id%type;
    v_salesperson_id sales.salesperson_id%type;
    v_quantity sales.quantity%type;
    v_unit_price sales.unit_price%type;
    v_sales_amount sales.sales_amount%type;
    v_tax_amount sales.tax_amount%type;
    v_total_amount sales.total_amount%type;
begin
    select sales_date, order_id, product_id, customer_id, salesperson_id, quantity, unit_price, sales_amount, tax_amount, total_amount 
    into v_sales_date, v_order_id, v_product_id, v_customer_id, v_salesperson_id, v_quantity, v_unit_price, v_sales_amount, v_tax_amount, v_total_amount
    from sales
    where order_id = p_order_id; -- param match
    
    --the same as previously done
    --check output now
    dbms_output.put_line(v_sales_date || '  ' ||  v_order_id || '  ' || v_product_id || '  ' || 
    v_customer_id || '  ' || v_salesperson_id || '  ' || v_quantity || '  ' || v_unit_price || '  ' || v_sales_amount 
    || '  ' || v_tax_amount || '  ' || v_total_amount); 
end;

--now exec the proc
exec get_order_data (1268); --pick arbitrarily

-- 2) Write a procedure which does the following operations
--      - Fetch data from table SALES for a given parameter orderid and display the data.
--      - Return the number of rows(using OUT parameter) in the SALES table for that
-- sales date (get sales date from the above operation)

CREATE OR REPLACE PROCEDURE proc (
    i_order_id IN sales.order_id%type,
    o_num_rows OUT NUMBER
) AS
    v_sales_date sales.sales_date%type;
    v_order_id sales.order_id%type; 
    v_product_id sales.product_id%type;
    v_customer_id sales.customer_id%type;
    v_salesperson_id sales.salesperson_id%type;
    v_quantity sales.quantity%type;
    v_unit_price sales.unit_price%type;
    v_sales_amount sales.sales_amount%type;
    v_tax_amount sales.tax_amount%type;
    v_total_amount sales.total_amount%type;
BEGIN
    select sales_date, order_id, product_id, customer_id, salesperson_id, quantity, unit_price, sales_amount, tax_amount, total_amount 
    into v_sales_date, v_order_id, v_product_id, v_customer_id, v_salesperson_id, v_quantity, v_unit_price, v_sales_amount, v_tax_amount, v_total_amount
    from sales
    where order_id = i_order_id;
        --to check if correct, see if values went from table into vars
    dbms_output.put_line(v_sales_date || '  ' ||  v_order_id || '  ' || v_product_id || '  ' || 
    v_customer_id || '  ' || v_salesperson_id || '  ' || v_quantity || '  ' || v_unit_price || '  ' || v_sales_amount 
    || '  ' || v_tax_amount || '  ' || v_total_amount); 

    --get the number of rows from sales date
    select COUNT(1) into o_num_rows from sales where sales_date = v_sales_date;
    dbms_output.put_line('Number of rows from sales date : ' || v_sales_date || ' is : ' || o_num_rows);
    
END;
/

DECLARE
    rows NUMBER:=0;
BEGIN
    proc(1269, rows);
END;

-- 3) Write a function which accepts 2 numbers n1 and n2 and returns the power of n1 to n2.
--  (Example: If I pass values 10 and 3, the output should be 1000)

-- 4) Write a function to display the number of rows in the SALES table for a given sales date.