#########################################################################
#									#
# Script ID: ./configure.ac						#
# Author: Copyright (C) 2012-2018  Mark Grant				#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0					#
#									#
# Purpose:								#
# AutoConf script file to configure LIXBackups project.			#
#									#
# configure cmd line syntax:						#
# ./configure	[--enable-distcheckfake=<yes|no> [default: no]]		#
#									#
# --enable-distcheckfake enables the replacement of an absolute		#
# directory path specified in a variable, with a value based on		#
# AutoTools standard directories. This enables the Makefile.am to use	#
# the AT variable based value when running distcheck and the absolute	#
# path for all else. Hence distcheck can now succeed when it would 	#
# normally fail.							#
#									#
# To use this facility run:-						#
# make distcheck DISTCHECK_CONFIGURE_FLAGS=--enable-distcheckfake=yes	#
#									#
#########################################################################

#########################################################################
#									#
# Changelog								#
#									#
# Date		Author	Version	Description				#
#									#
# 16/06/2014	MG	1.0.1	Started versioning of this script.	#
# 26/06/2014	MG	1.0.2	Use 'git describe --always' for AC_INIT	#
#				version as it returns a value as long	#
#				as there is at least 1 commit, even	#
#				with no tags. If no commits then	#
#				'Pre-Release' is used.			#
# 01/08/2014	MG	1.0.3	Change project name from IXBackups to	#
#				LUXBackups.				#
# 24/09/2014	MG	1.0.4	Added check for awk due to netbckup.	#
# 04/10/2014	MG	1.0.5	Change package name to lixbackups.	#
# 21/11/2014	MG	1.0.6	Re-structure to cope with OS		#
#				differences. Add check for GNU getopt.	#
#				Add check for mailx.			#
# 22/11/2014	MG	1.0.7	Add support for passing overall package	#
#				version to Makefiles.			#
# 29/11/2014	MG	1.0.8	Remove redundant hashpling.		#
# 03/02/2015	MG	1.0.9	Remove BSD support.			#
# 26/02/2015	MG	1.0.10	Add check for logger which is in the	#
#				bsdutils package.			#
# 27/02/2015	MG	1.0.11	Add rootconffiles as a sub-directory.	#
# 25/06/2015	MG	1.0.12	Increase checking for required commands.#
# 28/09/2015	MG	1.0.13	Change to conform to AutoTools Template	#
#				version 1.0.4.				#
# 05/10/2015	MG	1.0.14	Add support for fixed root-based target	#
#				paths whilst supporting distcheck.	#
# 19/10/2015	MG	1.0.15	Restructure to conform to AutoTools	#
#				General Template v1.0.5.		#
# 01/05/2017	MG	1.0.16	Move command man pages to section 8.	#
#				Make AC_INIT and pkgversion AC_SUBST	#
#				multi-line.				#
#				Fully populate sed substitution		#
#				variable.				#
#				Adopt standard --enable-distcheckfake.	#
#				Move logrotate to new subdir logrotate.	#
# 19/06/2017	MG	1.0.17	Ensure the 80 column rule is respected.	#
# 30/11/2017	MG	1.0.18	Add SPDX license tags to source files.	#
# 10/02/2018	MG	1.0.19	Shorten directory names to reduce	#
#				overall path length.			#
#				Update minimum AutoTools version.	#
#									#
#########################################################################

AC_REVISION([$Revision: 1.0.19 $])

AC_PREREQ([2.69])


########################
#
# The following two macros use git to provide versioning information.
# If git is not initialised or no commit has been made, then 'Pre-Release'
# will be used.
# If no Tag has been created then just a commit identifier will be used.
# If a tag has been created then the most recent tag, plus number of commits
# since the tag, plus a commit identifier will be used.
#
########################

AC_INIT([Linux / Unix (LIX) Backup Scripts], m4_esyscmd([ \
	git describe --always 1>/dev/null 2>/dev/null \
	&& git describe --always | tr -d '\n' \
	|| echo 'Pre-Release' | tr -d '\n']),
	[m.grant.prg@gmail.com], [lixbackups])

AC_SUBST([pkgversion], [m4_esyscmd([ \
	git describe --always 1>/dev/null 2>/dev/null \
	&& git describe --always | tr -d '\n' \
	|| echo 'Pre-Release' | tr -d '\n'])])


