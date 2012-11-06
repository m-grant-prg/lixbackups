#! /usr/bin/env bash
##########################################################################
##									##
##	bckincdaily.sh is automatically generated,			##
##		please do not modify!					##
##									##
##########################################################################

##########################################################################
##									##
## Script ID: bckincdaily.sh						##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Keeps copying the level 0 incremental file so that each day		##
## a level 1 backup is made. This effectively makes it a 		##
## differential, as opposed to incremental, backup. Runs over		##
## the entire file system. It allows for a cycle of 7 backups		##
## for daily coverage, designated by the short day form. The		##
## timing element is expected to be delivered via cron.			##
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
## 02/04/2010	MG	1.0.1	Created.				##
## 26/08/2010	MG	1.0.2	Now uses variables for some backup	##
##				information. These variables are set at	##
##				the start of the script enabling some	##
##				degree of portability.			##
## 27/08/2010	MG	1.0.3	Introduced temporary patch to avoid	##
##				FreeBSD gtar core dumping. See 'Known	##
##				problem' comment.			##
## 03/09/2010	MG	1.0.4	Upgrade to OpenSUSE 11.3 introduced	##
##				same tar core dump probem, so		##
##				introduced same temporary fix.		##
## 11/09/2010	MG	1.0.5	Changed to use gzip.			##
## 22/09/2010	MG	1.0.6	Added df command to mail and log disk	##
##				stats whilst backup share is attached.	##
## 18/11/2010	MG	1.0.7	Changed to emit help and version on	##
##				input of correct flag as argument. Also	##
##				stored version in string in Init section##
## 20/11/2010	MG	1.0.8	Removed shutdown from script. In cron	##
##				can use script.sh && shutdown		##
## 23/11/2010	MG	1.0.9	The segfault has been fixed in GNU tar	##
##				listed incremental backups, so the	##
##				temporary fix has been removed,		##
## 28/11/2010	MG	1.0.10	Changed script to read parameters from	##
##				etclocation/backups.conf.		##
## 14/12/2010	MG	1.0.11	Removed FreeBSD unsupported -B switch	##
##				from df -ah mailx command.		##
## 16/12/2010	MG	1.0.12	Allow the mailing of df -ah command	##
##				for any OS, not just FreeBSD.		##
## 10/01/2012	MG	1.0.13	Removed the .sh extension from the	##
##				command name. Add .gvfs file exclusion	##
##				to support Gnome desktops and Ubuntu.	##
## 06/11/2012	MG	1.0.14	Reverted to use the .sh file extension.	##
##				Added exclusion to tar command for /run	##
##				and /var/run following inclusion of	##
##				/run in Linux.				##
##									##
##########################################################################

exec 6>&1 7>&2 # Immediately make copies of stdout & stderr

####################
## Init variables ##
####################
script_exit_code=0
version="1.0.14"		# set version variable
etclocation=/usr/local/etc	# Path to etc directory

# Get system name for implementing OS differences
osname=$(uname -s)

###############
## Functions ##
###############
script_short_desc="Daily Incremental Backup"

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
# Command line must have 1 or no arguments
if [ $# -gt 1 ]
	then
		echo "Script can only take 1 argument. Try --help."
		exit 64
fi

if [ $# = 1 ]; then
	case $1 in
		-h|-H)
			echo "Usage is bckincdaily.sh [options]"
			echo "	-h or --help displays usage information"
			echo "	OR"
			echo "	-v or --version displays version information"
			;;
		--help|--HELP)
			echo "Usage is bckincdaily.sh [options]"
			echo "	-h or --help displays usage information"
			echo "	OR"
			echo "	-v or --version displays version information"
			;;
		-v|-V)
			echo "bckincdaily.sh version "$version
			;;
		--version|--VERSION)
			echo "bckincdaily.sh version "$version
			;;
		*)
			echo "Invalid argument. Try --help"
			exit 64
			;;
	esac
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

# Build the backup & incremental file names and paths
backpath="/mnt/$bckupdir/backup"$(date +%a)".tar.gz"
snarpath="/mnt/$bckupdir/backup"$(date +%a)".snar"

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

# If the backup or incremental files exists, delete.
# (Just in case full backup has not done this)
if [ -f $backpath -a -r $backpath -a -w $backpath ]
	then
		rm $backpath
fi

if [ -f $snarpath -a -r $snarpath -a -w $snarpath ]
	then
		rm $snarpath
fi

# Copy level 0 incremental file in order to perform a
# level 1, effective differential backup each run.
if [ -f /mnt/$bckupdir/backup.snar -a -r /mnt/$bckupdir/backup.snar \
	-a -w /mnt/$bckupdir/backup.snar ]
	then
	cp /mnt/$bckupdir/backup.snar $snarpath
	else
	echo "backup.snar does not exist or is not accessible"
	script_exit_code=66
	script_exit "backup.snar does not exist or is not accessible. Exit code "$script_exit_code
fi

# Get list of sockets to exclude
find / -type s > /mnt/$bckupdir/socket_exclude

# Run the backup excluding system directories
case $osname in
FreeBSD)
	gtar -cpzf $backpath --listed-incremental=$snarpath --exclude=proc \
		--exclude=lost+found --exclude=tmp --exclude=mnt \
		--exclude=media --exclude='cdro*' --exclude=dev \
		--exclude=sys --exclude='.gvfs' \
		--exclude-from=/mnt/$bckupdir/socket_exclude /
	status=$?
;;
Linux)
	tar -cpzf $backpath --listed-incremental=$snarpath --exclude=proc \
		--exclude=lost+found --exclude=tmp --exclude=mnt \
		--exclude=media --exclude='cdro*' --exclude=dev \
		--exclude=sys --exclude='.gvfs' \
		--exclude=run --exclude=var/run \
		--exclude-from=/mnt/$bckupdir/socket_exclude /
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
fi

# Was using the line buffered -B switch but this is not available under FreeBSD
df -ah | mailx -s "$script_short_desc" $mail_recipient # Mail disk stats

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