# ARCHIVELOG Mode

## 12c Release 1

```
SQL> startup mount

SQL> alter database archivelog;

Database altered.

SQL> alter database open;

Database altered.
```

### Frequently Used SQL

```
SQL> select log_mode from v$database;

LOG_MODE
------------
ARCHIVELOG

SQL> archive log list;
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence     10
Next log sequence to archive   12
Current log sequence           12
```
