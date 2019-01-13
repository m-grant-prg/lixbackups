#########################################################################
#									#
# Script ID: src/man/5/Makefile.am					#
# Author: Copyright (C) 2012-2019  Mark Grant				#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0					#
#									#
# Purpose:								#
# AutoMake script file to generate LIXBackup manual pages from source.	#
#									#
#########################################################################

#########################################################################
#									#
# Changelog								#
#									#
# Date		Author	Version	Description				#
#									#
# 17/06/2014	MG	1.0.1	Started versioning of this script.	#
# 01/08/2014	MG	1.0.2	Change project name from IXBackups to	#
#				LUXBackups.				#
# 25/09/2014	MG	1.0.3	Update to reflect file name changes.	#
# 28/09/2015	MG	1.0.4	Change to conform to AutoTools Template	#
#				version 1.0.4.				#
# 19/10/2015	MG	1.0.5	Restructure to conform to AutoTools	#
#				General Template v1.0.5.		#
# 30/04/2017	MG	1.0.6	Output from $(edit) was being ignored.	#
#				Rename source file extension .man.in	#
# 30/11/2017	MG	1.0.7	Determine the manual section from the	#
#				target suffix. If the suffix is blank	#
#				(foo.) or if there is no suffix (foo)	#
#				then error out.				#
#				Add SPDX license tags to source files.	#
# 10/02/2018	MG	1.0.8	Change file's header for new directory	#
#				names.					#
# 13/01/2019	MG	1.0.9	Remove unnecessary shebang.		#
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
