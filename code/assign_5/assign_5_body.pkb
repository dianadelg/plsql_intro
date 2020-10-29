CREATE OR REPLACE PACKAGE BODY
AS

--1

PROCEDURE get_order_data (
    p_order_id IN number
)
IS
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
EXCEPTION
    WHEN no_data_found THEN 
        dbms_output.put_line('No order exists with this id');
    WHEN too_many_rows THEN
        dbms_output.put_line('>1 row returned');
    WHEN others THEN
        dbms_output.put_line('Other error');
END get_order_data;

--2

PROCEDURE proc_replace (
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
EXCEPTION
    WHEN no_data_found THEN 
        dbms_output.put_line('No order exists with this id');
    WHEN too_many_rows THEN
        dbms_output.put_line('>1 row returned');
    WHEN others THEN
        dbms_output.put_line('Other error');
END proc_replace;

--3

FUNCTION funct1(
base IN NUMBER,
exp IN NUMBER)
RETURN NUMBER 
IS
ans NUMBER := 1;
BEGIN
    for i in 1..exp LOOP
        ans:=ans*base;
    END LOOP;
    RETURN ans;
EXCEPTION  
    WHEN OTHERS THEN   
        dbms_output.put_line('Other error');
END funct1;

--4 

FUNCTION funct2(
i_sales_date IN DATE)
RETURN NUMBER 
IS
num_rows NUMBER := 0;
BEGIN
    select COUNT(1) into num_rows from sales where sales_date = i_sales_date;
    return num_rows;
END;

--5

FUNCTION funct3(
base IN NUMBER,
exp IN NUMBER)
RETURN NUMBER 
IS
ans NUMBER := 1;
null_or_zero_exception EXCEPTION;
greater_than_100_exception EXCEPTION;
BEGIN
    IF base is null OR exp is null or base = 0 or exp = 0 THEN
        RAISE null_or_zero_exception;
    END IF;
    
    IF base > 100 or exp > 100 THEN
        RAISE greater_than_100_exception;
    END IF;
    
    for i in 1..exp LOOP
        ans:=ans*base;
    END LOOP;
    RETURN ans;
EXCEPTION
    WHEN null_or_zero_exception THEN
        dbms_output.put_line('base or exponent is either null or zero');
        IF base is NULL THEN
            dbms_output.put_line('base null');
        ELSIF base = 0 THEN 
            dbms_output.put_line('base 0');
        ELSIF exp is NULL THEN
            dbms_output.put_line('exp null');
        ELSE 
            dbms_output.put_line('exp 0');
        END IF;
        return 0;
    WHEN greater_than_100_exception THEN
        dbms_output.put_line('base of exponent > 100');
        IF base > 100 THEN
        dbms_output.put_line('base > 100');
        ELSE
        dbms_output.put_line('exp > 0');
        END IF;
        return 0;
    WHEN others THEN
        dbms_output.put_line('other error');
        return 0;
END;
