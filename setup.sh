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
## 02/03/2013	MG	1.0.5	Added the creation (touch) of		##
##				$etclocation/backup.files which is the	##
##				--files-from argument for the		##
##				bckdatadaily.sh script.			##
## 01/04/2013	MG	1.0.6	Moved config files to new backups	##
##				directory under sysconfdir. Added	##
##				exclude files for system, weekly, daily	##
##				and data.				##
## 23/12/2013	MG	1.1.1	Changed stdout & stderr message output	##
##				to use a function directing to one or	##
##				other based on a status.		##
##									##
##########################################################################

####################
## Init variables ##
####################
script_exit_code=0
outputprefix="setup.sh: "
osname=$(uname -s)			# Get system name for OS differentiation
version="1.1.1"				# set version variable
etclocation=/usr/local/etc/backups	# Path to etc directory

###############
## Functions ##
###############

# Output $1 to stdout or stderr depending on $2
output()
{
	if [ $2 = 0 ]
	then
		echo "$outputprefix$1"
	else
		echo "$outputprefix$1" 1>&2
	fi
}

# Standard function to tidy up and return exit code
script_exit()
{
	exit $script_exit_code
}

# Standard trap exit function
trap_exit()
{
script_exit_code=67
output "Script terminating due to trap received. Code: "$script_exit_code 1
script_exit
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
		script_exit_code=0
		script_exit
		;;
	v)	echo "$0 version "$version
		script_exit_code=0
		script_exit
		;;
	\?)	script_exit_code=64
		output "Invalid argument -$OPTARG." 1
		script_exit
		;;
	esac
done

if test -f ~/.nsmbrc || test -f $etclocation/backups.conf
then
	script_exit_code=65
	output "File(s) exist, they must be maintained with an editor." 1
	script_exit
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
if [ $osname = "FreeBSD" ]
then
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

# Create $etclocation/backups inclde and exclude files
touch $etclocation/bckfullweekly.exclude
touch $etclocation/bckincdaily.exclude
touch $etclocation/bckdatadaily.files
touch $etclocation/bckdatadaily.exclude

script_exit_code=0
output "Files set up." 0
script_exit
