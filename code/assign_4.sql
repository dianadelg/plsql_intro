-- I. Write the exceptions block for all the below procedures/functions which you have
-- written in the Exercise #3.

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
EXCEPTION
    WHEN no_data_found THEN 
        dbms_output.put_line('No order exists with this id');
    WHEN too_many_rows THEN
        dbms_output.put_line('>1 row returned');
    WHEN others THEN
        dbms_output.put_line('Other error');
end;
/
exec get_order_data (1271); -- no id exists
/
exec get_order_data (1270); -- more than one row
/
exec get_order_data (1269); -- no issue


-- 2) Write a procedure which does the following operations
--  Fetch data from table SALES for a given parameter orderid and display the
-- data.
--  Return the number of rows(using OUT parameter) in the SALES table for that
-- sales date (get sales date from the about operation)

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
EXCEPTION
    WHEN no_data_found THEN 
        dbms_output.put_line('No order exists with this id');
    WHEN too_many_rows THEN
        dbms_output.put_line('>1 row returned');
    WHEN others THEN
        dbms_output.put_line('Other error');
end;
/
exec get_order_data (1271); -- no id exists
/
exec get_order_data (1270); -- more than one row
/
exec get_order_data (1269); -- no issue

-- 3) Write a function which accepts 2 numbers N1 and N2 and returns the power of
-- N1 to N2. (Example: If I pass values 10 and 3, the output should be 1000)

CREATE OR REPLACE FUNCTION funct(
base IN NUMBER,
exp IN NUMBER)
RETURN NUMBER IS
ans NUMBER := 1;
BEGIN
    for i in 1..exp LOOP
        ans:=ans*base;
    END LOOP;
    RETURN ans;
EXCEPTION  
    WHEN OTHERS THEN   
        dbms_output.put_line('Other error');
END;
/
DECLARE
    base NUMBER;
    exp NUMBER;
    ans NUMBER;
BEGIN
    base:=10;
    exp:=3;
    ans:=funct(base,exp);
    dbms_output.put_line(' ' || base || ' ^ ' || exp || ' = ' || ans);   
END;

-- 4) Write a function to display the number of rows in the SALES table for a given sales
-- date.

CREATE OR REPLACE FUNCTION funct(
i_sales_date IN DATE)
RETURN NUMBER IS
num_rows NUMBER := 0;
BEGIN
    select COUNT(1) into num_rows from sales where sales_date = i_sales_date;
    return num_rows;
END;
/
DECLARE
    i_sales_date DATE :=  (TO_DATE ('01-JAN-2015','DD-MON-YYYY'));
    num_rows NUMBER := 0;
BEGIN
    num_rows:=funct(i_sales_date);
    dbms_output.put_line('Number of rows for sales date '|| num_rows);
EXCEPTION
    WHEN no_data_found THEN 
        dbms_output.put_line('No order exists with this id');
    WHEN too_many_rows THEN
        dbms_output.put_line('>1 row returned');
    WHEN others THEN
        dbms_output.put_line('Other error');
END;
/
exec get_order_data (1271); -- no id exists
/
exec get_order_data (1270); -- > 1 row
/
exec get_order_data (1268); -- no issue exists

-- II. Write a user defined exception for function 3 which displays an exception saying “Invalid
-- Number” or “Number must be less than 100”, if it meets the below conditions
--  If N1 or N2 is null or zero
--  If N1 or N2 is greater than 100.

CREATE OR REPLACE FUNCTION funct(
base IN NUMBER,
exp IN NUMBER)
RETURN NUMBER IS
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
/
-- base null
DECLARE
    base NUMBER;
    exp NUMBER;
    ans NUMBER;
BEGIN
    base := null;
    exp:=3;
    ans:=funct(base,exp);
END;
/
--exp null
DECLARE
    base NUMBER;
    exp NUMBER;
    ans NUMBER;
BEGIN
    base := 3;
    exp:=NULL;
    ans:=funct(base,exp);
END;
/
--base zero
DECLARE
    base NUMBER;
    exp NUMBER;
    ans NUMBER;
BEGIN
    base := 0;
    exp:=10;
    ans:=funct(base,exp);
END;
/
--exp zero
DECLARE
    base NUMBER;
    exp NUMBER;
    ans NUMBER;
BEGIN
    base := 10;
    exp:=0;
    ans:=funct(base,exp);
END;
/
--base > 100
DECLARE
    base NUMBER;
    exp NUMBER;
    ans NUMBER;
BEGIN
    base := 1000;
    exp:=4;
    ans:=funct(base,exp);
END;
/
--exp > 100
DECLARE
    base NUMBER;
    exp NUMBER;
    ans NUMBER;
BEGIN
    base := 4;
    exp:=1000;
    ans:=funct(base,exp);
END;
