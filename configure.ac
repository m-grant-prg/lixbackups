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
## 21/11/2014	MG	1.0.6	Re-structure to cope with OS		##
##				differences. Add check for GNU getopt.	##
##				Add check for mailx.			##
## 22/11/2014	MG	1.0.7	Add support for passing overall package	##
##				version to Makefiles.			##
## 29/11/2014	MG	1.0.8	Remove redundant hashpling.		##
## 03/02/2015	MG	1.0.9	Remove BSD support.			##
## 26/02/2015	MG	1.0.10	Add check for logger which is in the	##
##				bsdutils package.			##
##									##
##########################################################################


AC_PREREQ([2.65])
AC_INIT([Linux / Unix (LIX) Backup Scripts], m4_esyscmd([git describe --always 1>/dev/null 2>/dev/null && git describe --always | tr -d '\n' || echo 'Pre-Release' | tr -d '\n']), [m.grant.prg@gmail.com], [lixbackups])

AC_SUBST(pkgversion, m4_esyscmd([git describe --always 1>/dev/null 2>/dev/null && git describe --always | tr -d '\n' || echo 'Pre-Release' | tr -d '\n']))

AM_INIT_AUTOMAKE

AC_CONFIG_FILES([Makefile
		 src/scripts/Makefile
		 src/manpages/man1/Makefile
		 src/manpages/man5/Makefile
		 src/conffiles/Makefile])

# Checks for programs.
AC_MSG_NOTICE([checking for programs required by this application])
AC_CHECK_PROG(TAR, tar, yes, no)
if test "x$TAR" = "xno" ; then
	AC_MSG_ERROR([tar not found])
fi

AC_CHECK_PROG(GETOPT, getopt, yes, no)
if test "x$GETOPT" = "xno" ; then
	AC_MSG_ERROR([getopt not found])
fi

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

AC_CHECK_PROG(MAILX, mailx, yes, no)
if test "x$MAILX" = "xno" ; then
   	AC_MSG_ERROR([mailx not found])
fi

AC_CHECK_PROG(LOGGER, logger, yes, no)
if test "x$LOGGER" = "xno" ; then
   	AC_MSG_ERROR([logger not found])
fi

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_OUTPUT
