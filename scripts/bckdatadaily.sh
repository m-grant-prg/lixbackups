#! /usr/bin/env bash
##########################################################################
##									##
##	bckdatadaily.sh is automatically generated,			##
##		please do not modify!					##
##									##
##########################################################################

##########################################################################
##									##
## Script ID: bckdatadaily.sh						##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Backs up directories and files specified in backup.files file.	##
## The timing element is expected to be delivered via cron.		##
##									##
## Syntax:	bckincdaily.sh [-h || --help || -v || --version]	##
##									##
## Exit Codes:	0 & 64 - 113 as per C/C++ standard			##
##		0 - success						##
##		64 - Invalid arguments					##
##		65 - Failed mounting backup NAS server			##
##		66 - backup.snar non-existent or inaccesssible		##
##		67 - trap received					##
##									##
##########################################################################

##########################################################################
##									##
## Changelog								##
##									##
## Date		Author	Version	Description				##
##									##
## 02/03/2013	MG	1.0.1	Created.				##
##									##
##########################################################################

exec 6>&1 7>&2 # Immediately make copies of stdout & stderr

####################
## Init variables ##
####################
script_exit_code=0
version="1.0.1"			# set version variable
etclocation=/usr/local/etc	# Path to etc directory

# Get system name for implementing OS differences
osname=$(uname -s)

###############
## Functions ##
###############
script_short_desc=$(uname -n)" "$(date +%A)" Daily Data Backup"

# Standard function to log $1 to stderr and mail to recipient
mess_log()
{
echo $1 1>&2
echo $1 | mailx -s "$script_short_desc" $mail_recipient
}

# Standard function to log and mail $1, cleanup and return exit code
script_exit()
{
mess_log "$1" 
exec 1>&6 2>&7 6>&- 7>&- # Restore stdin & stdout & close fd's 6 & 7
sleep 5
detbckshare.sh
exit $script_exit_code
}

# Standard trap exit function
trap_exit()
{
script_exit_code=67
script_exit "Script terminating due to trap received. Code: "$script_exit_code
}

# Setup trap
trap trap_exit SIGHUP SIGINT SIGTERM

##########
## Main ##
##########
# Process command line arguments with getopts.
while getopts :hv arg
do
	case $arg in
		h)	echo "Usage is $0 [options]"
			echo "	-h displays usage information"
			echo "	OR"
			echo "	-v displays version information"
			;;
		v)	echo "$0 version "$version
			;;
		\?)	echo "Invalid argument -$OPTARG." >&2
			exit 64
			;;
	esac
done

# If help or version requested then exit now.
if [ $# -gt 0 ]
	then
		exit 0
fi

# Read parameters from $etclocation/backups.conf
IFS="="

exec 3<$etclocation/backups.conf
while read -u3 -ra input
do
	case ${input[0]} in
	dir)
		bckupdir=${input[1]}
		;;
	notifyuser)
		mail_recipient=${input[1]}
		;;
	esac
done
exec 3<&-

# Build the backup file name and path
backpath="/mnt/$bckupdir/backupdata"$(date +%a)".tar.gz"

# Check to see if the NAS backup server is mounted, if not, mount
attbckshare.sh
status=$?
if [ $status != "0" -a $status != "66" ]
	then
	script_exit_code=65
	script_exit "Failed to mount backup NAS server. Mount error: "$status" Script exit code: "$script_exit_code
fi

# Re-direct stdout & stderr to backup logs and write initial entries
exec 1>> /mnt/$bckupdir/backup.log 2>> /mnt/$bckupdir/backuperror.log
echo "Attempting to process backup - "$backpath
mess_log "Attempting to process backup - "$backpath

date
date 1>&2

# If the backup file exists, delete.
# (Just in case full backup has not done this)
if [ -f $backpath -a -r $backpath -a -w $backpath ]
	then
		rm $backpath
fi

# Empty the NAS trashbox
rm /mnt/$bckupdir/trashbox/*

# Get list of sockets to exclude
find / -type s > /mnt/$bckupdir/socket_exclude

# Run the backup excluding system directories
case $osname in
FreeBSD)
	gtar -cpzf $backpath --files-from=$etclocation/backup.files \
		--exclude=lost+found --exclude=tmp --exclude=mnt \
		--exclude=media --exclude='cdro*' --exclude=dev \
		--exclude=sys --exclude='.gvfs' --exclude=proc \
		--exclude-from=/mnt/$bckupdir/socket_exclude
	status=$?
;;
Linux)
	tar -cpzf $backpath --files-from=$etclocation/backup.files \
		--exclude=lost+found --exclude=tmp --exclude=mnt \
		--exclude=media --exclude='cdro*' --exclude=dev \
		--exclude=sys --exclude='.gvfs' --exclude=proc \
		--exclude=run --exclude=var/run \
		--exclude-from=/mnt/$bckupdir/socket_exclude
	status=$?
;;
esac

# Final log entries and restore stdout & stderr
date
date 1>&2
echo "Processing of "$backpath" is complete. Status: "$status
mess_log "Processing of "$backpath" is complete. Status: "$status
##################################################################
## It is not clear why the following two lines cause everything ##
## to hang until charybdis is restarted. It is probably due to  ##
## the odd wiring relating to the kvm which powers off if	##
## charybdis or scylla are not powered up. So this only affects	##
## priam during EOD backup routines which shutdown machines on	##
## completion. So until fixed test on OS.			##
##################################################################
if [ $osname == "FreeBSD" ]
  then
  df -ah # Log disk stats
  ls -lht /mnt/$bckupdir
fi

# Mail disk stats
df -ah | mailx -s "$script_short_desc" $mail_recipient

# Mail backup file date hierarchy
ls -lht /mnt/$bckupdir | mailx -s "$script_short_desc" $mail_recipient

exec 1>&6 2>&7 6>&- 7>&- # Restore stdout & stderr & close fd's 6 & 7

# Cleanup logs so they only have 1000 lines max
tail -n 1000 /mnt/$bckupdir/backup.log > /mnt/$bckupdir/tmp.log
sleep 5
rm /mnt/$bckupdir/backup.log
sleep 5
mv /mnt/$bckupdir/tmp.log /mnt/$bckupdir/backup.log
sleep 5
tail -n 1000 /mnt/$bckupdir/backuperror.log > /mnt/$bckupdir/tmp.log
sleep 5
rm /mnt/$bckupdir/backuperror.log
sleep 5
mv /mnt/$bckupdir/tmp.log /mnt/$bckupdir/backuperror.log
sleep 5

# Unmount the backup NAS server
detbckshare.sh

# And exit
exit 0
