sqlplus duhtest/duhtest <<EOF
@/home/ora112/scripts/duh/create_5_tables_script.sql
@/home/ora112/scripts/duh/insert_tables_script.sql
@/home/ora112/scripts/duh/update_tables_script.sql
@/home/ora112/scripts/duh/delete_tables_script.sql
@/home/ora112/scripts/duh/drop_tables_script.sql
EOF
