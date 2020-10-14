--1: Write a program to declare 3 variables with datatype as below and display their values
--number, varchar, date

declare 
    num1 number := 10;
    var1 varchar2(40) := 'hey there';
    dat date := sysdate;
begin
    dbms_output.put_line(num1);
    dbms_output.put_line(var1);
    dbms_output.put_line(dat);
end;

--2: Write a program to check for a salary value and display the output based on the salary
/*range (use IF condition)
 if salary is greater than 100000 then display the output as 'Grade A'
 if salary is between 50000 and 100000 then display the output as 'Grade B'
 if salary is between 25000 and 50000 then display the output as 'Grade C'
 if salary is between 10000 and 25000 then display the output as 'Grade D'
 otherwise display the output as 'Grade E' 
*/ 

declare 
    salary number := 15000;
begin
    if salary > 100000 then
        dbms_output.put_line('Grade A');
    elsif salary < 100000 and salary > 50000 then
        dbms_output.put_line('Grade B');
    elsif salary < 50000 and salary > 25000 then
        dbms_output.put_line('Grade C');
    elsif salary < 25000 and salary > 10000 then
        dbms_output.put_line('Grade D');
    else
        dbms_output.put_line('Grade E');
    end if;
end;

--3: Write a program using the same conditions as in the #1 question, but use CASE
-- condition instead of IF condition.

declare 
    salary number := 5000;
begin
    case 
        when salary > 100000 then
            dbms_output.put_line('Grade A');
        when salary < 100000 and salary > 50000 then
            dbms_output.put_line('Grade B');
        when salary < 50000 and salary > 25000 then
            dbms_output.put_line('Grade C');
        when salary < 25000 and salary > 10000 then
            dbms_output.put_line('Grade D');
        else
            dbms_output.put_line('Grade E');
    end case;
end;

--4: Write a program to display values from 200 to 300 using a WHILE loop.

declare
    counter number;
begin
    counter:=200;
    while counter <=300 loop
        dbms_output.put_line(counter);
        counter:=counter+1;
    end loop;
end;

--5: Write a program to display values from 200 to 300 using a FOR loop.
begin
    for i in 200..300 loop
        dbms_output.put_line(i);
    end loop;
end;

--5: Write a program to perform below steps
/*
 Declare a variable
 If the variable value is 1 then display values from 300 to 400 using a WHILE loop
 If the variable value is 2 then display values from 400 to 800 using a FOR loop
 If the variable value is 3 then just display “wrong choice”
*/

declare 
    var1 number :=3;
    counter number := 300;
begin
    if var1 = 1 then
        while counter <=400 loop
            dbms_output.put_line(counter);
            counter:=counter+1;
        end loop;
    elsif var1 = 2 then
        for i in 400..800 loop
            dbms_output.put_line(i);
        end loop;
    elsif var1 = 3 then
        dbms_output.put_line('Wrong choice');
    end if;
end;