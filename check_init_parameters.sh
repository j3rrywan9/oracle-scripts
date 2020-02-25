sqlplus -S / as sysdba <<EOF
show parameter audit_file_dest
show parameter control_files
show parameter db_recovery_file_dest
show parameter local_listener
show parameter log_archive_dest
show parameter log_archive_format
show parameter pga_aggregate_target
show parameter sga_target
EOF
