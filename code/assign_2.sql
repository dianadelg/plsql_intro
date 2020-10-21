-- 1) Write a program to fetch data from table SALES for a given orderid and display the data.
-- (Use %TYPE when declaring variables).

declare 
    v_sales_date sales.sales_date%type;
    v_order_id sales.order_id%type :=1269; --just using a random one
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
    where order_id = v_order_id;
    
    --to check if correct, see if values went from table into vars
    dbms_output.put_line(v_sales_date || '  ' ||  v_order_id || '  ' || v_product_id || '  ' || 
    v_customer_id || '  ' || v_salesperson_id || '  ' || v_quantity || '  ' || v_unit_price || '  ' || v_sales_amount 
    || '  ' || v_tax_amount || '  ' || v_total_amount); 
end;


-- 2) Write a program to insert data into SALES table.
declare 
    v_sales_date sales.sales_date%type := sysdate;
    v_order_id sales.order_id%type := 3100; --just using a random one
    v_product_id sales.product_id%type := 200;
    v_customer_id sales.customer_id%type := 10;
    v_salesperson_id sales.salesperson_id%type := 1000;
    v_quantity sales.quantity%type := 5;
    v_unit_price sales.unit_price%type := 75;
    v_sales_amount sales.sales_amount%type := 1500;
    v_tax_amount sales.tax_amount%type := 40;
    v_total_amount sales.total_amount%type := 300;
begin
    insert into sales
        (sales_date, order_id, product_id, customer_id, salesperson_id, quantity, unit_price, sales_amount, tax_amount, total_amount)
    values 
        (v_sales_date, v_order_id, v_product_id, v_customer_id, v_salesperson_id, v_quantity, v_unit_price, v_sales_amount, v_tax_amount, v_total_amount);
    commit;
end;

    --to check if correct, see table vals to check if var vals went into table at the new order id
    select * from sales where order_id = 3100;


-- 3) Write a program to update data in SALES table for a given orderid (Change order
-- amount to 100).

declare 
    v_order_id sales.order_id%type := 3100; --using a random one
begin
    update sales 
    set total_amount = 100
    where order_id = v_order_id;
    commit;
end;

--to check if correct, see table vals to check if var vals updated table vals
select * from sales where order_id = 3100;


-- 4) Write a program to delete data from SALES table for a given orderid.
declare 
    v_order_id sales.order_id%type := 3100; --using a random one
begin
    delete from sales
    where order_id = v_order_id;
    commit;
end;

--to check if correct, see that order_id no longer exists
select * from sales where order_id = 3100;