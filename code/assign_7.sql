--1. Write a procedure to fetch data from table SALES for a given parameter sales date and
--display all the data(Hint: use Explicit cursors and ROWTYPE)

CREATE OR REPLACE PROCEDURE proc (p_sales_date date) AS
CURSOR cur IS select * from sales where sales_date = p_sales_date;
rec sales%ROWTYPE;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO rec;
        EXIT WHEN cur%NOTFOUND;
        dbms_output.put_line(rec.order_id);
          
    END LOOP;
    CLOSE cur;
END;
/
select * from sales
/
--should return 3
exec proc(TO_DATE('09-FEB-2015','DD-MON-YYYY'));