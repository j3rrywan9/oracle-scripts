"""
Moving Oracle archive logs to another directory
"""

import sys
import os
import re
import logging
import subprocess
import optparse
import time

LOG_ARCHIVE_DEST = '/datafile/dbdhcp3/archivelog'
MV = '/bin/mv '
POLL_INTERVAL = 3

timestamp = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

def DefineOpts(parser):
    """
    Define options for the script

    :param parser: A :py:mod:`optparse` OptionParser()
    :type: :py:class:`optparse.OptionParser`

    Valid options are::

       --des_dir     The directory to place the archive logs
    """
    parser.add_option("-d", "--des_dir", action="store", type="string",
                      dest="des_dir", help="The directory in which you want "
                      "to place the archive logs.")

def get_file_logger(logger_name):
    log_file_name = re.match('(\w+)\.py', sys.argv[0]).group(1) + "_" + time.strftime("%Y%m%d%H%M%S", time.localtime()) + ".log"

    file_logger = logging.getLogger(logger_name)
    file_logger.setLevel(logging.INFO)

    file_handler = logging.FileHandler(log_file_name)
    file_handler.setFormatter(logging.Formatter("%(asctime)s [%(name)s] %(levelname)s %(message)s"))

    file_logger.addHandler(file_handler)
    print "%s log file location is:\n%s" % (logger_name, os.path.abspath(log_file_name))
    return file_logger

def move_archive_log(archive_log, des_dir):
    """
    Move archive log to destination directory
    """
    archive_log_path = os.path.join(LOG_ARCHIVE_DEST, archive_log)
    print "Moving %s to %s..." % (archive_log_path, des_dir)
    cmd = MV + archive_log_path + ' ' + des_dir
    subprocess.Popen(cmd, shell=True)

if __name__ == "__main__":
    opt_parser = optparse.OptionParser()
    DefineOpts(opt_parser)
    (options, args) = opt_parser.parse_args()

    if options.des_dir is None:
        opt_parser.print_help()
        sys.exit(1)

    logger = get_file_logger(__name__)

    logger.info('Source directory is: %s' % LOG_ARCHIVE_DEST)
    logger.info('Destination directory is: %s' % options.des_dir)
    logger.info('Poll interval is: %d' % POLL_INTERVAL)

    existing_archive_logs = []
    existing_archive_logs = dict([(f, None) for f in os.listdir(LOG_ARCHIVE_DEST)])

    while 1:
        time.sleep(POLL_INTERVAL)

        current_archive_logs = dict([(f, None) for f in os.listdir(LOG_ARCHIVE_DEST)])
        new_archive_logs = [f for f in current_archive_logs if not f in existing_archive_logs]

        if new_archive_logs:
            print timestamp
            print "Added: ", ", ".join(new_archive_logs)
            for archive_log in new_archive_logs:
                logger.info('Moving %s to %s...' % (archive_log, options.des_dir))
                move_archive_log(archive_log, options.des_dir)
        else:
            print timestamp
            print "No new archive log to move"

