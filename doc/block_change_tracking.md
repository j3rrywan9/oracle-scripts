# Block Change Tracking

One of the new features in Oracle Database 10g Release 1 (10.1) is "Change-Aware Incremental Backups".

## Improving Incremental Backup Performance: Change Tracking

RMAN's change tracking feature for incremental backups improves incremental backup performance by recording changed blocks in each datafile in a change tracking file.
If change tracking is enabled, RMAN uses the change tracking file to identify changed blocks for incremental backup, thus avoiding the need to scan every block in the datafile.

## References

https://docs.oracle.com/cd/B14117_01/server.101/b10750/chapter1.htm#sthref422
