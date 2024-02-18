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


backups.conf.5 bckseldaily.exclude.5 bckseldaily.files.5 bckweekly.exclude.5 \
	bckdaily.exclude.5 bcksystem.exclude.5: Makefile
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

backups.conf.5: $(srcdir)/backups.conf.5.man.in
bckseldaily.exclude.5: $(srcdir)/bckseldaily.exclude.5.man.in
bckseldaily.files.5: $(srcdir)/bckseldaily.files.5.man.in
bckweekly.exclude.5: $(srcdir)/bckweekly.exclude.5.man.in
bckdaily.exclude.5: $(srcdir)/bckdaily.exclude.5.man.in
bcksystem.exclude.5: $(srcdir)/bcksystem.exclude.5.man.in

man_MANS = backups.conf.5 bckseldaily.exclude.5 bckseldaily.files.5 \
	bckweekly.exclude.5 bckdaily.exclude.5 bcksystem.exclude.5

EXTRA_DIST = $(srcdir)/backups.conf.5.man.in \
	$(srcdir)/bckseldaily.exclude.5.man.in \
	$(srcdir)/bckseldaily.files.5.man.in \
	$(srcdir)/bckweekly.exclude.5.man.in \
	$(srcdir)/bckdaily.exclude.5.man.in $(srcdir)/bcksystem.exclude.5.man.in

CLEANFILES = *.tmp backups.conf.5 bckseldaily.exclude.5 bckseldaily.files.5 \
	bckweekly.exclude.5 bckdaily.exclude.5 bcksystem.exclude.5
