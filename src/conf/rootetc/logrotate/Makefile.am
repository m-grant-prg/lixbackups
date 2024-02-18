#########################################################################
#									#
# Author: Copyright (C) 2012-2019, 2021, 2024  Mark Grant		#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
#									#
# Purpose:								#
# AutoMake script file to install LIXBackups logrotate.d files.		#
# Must be installed in /etc/logrotate.d as it is for use by the		#
# logrotate program.							#
#									#
#########################################################################


# logrotateloc is set in configure.ac to provide a conditional target depending
# on whether distcheck is being run.

confdir = $(logrotateloc)

lixbackups: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).in > $@.tmp
	mv $@.tmp $@
lixbackups: $(srcdir)/lixbackups.in

conf_DATA = lixbackups

EXTRA_DIST = $(srcdir)/lixbackups.in

CLEANFILES = *.tmp lixbackups
