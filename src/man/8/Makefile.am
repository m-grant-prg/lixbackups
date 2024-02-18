#########################################################################
#									#
# Author: Copyright (C) 2012-2019, 2021, 2024  Mark Grant		#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
#									#
# Purpose:								#
# AutoMake script file to generate LIXBackup manual pages from source.	#
#									#
#########################################################################


attbckshare.8 detbckshare.8 chkbckshare.8 netbckup.8: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	$(edit) $(srcdir)/$(@F).man.in > $@.tmp
	targfile=$(@F);	\
	if [[ $$targfile == *"."* ]]; then \
		if [[ $${targfile##*.} == "" ]]; then \
			echo "Source file suffix used as section but empty."; \
			exit 1; \
		else \
			section=$${targfile##*.}; \
		fi; \
	else \
		echo "Source file suffix used as section but no dot & empty."; \
		exit 1; \
	fi; \
	txt2manwrap $(@F) $$section "Backup Scripts Manual" $@.tmp $@
	rm -f $@.tmp

attbckshare.8: $(srcdir)/attbckshare.8.man.in
detbckshare.8: $(srcdir)/detbckshare.8.man.in
chkbckshare.8: $(srcdir)/chkbckshare.8.man.in
netbckup.8: $(srcdir)/netbckup.8.man.in

man_MANS = attbckshare.8 detbckshare.8 chkbckshare.8 netbckup.8

EXTRA_DIST = $(srcdir)/attbckshare.8.man.in $(srcdir)/detbckshare.8.man.in \
		$(srcdir)/chkbckshare.8.man.in $(srcdir)/netbckup.8.man.in

CLEANFILES = *.tmp attbckshare.8 detbckshare.8 chkbckshare.8 netbckup.8
