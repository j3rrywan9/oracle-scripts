# ARCHIVELOG Mode

## 12c Release 1

```
SQL> startup mount

SQL> alter database archivelog;

Database altered.

SQL> alter database open;

Database altered.

SQL> select log_mode from v$database;

LOG_MODE
------------
ARCHIVELOG
```
