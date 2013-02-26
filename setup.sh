#! /usr/bin/env bash
##########################################################################
##									##
##	setup.sh is automatically generated,				##
##		please do not modify!					##
##									##
##########################################################################

##########################################################################
##									##
## Script ID: setup.sh							##
## Author: Mark Grant							##
##									##
## Purpose:								##
## To setup the config files for the Backup package.			##
##									##
## Syntax:	setup.sh [-h || --help || -v || --version]		##
##									##
## Exit Codes:	0 & 64 - 113 as per C/C++ standard			##
##		0 - success						##
##		64 - Invalid arguments					##
##		65 - File(s) already exist				##
##		67 - trap received					##
##									##
## Further Info:							##
## The backup package mounts a NAS share as a target for the backup.	##
## Something like:-							##
## 	the NAS share \\Ambrosia\charybdisbck				##
## 	mounted on							##
## 	/mnt/charybdisbck						##
## In order to make the package portable all the necessary parameters	##
## are stored in a $PREFIX/etc/backups.conf file.			##
## On FreeBSD mounting a NAS share uses the mount_smbfs command rather	##
## than the mount.cifs command on Linux. This difference means that on	##
## FreeBSD we also utilise the ~/.nsmbrc file.				##
## This script will create one or both files as necessary. It will NOT	##
## maintain the files once created, post-installation the files should	##
## be maintained by using an editor.					##
## The format of the backups.conf file is below:			##
##	# NAS server name						##
##	bckupsys=MyServer						##
##									##
##	# NAS directory for backups (also used for mount point eg	##
##	#				/mnt/$bckupdir)			##
##	bckupdir=mybackupdirectory					##
##									##
##	# NAS backup user						##
##	bckupusr=mybackupuser						##
##									##
##	# NAS backup user password					##
##	bckuppwd=mybackuppassword					##
##									##
##	# Backup workgroup						##
##	bckupwg=MyWorkgroup						##
##									##
##	# Notify user							##
##	notifyuser=root							##
##									##
## The format of the ~/.nsmbrc file is below:-				##
##	# First define a workgroup.					##
##	[default]							##
##	workgroup=MyWorkgroup						##
##									##
##	# Then define a server.						##
##	[MYSERVER]							##
##	addr=MyServer							##
##									##
##	# Then define a server / user pair.				##
##	[MYSERVER:MYBACKUPUSER]						##
##	# Use persistent password cache for user 'mybackupuser'		##
##			on system 'MyServer'.				##
##	password=mybackuppassword					##
##									##
##########################################################################

##########################################################################
##									##
## Changelog								##
##									##
## Date		Author	Version	Description				##
##									##
## 25/11/2010	MG	1.0.1	Created.				##
## 10/01/2012	MG	1.0.2	Removed the .sh extension from the	##
##				command name.				##
## 06/11/2012	MG	1.0.3	Reverted to use the .sh file extension.	##
## 26/02/2013	MG	1.0.4	Changed command line option processing	##
##				to use getopts.				##
##									##
##########################################################################

####################
## Init variables ##
####################
script_exit_code=0
osname=$(uname -s)		# Get system name for OS differentiation
version="1.0.4"			# set version variable
etclocation=/usr/local/etc	# Path to etc directory

###############
## Functions ##
###############
# Standard function to log $1 to stderr
mess_log()
{
echo $1 1>&2
}

# Standard function to message stderr, any cleanup and return exit code
script_exit()
{
mess_log "$1" 
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

if test -f ~/.nsmbrc || test -f $etclocation/backups.conf ; then
	echo "File(s) exist, they must be maintained with an editor."
	exit 65
fi

read -p "NAS server name: " bckupsys
read -p "NAS and mount backup directory: " bckupdir
read -p "NAS user profile: " bckupusr
read -p "NAS password for user profile: " bckuppwd
read -p "Workgroup name: " bckupwg
read -p "User to notify: " notifyuser

# Setup files
test -d $etclocation || mkdir -p $etclocation

# Write ~/.nsmbrc file if necessary
if [ $osname = "FreeBSD" ]; then
	echo "# First define a workgroup." >>~/.nsmbrc
	echo "[default]" >>~/.nsmbrc
	echo "workgroup="$bckupwg >>~/.nsmbrc
	echo "# Then define a server." >>~/.nsmbrc
	echo "["$bckupsys"]" \
		| sed y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ \
		>>~/.nsmbrc
	echo "addr="$bckupsys >>~/.nsmbrc
	echo "# Then define a server / user pair." >>~/.nsmbrc
	echo "["$bckupsys":"$bckupusr"]" \
		| sed y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/ \
		>>~/.nsmbrc
	echo "# Use persistent password cache for user." >>~/.nsmbrc
	echo "password="$bckuppwd >>~/.nsmbrc
fi

# Write $etclocation/backups.conf file
echo "server="$bckupsys >>$etclocation/backups.conf
echo "dir="$bckupdir >>$etclocation/backups.conf
echo "user="$bckupusr >>$etclocation/backups.conf
echo "password="$bckuppwd >>$etclocation/backups.conf
echo "notifyuser="$notifyuser >> $etclocation/backups.conf

exit 0
