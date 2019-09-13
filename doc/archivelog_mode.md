# ARCHIVELOG Mode

## 12c Release 1

### Changing the Database Archiving Mode

To change the archiving mode of the database, use the **ALTER DATABASE** statement with the **ARCHIVELOG** or **NOARCHIVELOG** clause.

To change the archiving mode, you must be connected to the database with administrator privileges (**AS SYSDBA**).

The following steps switch the database archiving mode from **NOARCHIVELOG** to **ARCHIVELOG**:
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

SQL> select sequence# from v$log where status = 'CURRENT';

 SEQUENCE#
----------
        10

SQL> select sequence#,first_change#,next_change#,deleted,status from v$archived_log order by sequence#;

 SEQUENCE# FIRST_CHANGE# NEXT_CHANGE# DEL S
---------- ------------- ------------ --- -
         3        951588       952629 NO  A
         4        952629       952632 NO  A
         5        952632       952635 NO  A
         6        952635       952684 NO  A
         7        952684       952702 NO  A
```
