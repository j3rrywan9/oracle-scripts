# Database Administrator Authentication

## 12c Release 1

As a DBA, you often perform special operations such as shutting down or starting up a database.
Because only a DBA should perform these operations, the database administrator user names require a secure authentication scheme.

### Administrative Privileges

Administrative privileges that are required for an administrator to perform basic database operations are granted through special system privileges.

These privileges are:
- **SYSDBA**
- **SYSOPER**
- **SYSDG**
- **SYSKM**
- **SYSBACKUP**

You must have one of these privileges granted to you, depending upon the level of authorization you require.

Starting with Oracle Database 12c, the **SYSBACKUP**, **SYSDG**, and **SYSKM** administrative privileges are available.
Each new administrative privilege grants the minimum required privileges to complete tasks in each area of administration.
The new administrative privileges enable you to avoid granting **SYSDBA** administrative privilege for many common tasks.

### Operations Authorized by Administrative Privileges

Each administrative privilege authorizes a specific set of operations.

### Authentication Methods for Database Administrators

Database administrators can be authenticated with account passwords, operating system (OS) authentication, password files, or strong authentication with a directory-based authentication service, such as Oracle Internet Directory.

### Using Operating System Authentication

### Using Password File Authentication

You can use password file authentication for an Oracle database instance and for an Oracle Automatic Storage Management (Oracle ASM) instance.
The password file for an Oracle database is called a database password file, and the password file for Oracle ASM is called an Oracle ASM password file.

### Creating and Maintaining a Database Password File

### Frequently Used SQL

```
SQL> create user jerry identified by jerry default tablespace users;

User created.

SQL> grant sysdba to jerry;

Grant succeeded.

sqlplus /nolog

SQL> connect jerry as sysdba
Enter password:
Connected.
```
