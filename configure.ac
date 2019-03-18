#########################################################################
#									#
# Script ID: ./configure.ac						#
# Author: Copyright (C) 2012-2019  Mark Grant				#
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
# Layout: (Only relevant sections will exist).				#
# ChangeLog : High level ChangeLog					#
# SECTION  1: Initialisation & Setup					#
# SECTION  2: Architecture, target and host checks			#
# SECTION  3: Command line arguments					#
# SECTION  4: Compiler setup						#
# SECTION  5: Check for programs					#
# SECTION  6: Check for libraries					#
# SECTION  7: Check for header files					#
# SECTION  8: Check for types						#
# SECTION  9: Check for structures					#
# SECTION 10: Check for compiler characteristics			#
# SECTION 11: Check for library functions				#
# SECTION 12: Check for pkg-config files				#
# SECTION 13: Check for system services					#
# SECTION 14: Additional checks & variables				#
# SECTION 15: Specify the output files					#
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
#				Standardise configure.ac and macro	#
#				directory.				#
# 11/04/2018	MG	1.0.20	Change package versioning to use	#
#				hard-coded value. This is due to the	#
#				use of github which produces source	#
#				tarballs which can be used for package	#
#				generation. These tarballs are used	#
#				outside of git so git versioning is not	#
#				possible, hence the hard-coded value.	#
#				Because of this, other packaging should	#
#				probably use the source tarball rather	#
#				than a dist tarball.			#
# 09/01/2019	MG	1.0.21	Supply Makefiles with edit variable	#
#				with absolute bash path which can be	#
#				substituted in the shebang. Using env	#
#				is OK for non-AutoTools scripts.	#
#				Remove preceding v from package version	#
#				as it should not be there.		#
# 11/01/2019	MG	1.0.22	Change program check section to check	#
#				for build required, build and run	#
#				required, and, run required programs.	#
# 28/01/2019	MG	1.1.1	Revamp to new standard layout.		#
#				Add chown and chmod checks.		#
#									#
#########################################################################


#########################################
#					#
# SECTION  1: Initialisation & Setup	#
#					#
#########################################

AC_REVISION([$Revision: 1.1.1 $])

AC_PREREQ([2.69])

#
# The package version in ac init will be used to create an output variable which
# can be used by ac output and / or the sed setup below to substitute bookmarks
# in source files.
#
AC_INIT([Linux / Unix (LIX) Backup Scripts], 1.3.2,
	[m.grant.prg@gmail.com], [lixbackups])

AC_MSG_NOTICE(initialisation and setup)

AC_SUBST(pkgversion, $PACKAGE_VERSION)

#
# Passes the options to all am files. Puts objects in the sub-directory
# containing the source. Forces tar to use --format=posix in make dist.
# This also checks :-	BSD install	make variable set	mkdir -p
#			gawk
#
AM_INIT_AUTOMAKE([-Wall -Werror subdir-objects tar-pax])

#
# Standard macros will be automatically placed in m4.
# Programmer defined macros should be placed in, say, m4extra which allows us
# to exclude the standard macros from being git tracked. This other directory
# must be specified as an include option in the Makefile.am ACLOCAL_AMFLAGS
# e.g.
# ACLOCAL_AMFLAGS = -I m4 -I m4extra
#
AC_CONFIG_MACRO_DIR([m4])


#########################################
#					#
# SECTION  3: Command line arguments	#
#					#
#########################################

AC_MSG_NOTICE(processing command line arguments)

#
# If a file location has to be fixed, e.g. /etc/foo.conf and never
# /usr/local/etc/foo.conf, then make distcheck will fail. Setting this flag
# allows make distcheck to locate the file in an AT standard directory-based
# location.
# eg /usr/local/etc/foo.conf.
# and hence succeed.
#
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


#########################################
#					#
# SECTION  5: Check for programs	#
#					#
#########################################

AC_MSG_NOTICE(checking for basic programs that have AutoConf checks)

