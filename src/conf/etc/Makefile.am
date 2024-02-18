#########################################################################
#									#
# Author: Copyright (C) 2012-2019, 2021, 2024  Mark Grant		#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
#									#
# Purpose:								#
# AutoMake script file to install LIXBackups configuration files.	#
#									#
#########################################################################


confdir = $(sysconfdir)/lixbackups

bcksystem.exclude: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).in > $@.tmp
	mv $@.tmp $@
bcksystem.exclude: $(srcdir)/bcksystem.exclude.in

conf_DATA = bcksystem.exclude

EXTRA_DIST = $(srcdir)/bcksystem.exclude.in

CLEANFILES = *.tmp bcksystem.exclude