########################
#
# If a file location has to be fixed, e.g. /etc/foo.conf and never
# /usr/local/etc/foo.conf, then make distcheck will fail. Setting this flag
# allows make distcheck to locate the file in an AT standard directory-based
# location.
# eg /usr/local/etc/foo.conf.
# and hence succeed.
#
########################

AC_ARG_ENABLE([distcheckfake],
	[  --enable-distcheckfake    Enable running of distcheck],
	[case "${enableval}" in
		yes) distcheckfake=true ;;
		no)  distcheckfake=false ;;
		*) AC_MSG_ERROR([bad value ${enableval} for \
			--enable-distcheckfake]) ;;
	esac],[distcheckfake=false])
AM_CONDITIONAL([DISTCHECKFAKE], [test x$distcheckfake = xtrue])

if test "x${distcheckfake}" = xtrue; then
	AC_SUBST([logrotateloc], ["$sysconfdir/logrotate.d"])
	AC_MSG_NOTICE([Using substitute paths to facilitate distcheck.])
else
	AC_SUBST([logrotateloc], ["/etc/logrotate.d"])
	AC_MSG_NOTICE([Using distcheck incompatible absolute based paths.])
fi


########################
#
# Now set up a sed sequence to substitute bookmarks in script files with either
# standard GNU Directory Variables, or with programmer-defined variables set up
# using an AC_SUBST macro above. This sed sequence will be invoked at programmer
# discretion at sub-directory Makefile.am level.
# ----------------------
#
# prefix	/usr/local (typically)
#	exec_prefix	${prefix}
#		bindir	${exec_prefix}/bin	user executables
#		sbindir	${exec_prefix}/sbin	system admin executables
#		libexecdir	${exec_prefix}/libexec	program executables
#		libdir	${exec_prefix}/lib	object code libraries
#	sysconfdir	 ${prefix}/etc	read-only single-machine data
#	sharedstatedir	${prefix}/com	modifiable architecture-independent data
#	localstatedir	${prefix}/var	modifiable single-machine data
#	runstatedir	${localstatedir}/run
#	includedir	${prefix}/include	C header files
#	oldincludedir	$usr/include	C header files
#	datarootdir	${prefix}/share	read-only arch.-independent data root
#		localedir	${datarootdir}/locale	locale-dependent data
#		datadir	${datarootdir}	read-only architecture-independent data
#		mandir	${datarootdir}/man	man documentation
#		infodir	${datarootdir}/info	info documentation
#		docdir	${datarootdir}/doc/${PACKAGE}	documentation root
#			htmldir	${docdir}	html documentation
#			dvidir	${docdir}	dvi documentation
#			pdfdir	${docdir}	pdf documentation
#			psdir	${docdir}	ps documentation
#		lispdir	${datarootdir}/emacs/site-lisp
#	pkgdatadir	${datarootdir}/${PACKAGE}
#	pkgincludedir	${includedir}/${PACKAGE}
#	pkglibdir	${libdir}/${PACKAGE}
#	pkglibexecdir	${libexecdir}/${PACKAGE}
#
########################

AC_SUBST([edit], ["sed \
		-e 's|@logrotateloc[@]|\$(logrotateloc)|g' \
		-e 's|@pkgversion[@]|\$(pkgversion)|g' \
		-e 's|@prefix[@]|\$(prefix)|g' \
		-e 's|@exec_prefix[@]|\$(exec_prefix)|g' \
		-e 's|@bindir[@]|\$(bindir)|g' \
		-e 's|@sbindir[@]|\$(sbindir)|g' \
		-e 's|@libexecdir[@]|\$(libexecdir)|g' \
		-e 's|@libdir[@]|\$(libdir)|g' \
		-e 's|@sysconfdir[@]|\$(sysconfdir)|g' \
		-e 's|@sharedstatedir[@]|\$(sharedstatedir)|g' \
		-e 's|@localstatedir[@]|\$(localstatedir)|g' \
		-e 's|@runstatedir[@]|\$(runstatedir)|g' \
		-e 's|@includedir[@]|\$(includedir)|g' \
		-e 's|@oldincludedir[@]|\$(oldincludedir)|g' \
		-e 's|@datarootdir[@]|\$(datarootdir)|g' \
		-e 's|@localedir[@]|\$(localedir)|g' \
		-e 's|@datadir[@]|\$(datadir)|g' \
		-e 's|@mandir[@]|\$(mandir)|g' \
		-e 's|@infodir[@]|\$(infodir)|g' \
		-e 's|@docdir[@]|\$(docdir)|g' \
		-e 's|@htmldir[@]|\$(htmldir)|g' \
		-e 's|@dvidir[@]|\$(dvidir)|g' \
		-e 's|@pdfdir[@]|\$(pdfdir)|g' \
		-e 's|@psdir[@]|\$(psdir)|g' \
		-e 's|@lispdir[@]|\$(lispdir)|g' \
		-e 's|@pkgdatadir[@]|\$(pkgdatadir)|g' \
		-e 's|@pkgincludedir[@]|\$(pkgincludedir)|g' \
		-e 's|@pkglibdir[@]|\$(pkglibdir)|g' \
		-e 's|@pkglibexecdir[@]|\$(pkglibexecdir)|g'"])


