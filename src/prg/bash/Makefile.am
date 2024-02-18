#########################################################################
#									#
# Author: Copyright (C) 2012-2019, 2021, 2024  Mark Grant		#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
#									#
# Purpose:								#
# AutoMake script file to generate LIXBackup scripts from source.	#
#									#
#########################################################################


attbckshare detbckshare chkbckshare netbckup: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.sh.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).sh.in > $@.tmp
	mv $@.tmp $@
	chmod a+x $@
attbckshare: $(srcdir)/attbckshare.sh.in
detbckshare: $(srcdir)/detbckshare.sh.in
chkbckshare: $(srcdir)/chkbckshare.sh.in
netbckup: $(srcdir)/netbckup.sh.in


setup.sh: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).in > $@.tmp
	mv $@.tmp $@
	chmod a+x $@
setup.sh: $(srcdir)/setup.sh.in


sbin_SCRIPTS = attbckshare detbckshare chkbckshare netbckup

pkglibexec_SCRIPTS = setup.sh


EXTRA_DIST = $(srcdir)/attbckshare.sh.in $(srcdir)/detbckshare.sh.in \
	$(srcdir)/chkbckshare.sh.in $(srcdir)/netbckup.sh.in \
	$(srcdir)/setup.sh.in

CLEANFILES = *.tmp attbckshare detbckshare chkbckshare netbckup setup.sh
