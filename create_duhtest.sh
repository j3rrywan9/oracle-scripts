sqlplus '/as sysdba' <<EOF
@$ORACLE_HOME/rdbms/admin/dbmsrand.sql
drop user duhtest cascade;
create user duhtest identified by duhtest default tablespace users temporary tablespace temp;
grant dba,connect,resource to duhtest;
conn duhtest/duhtest
exit;
EOF