# Passes the options to all am files. Puts objects in the sub-directory
# containing the source.
AM_INIT_AUTOMAKE([-Wall -Werror subdir-objects])


########################
#
# Standard macros will be automatically placed in m4.
# Programmer defined macros should be placed in, say, m4extra which allows us
# to exclude the standard macros from being git tracked. This other directory
# must be specified as an include option in the Makefile.am ACLOCAL_AMFLAGS
#
########################

AC_CONFIG_MACRO_DIR([m4])


########################
#
# Checks for programs.
# install, mkdir and gawk are checked by AM_INIT_AUTOMAKE.
# grep, egrep and ranlib are also automatically checked.
# Particular and generic program checks follow:
#
########################

AC_MSG_NOTICE([checking for particular programs required by this application])
AC_PROG_SED

AC_MSG_NOTICE([checking for generic programs required by this application])
AC_CHECK_PROG([TAR], [tar], [yes], [no])
if test "x$TAR" = "xno" ; then
	AC_MSG_ERROR([tar not found])
fi

AC_CHECK_PROG([GETOPT], [getopt], [yes], [no])
if test "x$GETOPT" = "xno" ; then
	AC_MSG_ERROR([getopt not found])
fi

AC_CHECK_PROG([BASH], [bash], [yes], [no])
if test "x$BASH" = "xno" ; then
   	AC_MSG_ERROR([bash not found])
fi

AC_CHECK_PROG([TXT2MAN], [txt2man], [yes], [no])
if test "x$TXT2MAN" = "xno" ; then
   	AC_MSG_ERROR([txt2man not found])
fi

AC_CHECK_PROG([TXT2MANWRAP], [txt2manwrap], [yes], [no])
if test "x$TXT2MANWRAP" = "xno" ; then
   	AC_MSG_ERROR([txt2manwrap not found])
fi

AC_CHECK_PROG([MAILX], [mailx], [yes], [no])
if test "x$MAILX" = "xno" ; then
   	AC_MSG_ERROR([mailx not found])
fi

AC_CHECK_PROG([LOGGER], [logger], [yes], [no])
if test "x$LOGGER" = "xno" ; then
   	AC_MSG_ERROR([logger not found])
fi

AC_CHECK_PROG(MOUNT, mount, yes, no)
if test "x$MOUNT" = "xno" ; then
   	AC_MSG_ERROR([mount not found])
fi

AC_CHECK_PROG(LSOF, lsof, yes, no)
if test "x$LSOF" = "xno" ; then
   	AC_MSG_ERROR([lsof not found])
fi

AC_CHECK_PROG(PASSWD, passwd, yes, no)
if test "x$PASSWD" = "xno" ; then
   	AC_MSG_ERROR([passwd not found])
fi

AC_CHECK_PROG(FIND, find, yes, no)
if test "x$FIND" = "xno" ; then
   	AC_MSG_ERROR([find not found])
fi

AC_CHECK_PROG(DF, df, yes, no)
if test "x$DF" = "xno" ; then
   	AC_MSG_ERROR([df not found])
fi

# Checks for libraries.

# Checks for C header files.

# Checks for C++ header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

# Checks for pkg-config files.

# Project Makefiles to create.
AC_CONFIG_FILES([Makefile
		src/prg/bash/Makefile
		src/man/5/Makefile
		src/man/8/Makefile
		src/conf/etc/Makefile
		src/conf/rootetc/logrotate/Makefile])

AC_OUTPUT
