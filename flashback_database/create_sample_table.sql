-- Create a table for Flashback Database verification

--create sequence scn_id_seq nocycle nocache;

--drop table sample purge;

--create table sample(scn_id number, current_scn number);

set serveroutput on;

declare
    sequence_does_not_exist exception;
    pragma exception_init(sequence_does_not_exist, -2289);
    table_or_view_does_not_exist exception;
    pragma exception_init(table_or_view_does_not_exist, -942);
    scn_id number;
    current_scn number;
begin
    execute immediate 'drop sequence scn_id_seq';
    execute immediate 'create sequence scn_id_seq nocycle nocache';

    execute immediate 'drop table sample purge';
    execute immediate 'create table sample(scn_id number, current_scn number)';

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

exception
    when sequence_does_not_exist or table_or_view_does_not_exist then
        null;
end;
