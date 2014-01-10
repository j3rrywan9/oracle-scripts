sqlplus duhtest/duhtest <<EOF
declare
nn_n number;
ntl number;
nt2 number;
nt3 number;
nt4 number;
nt5 number;
begin
for j in 1..4000 loop
for i in 1..1 loop
select tmp_id.nextval into ntl from dual;
select tmp_id.nextval into nt2 from dual;
select tmp_id.nextval into nt3 from dual;
select tmp_id.nextval into nt4 from dual;
select tmp_id.nextval into nt5 from dual;
execute immediate 'insert into duhtest.sample'||i||' values(:1,:2,:3,:4,:5,:6,:7,:8,:9,:10)' using ntl,'guangzhou',ntl,'y','ENG',ntl,ntl,ntl,'Gill','LiJing' ;
execute immediate 'insert into duhtest.sample'||i||' values(:1,:2,:3,:4,:5,:6,:7,:8,:9,:10)' using nt2,'guangzhou',nt2,'y','ENG',nt2,nt2,nt2,'Gill','LiJing' ;
execute immediate 'insert into duhtest.sample'||i||' values(:1,:2,:3,:4,:5,:6,:7,:8,:9,:10)' using nt3,'guangzhou',nt3,'y','ENG',nt3,nt3,nt3,'Gill','LiJing' ;
execute immediate 'insert into duhtest.sample'||i||' values(:1,:2,:3,:4,:5,:6,:7,:8,:9,:10)' using nt4,'guangzhou',nt4,'y','ENG',nt4,nt4,nt4,'Gill','LiJing' ;
execute immediate 'insert into duhtest.sample'||i||' values(:1,:2,:3,:4,:5,:6,:7,:8,:9,:10)' using nt5,'guangzhou',nt5,'y','ENG',nt5,nt5,nt5,'Gill','LiJing' ;
commit;
end loop;
end loop;
end;
/
exit;
EOF
