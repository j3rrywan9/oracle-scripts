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

### Creating and Maintaining a Database Password File