#
# The small set of tools you can expect to find on any machine.
#
# awk		date		grep		od
# basename	diff		join		rm
# cat		dirname		ln		rmdir
# cc		egrep		ls		sed
# chgrp		expr		mkdir		sleep
# chown		expr (‘|’)	mkfifo		sort
# chmod		expr (‘:’)	mknod		tar
# cmp		fgrep		mktemp		touch
# cp		find		mv		tr
#
# (For further information including limitations to the above, see Section 11.15
# in the GNU AutoConf Manual).
#
# If using am init automake, gl early or lt init the following programs are
# automatically checked:-
#
# am init automake
#	BSD install	mkdir -p	gawk
#
# gl early
#	ar	grep	egrep	ranlib
#
# lt init
#	fgrep	ranlib	sed
#
# Basic and AutoTools program checks.
#
AC_PROG_AWK
AC_PROG_EGREP
AC_PROG_FGREP
AC_PROG_GREP
AC_PROG_LN_S
AC_PROG_MKDIR_P
AC_PROG_SED

AC_MSG_NOTICE(checking for some standard AutoTools required programs)
AC_PROG_INSTALL

AC_MSG_NOTICE(checking for particular programs required by this build)
AC_CHECK_PROG(TXT2MAN, txt2man, yes, no)
if test "x$TXT2MAN" = "xno" ; then
	AC_MSG_ERROR(txt2man not found)
fi

AC_CHECK_PROG(TXT2MANWRAP, txt2manwrap, yes, no)
if test "x$TXT2MANWRAP" = "xno" ; then
	AC_MSG_ERROR(txt2manwrap not found)
fi

AC_MSG_NOTICE(checking for particular programs required at build and run time)
AC_CHECK_PROG(BASH, bash, yes, no)
if test "x$BASH" = "xno" ; then
	AC_MSG_ERROR(bash not found)
fi

AC_CHECK_PROG(TAR, tar, yes, no)
if test "x$TAR" = "xno" ; then
	AC_MSG_ERROR(tar not found)
fi

AC_MSG_NOTICE(checking for particular programs required at run time)
AC_CHECK_PROG(CHMOD, chmod, yes, no)
if test "x$CHMOD" = "xno" ; then
	AC_MSG_WARN(chmod not found - needed at run time)
fi

AC_CHECK_PROG(CHOWN, chown, yes, no)
if test "x$CHOWN" = "xno" ; then
	AC_MSG_WARN(chown not found - needed at run time)
fi

AC_CHECK_PROG(DF, df, yes, no)
if test "x$DF" = "xno" ; then
	AC_MSG_WARN(df not found - needed at run time)
fi

AC_CHECK_PROG(ECHO, echo, yes, no)
if test "x$ECHO" = "xno" ; then
	AC_MSG_WARN(echo not found - needed at run time)
fi

AC_CHECK_PROG(FIND, find, yes, no)
if test "x$FIND" = "xno" ; then
	AC_MSG_WARN(find not found - needed at run time)
fi

AC_CHECK_PROG(GETOPT, getopt, yes, no)
if test "x$GETOPT" = "xno" ; then
	AC_MSG_WARN(getopt not found - needed at run time)
fi

AC_CHECK_PROG(LOGGER, logger, yes, no)
if test "x$LOGGER" = "xno" ; then
	AC_MSG_WARN(logger not found - needed at run time)
fi

AC_CHECK_PROG(LSOF, lsof, yes, no)
if test "x$LSOF" = "xno" ; then
	AC_MSG_WARN(lsof not found - needed at run time)
fi

AC_CHECK_PROG(MAILX, mailx, yes, no)
if test "x$MAILX" = "xno" ; then
	AC_MSG_WARN(mailx not found - needed at run time)
fi

AC_CHECK_PROG(MOUNT, mount, yes, no)
if test "x$MOUNT" = "xno" ; then
	AC_MSG_WARN(mount not found - needed at run time)
fi

AC_CHECK_PROG(PASSWD, passwd, yes, no)
if test "x$PASSWD" = "xno" ; then
	AC_MSG_WARN(passwd not found - needed at run time)
fi

