-- Create a table for Flashback Database verification
set serveroutput on;

declare
    current_scn number;
begin
    execute immediate 'drop table sample purge';
--exception
--     when others then
--         if sqlcode != -0942 then raise;
--         end if;

    execute immediate 'create table sample(id number, current_scn number)';

    for i in 1..10 loop
        select current_scn into current_scn from v$database;
        dbms_output.put_line(i);
        dbms_output.put_line(current_scn);
        execute immediate 'insert into sample values(:1, :2)' using i, current_scn;
        execute immediate 'alter system switch logfile';
    end loop;

    FOR cursor1 IN (SELECT * FROM sample)
        LOOP
            DBMS_OUTPUT.PUT_LINE('id = ' || cursor1.id || ', current_scn = ' || cursor1.current_scn);
        END LOOP;
end;
