sqlplus duhtest/duhtest <<EOF
drop sequence duhtest.tmp_id;
create sequence duhtest.tmp_id increment by 1 start with 1 maxvalue 999999999999999 nocycle nocache;
drop table duhtest.sample;
create table duhtest.sample(addr varchar2(30),age number,marry varchar2(10),titile varchar2(30),salary number,tele number,mobile number,friend varchar2(30),wife varchar2(30));
set serveroutput on;
spool tmp1.sql
begin
for lo_n in 1..1
loop
dbms_output.put_line('drop table duhtest.sample'||lo_n||';');
dbms_output.put_line('create table duhtest.sample'||lo_n||' as select duhtest.tmp_id.nextval as id,addr,age,marry,titile,salary,tele,mobile,friend,wife from duhtest.sample'||';');
end loop;
end;
/
spool off
set serveroutput off;
@tmp1.sql
exit;
EOF
