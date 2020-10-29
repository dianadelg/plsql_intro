CREATE OR REPLACE assign_5_spec
AS 

PROCEDURE get_order_data (
    p_order_id IN number
);

PROCEDURE proc_replace (
    i_order_id IN sales.order_id%type,
    o_num_rows OUT NUMBER
);

FUNCTION funct1(
    base IN NUMBER,
    exp IN NUMBER
);

FUNCTION funct2(
    i_sales_date IN DATE
) RETURN NUMBER;

FUNCTION funct3(
    base IN NUMBER
) RETURN NUMBER;

END assign_5_spec;
