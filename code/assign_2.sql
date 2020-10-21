--1: Write a program to fetch data from table SALES for a given orderid and display the data.
--(Use %TYPE when declaring variables).

declare
    d_prod_id sh.sales.prod_id%type;
    d_cust_id sh.sales.cust_id%type := 987;
    d_time_id sh.sales.time_id%type;
    d_channel_id sh.sales.channel_id%type;
    d_promo_id sh.sales.promo_id%type;
    d_quantity_sold sh.sales.quantity_sold%type;
    d_amount_sold sh.sales.amount_sold%type;
begin
    select 
        prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold
    into 
        d_prod_id, d_cust_id, d_time_id, d_channel_id, d_promo_id, d_quantity_sold, d_amount_sold
    from
        sh.sales
    where cust_id = d_cust_id and rownum<=1;
    --doing this because right now, there are duplicates
    
    dbms_output.put_line(d_prod_id);
    dbms_output.put_line(d_cust_id);
    dbms_output.put_line(d_time_id);
    dbms_output.put_line(d_channel_id);
    dbms_output.put_line(d_promo_id);
    dbms_output.put_line(d_quantity_sold);
    dbms_output.put_line(d_amount_sold);
end;   


--2: Write a program to insert data into SALES table.

declare
    d_prod_id sh.sales.prod_id%type:=123;
    d_cust_id sh.sales.cust_id%type := 11987;
    d_time_id sh.sales.time_id%type := sysdate;
    d_channel_id sh.sales.channel_id%type := 213;
    d_promo_id sh.sales.promo_id%type :=1231;
    d_quantity_sold sh.sales.quantity_sold%type :=1;
    d_amount_sold sh.sales.amount_sold%type:=213.12;
begin
    insert into sh.sales( 
        prod_id, cust_id, time_id, channel_id, promo_id, quantity_sold, amount_sold)
    values
        (d_prod_id, d_cust_id, d_time_id, d_channel_id, d_promo_id, d_quantity_sold, d_amount_sold);
    commit;
end;

--3: Write a program to update data in SALES table for a given orderid (Change order
-- amount to 100).
-- using cust id instead of order id

declare
    new_cust_id sh.sales.cust_id%type := 987;
begin
    update sh.sales set amount_sold= 100 where cust_id = new_cust_id;
    commit;
end;
    
--:4 delete data from sales table for given customer id 
declare
    new_cust_id sh.sales.cust_id%type := 987;
begin
    update sh.sales set amount_sold= 100 where cust_id = new_cust_id;
    commit;
end;
    Write a program to delete data from SALES table for a given orderid.
