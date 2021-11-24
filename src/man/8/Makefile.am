#########################################################################
#									#
# Script ID: src/man/8/Makefile.am					#
# Author: Copyright (C) 2012-2019, 2021  Mark Grant			#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
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
# 16/06/2014	MG	1.0.1	Started versioning of this script.	#
# 17/06/2014	MG	1.0.2	Inserted man1 as a subdirectory of	#
#				manpages to allow for man 5 pages.	#
# 01/08/2014	MG	1.0.3	Change project name from IXBackups to	#
#				LUXBackups.				#
# 25/09/2014	MG	1.0.4	Update to reflect script consolidation	#
#				to netbckup.				#
# 01/03/2015	MG	1.0.5	Add script substitution variable for	#
#				localstatedir to allow netbckup man	#
#				page to refer to the log file location.	#
# 28/09/2015	MG	1.0.6	Change to conform to AutoTools Template	#
#				version 1.0.4.				#
# 19/10/2015	MG	1.0.7	Restructure to conform to AutoTools	#
#				General Template v1.0.5.		#
# 30/04/2017	MG	1.0.8	Output from $(edit) was being ignored.	#
#				Rename source file extension .man.in	#
#				Move to section 8.			#
# 30/11/2017	MG	1.0.9	Determine the manual section from the	#
#				target suffix. If the suffix is blank	#
#				(foo.) or if there is no suffix (foo)	#
#				then error out.				#
#				Add SPDX license tags to source files.	#
# 10/02/2018	MG	1.0.10	Change file's header for new directory	#
#				names.					#
# 13/01/2019	MG	1.0.11	Remove unnecessary shebang.		#
# 24/11/2021	MG	1.0.12	Tighten SPDX tag.			#
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
