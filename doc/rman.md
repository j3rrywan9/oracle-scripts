# RMAN

## 12c Release 1

### RMAN Commands

#### RMAN

##### Purpose

Use the `rman` command to start RMAN from the operating system command line.

##### Semantics

| Syntax Element | Description |
| --- | --- |
| `append` | Causes new output to be appended to the end of the message log file. If you do not specify this parameter, and if a file with the same name as the message log file exists, then RMAN overwrites it. |
| `nocatalog` | Indicates that you are using RMAN without a recovery catalog. |
| `log` filename | Specifies the file where RMAN records its output, that is, the commands that were processed and their results. RMAN displays command input at the prompt but does not display command output, which is written to the log file. By default RMAN writes its message log file to standard output. |
| `msgno` | Causes RMAN to print message numbers, that is, **RMAN-xxxx**, for the output of all commands. By default, RMAN does not print the **RMAN-xxxx** prefix. |
| `target` connetStringSpec | Specifies a connect string to the target database, for example, `target /`. |

### Frequently Used RMAN Commands

#### `show`

```
show all;

show default device type;

show snapshot controlfile name;
```

#### `list`

```
list archivelog all;

list archivelog from sequence=0 thread 1;

list archivelog from sequence=0 thread 2;
```

#### `crosscheck`

```
crosscheck backup;
```

#### delete

```
delete expired backup;

delete archivelog all;

delete archivelog until sequence=1670 thread 1;
```

#### backup

```
configure controlfile autobackup on;

backup database plus archivelog;

backup device type disk format '/u01/app/stage/DB%U' database plus archivelog;

backup device type disk format '/u01/app/stage/CF%U' current controlfile for standby;
```

##### PDB backup

```
backup pluggable database PDB1 include current controlfile;
```

#### recovery

```
restore database;

recover database;

alter database open;

restore database;

recover database until cancel;

alter database open resetlogs;
```

##### PDB recovery

```
alter pluggable database PDB1 close immediate;

restore pluggable database PDB1;

recover pluggable database PDB1;

alter pluggable database PDB1 open resetlogs;
```

#### duplicate

```
# rman target sys/oracle@chicago auxiliary /

duplicate target database for standby;

duplicate target database for standby dorecover nofilenamecheck;
```

#### validate

```
run {configure device type disk parallelism 10; backup validate database;}
```
