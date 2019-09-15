# Tablespaces

## 12c Release 1

A tablespace is a database storage unit that groups related logical structures together.
The database data files are stored in tablespaces.

### Creating Tablespaces

You create a tablespace to group related logical structures, such as tables and indexes, together.
The database data files are stored in tablespaces.

### Frequently Used SQL

```
SQL> select tablespace_name from dba_tablespaces;

TABLESPACE_NAME
------------------------------
SYSTEM
SYSAUX
UNDOTBS1
TEMP
USERS

SQL> SELECT PROPERTY_VALUE FROM DATABASE_PROPERTIES WHERE PROPERTY_NAME = 'DEFAULT_PERMANENT_TABLESPACE';

PROPERTY_VALUE
--------------------------------------------------------------------------------
USERS
```
