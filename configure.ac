##########################################################################
##									##
## Script ID: ./configure.ac						##
## Author: Mark Grant							##
##									##
## Purpose:								##
## AutoConf script file to configure LIXBackups project.		##
##									##
## configure cmd line syntax: ./configure [--enable-distchk]		##
##	--enable-distchk utilises a substitute target file path for	##
##	targets normally defined from /. This is really only useful	##
##	when running make distcheck as it fails with these paths.	##
##	To use this facility run:-					##
##	make distcheck DISTCHECK_CONFIGURE_FLAGS=--enable-distchk	##
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
## 27/02/2015	MG	1.0.11	Add rootconffiles as a sub-directory.	##
## 25/06/2015	MG	1.0.12	Increase checking for required commands.##
## 28/09/2015	MG	1.0.13	Change to conform to AutoTools Template	##
##				version 1.0.4.				##
## 05/10/2015	MG	1.0.14	Add support for fixed root-based target	##
##				paths whilst supporting distcheck.	##
## 19/10/2015	MG	1.0.15	Restructure to conform to AutoTools	##
##				General Template v1.0.5.		##
##									##
##########################################################################

AC_REVISION([$Revision: 1.0.15 $])

AC_PREREQ([2.65])


#########################
##
## The following two macros use git to provide versioning information.
## If git is not initialised or no commit has been made, then 'Pre-Release'
## will be used.
## If no Tag has been created then just a commit identifier will be used.
## If a tag has been created then the most recent tag, plus number of commits
## since the tag, plus a commit identifier will be used.
##
#########################

AC_INIT([Linux / Unix (LIX) Backup Scripts], m4_esyscmd([git describe --always 1>/dev/null 2>/dev/null && git describe --always | tr -d '\n' || echo 'Pre-Release' | tr -d '\n']), [m.grant.prg@gmail.com], [lixbackups])

AC_SUBST([pkgversion], [m4_esyscmd([git describe --always 1>/dev/null 2>/dev/null \
		&& git describe --always | tr -d '\n' \
		|| echo 'Pre-Release' | tr -d '\n'])])


#########################
##
## The following takes the presence / absence of a configure command line argument
## and sets a conditional for later Makefile use. The target install path variable
## is set here as conditional setting of these targets is not allowed in an AutoMake file.
##
#########################

AC_ARG_ENABLE([distchk],
	[  --enable-distchk    Enable running of distcheck],
	[case "${enableval}" in
		yes) distchk=true ;;
		no)  distchk=false ;;
		*) AC_MSG_ERROR([bad value ${enableval} for --enable-distchk]) ;;
	esac],[distchk=false])
AM_CONDITIONAL([DISTCHK], [test x$distchk = xtrue])

if test "x${distchk}" = xtrue; then
	AC_SUBST([rootconfloc], ["$sysconfdir/logrotate.d"])
	AC_MSG_NOTICE([Using substitute paths to facilitate distcheck.])
else
	AC_SUBST([rootconfloc], ["/etc/logrotate.d"])
	AC_MSG_NOTICE([Using distcheck incompatible root based paths.])
fi


#########################
##
## Now set up a sed sequence to substitute bookmarks in script files with either
## standard GNU Directory Variables, or with programmer-defined variables set up
## using an AC_SUBST macro above. This sed sequence will be invoked at programmer
## discretion at sub-directory Makefile.am level.
## ------------------------------------
##
## prefix	/usr/local (typically)
##	exec_prefix	${prefix}
##		bindir	${exec_prefix}/bin	user executables
##		sbindir	${exec_prefix}/sbin	system admin executables
##		libexecdir	${exec_prefix}/libexec	program executables
##		libdir	${exec_prefix}/lib	object code libraries
##	sysconfdir	 ${prefix}/etc	read-only single-machine data
##	sharedstatedir	${prefix}/com	modifiable architecture-independent data
##	localstatedir	${prefix}/var	modifiable single-machine data
##	runstatedir	${localstatedir}/run
##	includedir	${prefix}/include	C header files
##	oldincludedir	$usr/include	C header files
##	datarootdir	${prefix}/share	read-only arch.-independent data root
##		localedir	${datarootdir}/locale	locale-dependent data
##		datadir	${datarootdir}	read-only architecture-independent data
##		mandir	${datarootdir}/man	man documentation
##		infodir	${datarootdir}/info	info documentation
##		docdir	${datarootdir}/doc/${PACKAGE}	documentation root
##			htmldir	${docdir}	html documentation
##			dvidir	${docdir}	dvi documentation
##			pdfdir	${docdir}	pdf documentation
##			psdir	${docdir}	ps documentation
##		lispdir	${datarootdir}/emacs/site-lisp
##	pkgdatadir	${datarootdir}/${PACKAGE}
##	pkgincludedir	${includedir}/${PACKAGE}
##	pkglibdir	${libdir}/${PACKAGE}
##	pkglibexecdir	${libexecdir}/${PACKAGE}
##
#########################

AC_SUBST([edit], ["sed \
		-e 's|@bindir[@]|\$(bindir)|g' \
		-e 's|@pkgdatadir[@]|\$(pkgdatadir)|g' \
		-e 's|@sysconfdir[@]|\$(sysconfdir)|g' \
		-e 's|@prefix[@]|\$(prefix)|g' \
		-e 's|@pkgversion[@]|\$(pkgversion)|g' \
		-e 's|@localstatedir[@]|\$(localstatedir)|g'"])

AM_INIT_AUTOMAKE


#########################
##
## Checks for programs.
## install, mkdir and gawk are checked by AM_INIT_AUTOMAKE.
## grep, egrep and ranlib are also automatically checked.
## Particular and generic program checks follow:
##
#########################

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
		source/progs/bash/Makefile
		source/man/man1/Makefile
		source/man/man5/Makefile
		source/conf/etc/Makefile
		source/conf/rootetc/Makefile])

AC_OUTPUT

