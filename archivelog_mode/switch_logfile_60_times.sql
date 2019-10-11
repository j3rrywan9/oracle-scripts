set serveroutput on;

declare
  seq_num number;
begin
  select max(sequence#) into seq_num from v$archived_log;

  dbms_output.put_line('sequence# before switch logfile for 60 times: ' || seq_num);

  for i in 1..60 loop
    execute immediate 'alter system switch logfile';
  end loop;

  select max(sequence#) into seq_num from v$archived_log;

  dbms_output.put_line('sequence# after switch logfile for 60 times: ' || seq_num);
end;
/
exit;
