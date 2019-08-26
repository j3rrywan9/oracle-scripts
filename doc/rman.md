# RMAN

## 12c Release 1

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
