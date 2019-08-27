-- Create a table for Flashback Database verification
drop sequence scn_id_seq;

create sequence scn_id_seq nocycle nocache;

drop table sample purge;

create table sample(scn_id number, current_scn number);

set serveroutput on;

declare
    scn_id number;
    current_scn number;
begin
    for i in 1..10 loop
        select scn_id_seq.nextval into scn_id from dual;
        select current_scn into current_scn from v$database;
        dbms_output.put_line(scn_id);
        dbms_output.put_line(current_scn);
        execute immediate 'insert into sample values(:1, :2)' using scn_id, current_scn;
        execute immediate 'alter system switch logfile';
    end loop;

    FOR cursor1 IN (SELECT * FROM sample)
        LOOP
            DBMS_OUTPUT.PUT_LINE('id = ' || cursor1.scn_id || ', current_scn = ' || cursor1.current_scn);
        END LOOP;
end;
