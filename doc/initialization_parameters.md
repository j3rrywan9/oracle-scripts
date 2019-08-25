# Initialization Parameters

## 12c Release 1

### About Initialization Parameters and Initialization Parameter Files

When an Oracle instance starts, it reads initialization parameters from an initialization parameter file.
For any initialization parameters not specifically included in the initialization parameter file, the database supplies defaults.

The initialization parameter file can be either a read-only text file, or a read/write binary file.
The binary file is called a **server parameter file**.
A server parameter file enables you to change initialization parameters with **ALTER SYSTEM** commands and to persist the changes across a shutdown and startup.
It also provides a basis for self-tuning by Oracle Database.
For these reasons, it is recommended that you use a server parameter file.
You can create one manually from your edited text initialization file, or automatically by using Database Configuration Assistant (DBCA) to create your database.

Before you manually create a server parameter file, you can start an instance with a text initialization parameter file.
Upon startup, the Oracle instance first searches for a server parameter file in a default location, and if it does not find one, searches for a text initialization parameter file.
You can also override an existing server parameter file by naming a text initialization parameter file as an argument of the **STARTUP** command.
