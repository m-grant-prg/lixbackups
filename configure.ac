#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: ./configure.ac						##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Autoconfigure script file to configure LIXBackups project.		##
##									##
##########################################################################

##########################################################################
##									##
## Changelog								##
##									##
## Date		Author	Version	Description				##
##									##
## 16/06/2014	MG	1.0.1	Started versioning of this script.	##
## 26/06/2014	MG	1.0.2	Use 'git describe --always' for AC_INIT	##
##				version as it returns a value as long	##
##				as there is at least 1 commit, even	##
##				with no tags. If no commits then	##
##				'Pre-Release' is used.			##
## 01/08/2014	MG	1.0.3	Change project name from IXBackups to	##
##				LUXBackups.				##
## 24/09/2014	MG	1.0.4	Added check for awk due to netbckup.	##
## 04/10/2014	MG	1.0.5	Change package name to lixbackups.	##
## 17/11/2014	MG	1.0.6	Re-structure to cope with OS		##
##				differences. Add check for GNU getopt.	##
##									##
##########################################################################


AC_PREREQ([2.65])
AC_INIT([Linux / Unix (LIX) Backup Scripts], m4_esyscmd([git describe --always 1>/dev/null 2>/dev/null && git describe --always | tr -d '\n' || echo 'Pre-Release' | tr -d '\n']), [m.grant.prg@gmail.com], [lixbackups])

AM_INIT_AUTOMAKE

AC_CONFIG_FILES([Makefile
		 src/scripts/Makefile
		 src/manpages/man1/Makefile
		 src/manpages/man5/Makefile
		 src/conffiles/Makefile])

AC_CANONICAL_HOST

# Checks for programs.
AC_MSG_NOTICE([checking for required $host_os specific programs])
case $host_os in
	*bsd*)	AC_MSG_NOTICE([using $host_os...])
		AC_CHECK_PROG(GTAR, gtar, yes, no)
		if test "x$GTAR" = "xno" ; then
			AC_MSG_ERROR([gtar not found])
		fi
		AC_CHECK_PROG(GETOPT, getopt, yes, no, path = '/usr/local/bin')
		if test "x$GETOPT" = "xno" ; then
			AC_MSG_ERROR([getopt not found])
		fi
		;;
	# linux*)	Allow fall through for now as the defaults are linux.
	*)	AC_MSG_NOTICE([using defaults...])
		AC_CHECK_PROG(TAR, tar, yes, no)
		if test "x$TAR" = "xno" ; then
			AC_MSG_ERROR([tar not found])
		fi
		AC_CHECK_PROG(GETOPT, getopt, yes, no)
		if test "x$GETOPT" = "xno" ; then
			AC_MSG_ERROR([getopt not found])
		fi
		;;
esac

AC_MSG_NOTICE([checking for required generic programs])
AC_CHECK_PROG(BASH, bash, yes, no)
if test "x$BASH" = "xno" ; then
   	AC_MSG_ERROR([bash not found])
fi

AC_CHECK_PROG(AWK, awk, yes, no)
if test "x$AWK" = "xno" ; then
   	AC_MSG_ERROR([awk not found])
fi

AC_CHECK_PROG(TXT2MAN, txt2man, yes, no)
if test "x$TXT2MAN" = "xno" ; then
   	AC_MSG_ERROR([txt2man not found])
fi

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_OUTPUT
