# Fast Recovery Area

## 12c Release 1

The Fast Recovery Area is a location in which Oracle Database can store and manage files related to backup and recovery.
It is distinct from the database area, which is a location for the current database files (data files, control files, and online redo logs).

Specify the Fast Recovery Area with the following initialization parameters:
- **DB_RECOVERY_FILE_DEST**: Location of the Fast Recovery Area.
This can be a directory, file system, or Automatic Storage Management (Oracle ASM) disk group.
In an Oracle Real Application Clusters (Oracle RAC) environment, this location must be on a cluster file system, Oracle ASM disk group, or a shared directory configured through NFS.
- **DB_RECOVERY_FILE_DEST_SIZE**: Specifies the maximum total bytes to be used by the Fast Recovery Area.
This initialization parameter must be specified before **DB_RECOVERY_FILE_DEST** is enabled.

In an Oracle RAC environment, the settings for these two parameters must be the same on all instances.

You cannot enable these parameters if you have set values for the **LOG_ARCHIVE_DEST** and **LOG_ARCHIVE_DUPLEX_DEST** parameters.
You must disable those parameters before setting up the Fast Recovery Area.
You can instead set values for the **LOG_ARCHIVE_DEST_n** parameters.

Oracle recommends using a Fast Recovery Area, because it can simplify backup and recovery operations for your database.
