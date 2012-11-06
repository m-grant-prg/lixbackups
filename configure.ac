#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.65])
AC_INIT([Backup Scripts], [1.0.15], [m.grant.prg@gmail.com])

AM_INIT_AUTOMAKE

AC_CONFIG_FILES([Makefile
		 scripts/Makefile
		 manpages/Makefile])

# Checks for programs.

AC_CHECK_PROG(BASH, bash, yes, no)
if test "x$BASH" = "xno" ; then
   	AC_MSG_ERROR([bash not found])
fi

AC_CHECK_PROG(TAR, tar, yes, no)
if test "x$TAR" = "xno" ; then
   	AC_MSG_ERROR([tar not found])
fi

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_OUTPUT