AC_CHECK_PROG(PRINTF, printf, yes, no)
if test "x$PRINTF" = "xno" ; then
	AC_MSG_WARN(printf not found - needed at run time)
fi


#################################################
#						#
# SECTION 14: Additional checks & variables	#
#						#
#################################################

AC_MSG_NOTICE(processing additional checks and variables)

#
# Now set up an awk sequence to substitute bookmarks in script files with either
# standard GNU Directory Variables, or with programmer-defined variables set up
# using an AC_SUBST macro above. This awk sequence will be invoked at programmer
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
#		lispdir	${datarootdir}/emacs/site-lisp **Often empty, no check**
#	pkgdatadir	${datarootdir}/${PACKAGE}
#	pkgincludedir	${includedir}/${PACKAGE}
#	pkglibdir	${libdir}/${PACKAGE}
#	pkglibexecdir	${libexecdir}/${PACKAGE}
#
AC_SUBST([edit], ["$AWK \
		'{ \
		gsub(/@bashlocation[@]/,"'"$(BASH)"'"); \
		gsub(/@logrotateloc[@]/,"'"$(logrotateloc)"'"); \
		gsub(/@pkgversion[@]/,"'"$(pkgversion)"'"); \
		gsub(/@prefix[@]/,"'"$(prefix)"'"); \
		gsub(/@exec_prefix[@]/,"'"$(exec_prefix)"'"); \
		gsub(/@bindir[@]/,"'"$(bindir)"'"); \
		gsub(/@sbindir[@]/,"'"$(sbindir)"'"); \
		gsub(/@libexecdir[@]/,"'"$(libexecdir)"'"); \
		gsub(/@libdir[@]/,"'"$(libdir)"'"); \
		gsub(/@sysconfdir[@]/,"'"$(sysconfdir)"'"); \
		gsub(/@sharedstatedir[@]/,"'"$(sharedstatedir)"'"); \
		gsub(/@localstatedir[@]/,"'"$(localstatedir)"'"); \
		gsub(/@runstatedir[@]/,"'"$(runstatedir)"'"); \
		gsub(/@includedir[@]/,"'"$(includedir)"'"); \
		gsub(/@oldincludedir[@]/,"'"$(oldincludedir)"'"); \
		gsub(/@datarootdir[@]/,"'"$(datarootdir)"'"); \
		gsub(/@localedir[@]/,"'"$(localedir)"'"); \
		gsub(/@datadir[@]/,"'"$(datadir)"'"); \
		gsub(/@mandir[@]/,"'"$(mandir)"'"); \
		gsub(/@infodir[@]/,"'"$(infodir)"'"); \
		gsub(/@docdir[@]/,"'"$(docdir)"'"); \
		gsub(/@htmldir[@]/,"'"$(htmldir)"'"); \
		gsub(/@dvidir[@]/,"'"$(dvidir)"'"); \
		gsub(/@pdfdir[@]/,"'"$(pdfdir)"'"); \
		gsub(/@psdir[@]/,"'"$(psdir)"'"); \
		gsub(/@pkgdatadir[@]/,"'"$(pkgdatadir)"'"); \
		gsub(/@pkgincludedir[@]/,"'"$(pkgincludedir)"'"); \
		gsub(/@pkglibdir[@]/,"'"$(pkglibdir)"'"); \
		gsub(/@pkglibexecdir[@]/,"'"$(pkglibexecdir)"'"); \
		print ; }'"])


#########################################
#					#
# SECTION 15: Specify the output files	#
#					#
#########################################

AC_MSG_NOTICE(processing output files)

#
# Non-Makefile files to generate.
# AC_CONFIG_FILES should not be used to substitute AutoConf Installation
# Directory Variables, (bindir and friends), except in Makefiles and pkg-config
# files. See GNU AutoConf manual section 4.8.2 Installation Directory Variables.
#

# Project Makefiles to create.
AC_CONFIG_FILES([Makefile
		src/prg/bash/Makefile
		src/man/5/Makefile
		src/man/8/Makefile
		src/conf/etc/Makefile
		src/conf/rootetc/logrotate/Makefile])

AC_OUTPUT

