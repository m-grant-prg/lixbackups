#! /usr/bin/env bash
#########################################################################
#									#
# Script ID: source/man/man1/Makefile.am				#
# Author: Mark Grant							#
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
#									#
#########################################################################


attbckshare.1 detbckshare.1 chkbckshare.1 netbckup.1: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	$(edit) $(srcdir)/$(@F).txt > $@.tmp
	txt2manwrap $(@F) 1 "Backup Scripts Manual" $@.tmp $@
	rm -f $@.tmp

attbckshare.1: $(srcdir)/attbckshare.1.txt
detbckshare.1: $(srcdir)/detbckshare.1.txt
chkbckshare.1: $(srcdir)/chkbckshare.1.txt
netbckup.1: $(srcdir)/netbckup.1.txt

man_MANS = attbckshare.1 detbckshare.1 chkbckshare.1 netbckup.1

EXTRA_DIST = $(srcdir)/attbckshare.1.txt $(srcdir)/detbckshare.1.txt \
		$(srcdir)/chkbckshare.1.txt $(srcdir)/netbckup.1.txt

CLEANFILES = *.tmp attbckshare.1 detbckshare.1 chkbckshare.1 netbckup.1
