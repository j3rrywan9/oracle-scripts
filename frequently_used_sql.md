# Frequently Used SQL Statements

## Tablespace and Data File

```sql
create bigfile tablespace BIGTBS datafile '+DATA/snltest/bigtbs_f1.dbf' size 10M autoextend on;

drop tablespace BIGTBS including contents and datafiles;

select file_name,tablespace_name,bytes/1024/1024 as MB,status,online_status from dba_data_files;

alter tablespace NTBS add datafile '+DATA/snltest/ntbs_f2.dbf' size 20M autoextend on;

alter tablespace NTBS rename to NEWTBS;

alter tablespace NTBS read only;

alter tablespace BT datafile offline;

alter tablespace BIGTBS resize 100M;

alter tablespace BIGTBS2 begin backup;

alter tablespace BIGTBS2 end backup;

select d.tablespace_name,b.time,b.status from dba_data_files d, v$backup b where d.file_id=b.file# and b.status='ACTIVE';

alter system set db_32k_cache_size=256M;

create tablespace TBS32K blocksize 32k datafile '+DATA/db16/datafile/tbs32k_f1.dbf' size 10M autoextend on;

select tablespace_name,status,block_size/1024 as KB from dba_tablespaces;

create table table_ctas_nologging12 tablespace test_data nologging as select * from dba_objects;

create index objid_idx on table_ctas_nologging1(object_id) nologging;

select file_name,tablespace_name from dba_data_files;

select sum(bytes / (1024*1024)) "DB Size in MB" from dba_data_files;

select name,checkpoint_time,unrecoverable_time,unrecoverable_change# from v$datafile;

select file#,ts#,status,enabled,checkpoint_change#,checkpoint_time,name from v$datafile where status='RECOVER';

select * from database_properties where property_name='DEFAULT_TEMP_TABLESPACE';

select name,bytes/1024/1024 as MB from v$tempfile;

select file#,name from v$tempfile where bytes!=0;

alter tablespace TEMP add tempfile '+NEWDATA' size 100M;
```

## Online redo logs

```sql
select * from v$log;

select * from v$logfile;

select lf.group#,lf.type,lf.member,l.bytes/1024/1024 as MB from v$logfile lf,v$log l where lf.group#=l.group# order by group#;

alter database add logfile '+DATA/snltest/onlinelog/group_4.rdo' size 52428800;

alter database add logfile group 4;

alter database drop logfile group 4;

alter database clear logfile group 4;

alter database add logfile member '+DATA/snltest/onlinelog/group_3_1.rdo' to group 3;

alter database drop logfile member '+DATA/snltest/onlinelog/group_3_1.rdo';

alter database add standby logfile size 52428800;

alter database drop standby logfile group 10;

SQL> begin
  2    for i in 4 .. 32 loop
  3      execute immediate 'alter database add logfile group' || ' '  ||i;
  4    end loop;
  5  end;
  6  /

SQL> begin
  2    for i in 1 .. 64 loop
  3      execute immediate 'alter system archive log current';
  4    end loop;
  5  end;
  6  /

select thread#,status,enabled from v$thread;
```

## Archived redo logs

```sql
select name,log_mode from v$database;

select recid,name,thread#,sequence#,first_change#,next_change#,deleted,status from v$archived_log where resetlogs_id = (select resetlogs_id from v$database_incarnation where status = 'CURRENT');

select * from (select sequence#,thread#,first_time,next_time from v$archived_log order by sequence# desc) where rownum < 11;

select inst_id,thread#,sequence#,first_change#,first_time,next_change#,next_time,deleted from gv$archived_log where first_change#>12677179 and first_change#<15513401 and deleted='NO' order by sequence#;

select sequence#,to_char(first_time,'yyyy-mm-dd hh24:mi:ss'),to_char(next_time,'yyyy-mm-dd hh24:mi:ss') from v$archived_log;

select thread#,max(sequence#) from gv$archived_log where applied='YES' group by thread#;
```

## Standby

### Creating a Physical Standby Database

On primary
```sql
alter database force logging;

alter database add standby logfile size 50M;

alter system set standby_file_management=auto;

alter system set log_archive_config='DG_CONFIG=(anaheim,bell)';

create pfile='/u02/app/stage/initanaheim.ora' from spfile;
```

#### RMAN

rman target/

backup device type disk format '/u02/app/stage/DB%U' database plus archivelog;

backup device type disk format '/u02/app/stage/CF%U' current controlfile for standby;

#### Edit pfile /u02/app/stage/initanaheim.ora in VIM

