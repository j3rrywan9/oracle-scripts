# Flashback Database

## 12c Release 1

### Overview

Oracle Flashback Database and restore points are related data protection features that enable you to rewind data back in time to correct any problems caused by logical data corruption or user errors within a designated time window.
These features provide a more efficient alternative to point-in-time recovery and does not require a backup of the database to be restored first.
The effects are similar to database point-in-time recovery (DBPITR).
Flashback Database and restore points are not only effective in traditional database recovery situations but can also be useful during database upgrades, application deployments and testing scenarios when test databases must be quickly created and re-created.
Flashback Database also provides an efficient alternative to rebuilding a failed primary database after a Data Guard failover.

### Prerequisites

Flashback Database works by undoing changes to the data files that exist at the moment that you run the command.
Note the following important prerequisites:
- The database must run in **ARCHIVELOG** mode.
- The fast recovery area must be configured to enable flashback logging.
Flashback logs are stored as Oracle-managed files in the fast recovery area and cannot be created if no fast recovery area is configured.
- You must enable flashback logging before the target time for flashback by issuing the SQL statement `ALTER DATABASE ... FLASHBACK ON`.
Query `V$DATABASE.FLASHBACK_ON` to see whether flashback logging has been enabled.

### Frequently Used SQL

```
SQL> select flashback_on from v$database;

FLASHBACK_ON
------------------
NO

SQL> show parameter DB_FLASHBACK_RETENTION_TARGET

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_flashback_retention_target        integer     1440

SQL> ALTER DATABASE FLASHBACK ON;

Database altered.

SQL> select flashback_on from v$database;

FLASHBACK_ON
------------------
YES

SQL> SELECT OLDEST_FLASHBACK_SCN, OLDEST_FLASHBACK_TIME FROM V$FLASHBACK_DATABASE_LOG;

OLDEST_FLASHBACK_SCN OLDEST_FL
-------------------- ---------
             1707228 24-AUG-19

SQL> select incarnation#, resetlogs_change#, resetlogs_id from v$database_incarnation;

INCARNATION# RESETLOGS_CHANGE# RESETLOGS_ID
------------ ----------------- ------------
           1                 1    852269927
           2           1594143    988516256
           3           1704730   1017366377
           4           1752996   1017413571

SQL> select sequence#, first_change#, next_change#, archived, deleted, status from v$archived_log where resetlogs_id = (select max(resetlogs_id) from v$database_incarnation) order by sequence#;

 SEQUENCE# FIRST_CHANGE# NEXT_CHANGE# ARC DEL S
---------- ------------- ------------ --- --- -
         1       1752996      1753831 YES YES D
         1       1752996      1753831 YES YES D
         2       1753831      1761030 YES YES D
         2       1753831      1761030 YES YES D
         3       1761030      1763691 YES YES D
         3       1761030      1763691 YES YES D

6 rows selected.
```
