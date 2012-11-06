#! /usr/bin/env bash
##########################################################################
##									##
##	attbckshare.sh is automatically generated,			##
##		please do not modify!					##
##									##
##########################################################################

##########################################################################
##									##
## Script ID: attbckshare.sh						##
## Author: Mark Grant							##
##									##
## Purpose:								##
## To mount the backup share on the NAS server. E.g.			##
## 	\\Ambrosia\charybdisbck						##
## 	on								##
## 	/mnt/charybdisbck						##
##									##
## Syntax:	attbckshare.sh [-h || --help || -v || --version]	##
##									##
## Exit Codes:	0 & 64 - 113 as per C/C++ standard			##
##		0 - success						##
##		64 - Invalid arguments					##
##		65 - Failed mounting backup NAS server			##
##		66 - Backcup share already mounted			##
##		67 - trap received					##
##									##
## Further Info:							##
## This script mounts a NAS share as a target for the backup scripts.	##
##									##
## In order to make the package portable all the necessary parameters	##
## are stored in a $PREFIX/etc/backups.conf file.			##
## On FreeBSD mounting a NAS share uses the mount_smbfs command rather	##
## than the mount.cifs command on Linux. This difference means that on	##
## FreeBSD we also utilise the ~/.nsmbrc file.				##
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
## 09/04/2010	MG	1.0.1	Created for Linux.			##
## 26/08/2010	MG	1.0.2	Major revision completed supporting	##
##				FreeBSD as well as Linux. Also put all	##
##				relevant parameters in variables at	##
##				beginning of script to enhance		##
##				portability. (e.g. System, backup user	##
##				etc.).					##
## 18/11/2010	MG	1.0.3	Changed to emit help and version on	##
##				input of correct flag as argument. Also	##
##				stored version in string in Init section##
## 28/11/2010	MG	1.0.4	Changed script to read parameters from	##
##				etclocation/backups.conf and, when	##
##				necessary (FreeBSD), the ~/.nsmbrc file.##
## 10/01/2012	MG	1.0.5	Removed the .sh extension from the	##
##				command name.				##
## 05/11/2012	MG	1.0.6	Reverted to the .sh file extension.	##
##									##
##########################################################################

####################
## Init variables ##
####################
script_exit_code=0
osname=$(uname -s)		# Get system name for OS differentiation
version="1.0.6"			# set version variable
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
# Command line must have 1 or no arguments
if [ $# -gt 1 ]
	then
		echo "Script can only take 1 argument. Try --help."
		exit 64
fi

if [ $# = 1 ]; then
	case $1 in
		-h|-H)
			echo "Usage is attbckshare.sh [options]"
			echo "	-h or --help displays usage information"
			echo "	OR"
			echo "	-v or --version displays version information"
			;;
		--help|--HELP)
			echo "Usage is attbckshare.sh [options]"
			echo "	-h or --help displays usage information"
			echo "	OR"
			echo "	-v or --version displays version information"
			;;
		-v|-V)
			echo "attbckshare.sh version "$version
			;;
		--version|--VERSION)
			echo "attbckshare.sh version "$version
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
	server)
		bckupsys=${input[1]}
		;;
	dir)
		bckupdir=${input[1]}
		;;
	user)
		bckupusr=${input[1]}
		;;
	password)
		bckuppwd=${input[1]}
		;;
	esac
done
exec 3<&-

# If FreeBSD we also need the workgroup which can be obtained from
# the ~/.nsmbrc file

if [ $osname = "FreeBSD" ]; then
	exec 3<~/.nsmbrc
	while read -u3 -ra input
	do
		case ${input[0]} in
		workgroup)
			bckupwg=${input[1]}
			;;
		esac
	done
	exec 3<&-
fi

# Check to see if the NAS backup server is mounted, if not, mount
if [ "$(mount | grep "/mnt/$bckupdir")" == "" ] 
	then
	case $osname in
	FreeBSD)
		mount_smbfs -I $bckupsys -N -U $bckupusr -W $bckupwg \
        		//$bckupusr@$bckupsys/$bckupdir /mnt/$bckupdir
		status=$?
	;;
	Linux)
	mount -t cifs -o user=$bckupusr,password=$bckuppwd \
        	//$bckupsys/$bckupdir /mnt/$bckupdir
	status=$?
	;;
	esac
	if [ $status != "0" ]
		then
		script_exit_code=65
		script_exit "Failed to mount backup NAS server. Mount error: "$status" Script exit code: "$script_exit_code
	fi
	else
	script_exit_code=66
	script_exit "Backup share already mounted. Script exit code: "$script_exit_code
fi
exit 0