```
/1,$ s/anaheim/bell/g
```

On standby
```sql
export ORACLE_SID=bell

sqlplus / as sysdba

startup nomount pfile='/u02/app/stage/initbell.ora';

create spfile='/u02/app/ora11203/product/11.2.0/db_1/dbs/spfilebell.ora' from pfile='/u02/app/stage/initbell.ora';

shutdown abort;

startup nomount;
```

#### RMAN

export ORACLE_SID=bell

rman target sys/oracle@anaheim auxiliary /

duplicate target database for standby;

#### SQL*Plus

```sql
alter system set db_file_name_convert='anaheim','bell' scope=spfile;

alter system set log_file_name_convert='anaheim','bell' scope=spfile;

alter system set standby_file_management=auto;

alter system set log_archive_max_processes=8;

alter system set log_archive_config='DG_CONFIG=(anaheim,bell)';

alter system set fal_server=anaheim;

alter system set fal_client=bell;;

alter database recover managed standby database using current logfile disconnect;
```

-- In 12.1.0.1 and onwards
alter database recover managed standby database disconnect;

alter database recover managed standby database cancel;

select db_unique_name,name,open_mode,database_role from v$database;

select process,status,thread#,sequence# from v$managed_standby;

select process,status,thread#,sequence# from v$managed_standby where process like '%MRP%';

select distinct type,database_mode,recovery_mode from v$archive_dest_status where status='VALID';

select * from v$dataguard_stats where name = 'apply lag';

select * from v$archive_gap;

#### On primary

select status,gap_status from v$archive_dest_status where dest_id=2;

### Logical Standby

#### Standby

alter database recover managed standby database cancel;

#### Primary

execute DBMS_LOGSTDBY.BUILD;

-- Standby (RAC)
alter system set cluster_database=false scope=spfile;

shutdown immediate;

startup mount exclusive;

alter database recover to logical standby fremont;

shutdown;

startup mount;

alter database open resetlogs;

alter system set cluster_database=true scope=spfile;

shutdown;

startup;

alter database start logical standby apply immediate;

srvctl add database -db corona -oraclehome /u01/app/ora12101/product/12.1.0/dbhome_1 -spfile "+DATA/corona/spfilecorona.ora" -role LOGICAL_STANDBY -startoption OPEN -dbname pomona -diskgroup "DATA,RECO"

srvctl add database -d belmont -o /u01/app/ora112/product/11.2.0/db_1 -p "+DATA/belmont/spfilebelmont.ora" -r logical_standby -s open -a "DATA,LOG"

srvctl add instance -d belmont -i belmont1 -n bbrac1

srvctl add instance -d belmont -i belmont2 -n bbrac2

srvctl start database -d belmont

-- Monitoring
select * from v$logstdby_state;

select type,status_code,status from v$logstdby_process;

-- Purging Foreign Archived Logs
execute dbms_logstdby.purge_session;

select * from dba_logmnr_purged_log;

-- Failover to a Physical Standby Database
-- Standby
select db_unique_name,name,open_mode,database_role from v$database;

select process,status,thread#,sequence# from v$managed_standby where process like '%MRP%';

alter database recover managed standby database cancel;

alter database recover managed standby database finish;

alter database activate physical standby database;

select db_unique_name,name,open_mode,database_role from v$database;

alter database open;

-- RMAN
select recid,set_stamp,set_count,backup_type,incremental_level from v$backup_set;

## Flashback Database (available since 10g)

```sql
alter system set db_recovery_file_dest_size=9G scope=both;

alter system set db_recovery_file_dest='+LOG' scope=both;

alter system set db_flashback_retention_target=1440;

alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST';

select flashback_on from v$database;

alter database flashback on;

select current_scn from v$database;

select oldest_flashback_scn,oldest_flashback_time from v$flashback_database_log;

select incarnation#,resetlogs_change#,flashback_database_allowed from v$database_incarnation;
```

## Misc

```sql
select username,account_status from dba_users;

drop user d cascade;

select sid,serial#,username,machine from v$session where username='D';

alter system kill session 'sid,serial#';

revoke select any dictionary from d;

select property_value from database_properties where property_name='DEFAULT_TEMP_TABLESPACE';

select s.sid,s.serial#,p.spid,s.username,s.program from v$session s join v$process p on p.addr=s.paddr where s.type!='BACKGROUND';
```

## Oracle 12c

```sql
select name,ispdb_modifiable from v$system_parameter where name like 'sga%';
```

## Trigger

```sql
select text from user_source where name='OPEN_PDBS' and type='TRIGGER';
```
