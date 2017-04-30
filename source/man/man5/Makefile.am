#! /usr/bin/env bash
#########################################################################
#									#
# Script ID: source/man/man5/Makefile.am				#
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
# 17/06/2014	MG	1.0.1	Started versioning of this script.	#
# 01/08/2014	MG	1.0.2	Change project name from IXBackups to	#
#				LUXBackups.				#
# 25/09/2014	MG	1.0.3	Update to reflect file name changes.	#
# 28/09/2015	MG	1.0.4	Change to conform to AutoTools Template	#
#				version 1.0.4.				#
# 19/10/2015	MG	1.0.5	Restructure to conform to AutoTools	#
#				General Template v1.0.5.		#
#									#
#########################################################################


backups.conf.5 bckseldaily.exclude.5 bckseldaily.files.5 bckweekly.exclude.5 \
	bckdaily.exclude.5 bcksystem.exclude.5: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	$(edit) $(srcdir)/$(@F).txt > $@.tmp
	mv $@.tmp $@
	txt2manwrap $(@F) 5 "Backup Scripts Manual" $(srcdir)/$(@F).txt $@
	rm -f $@.tmp

backups.conf.5: $(srcdir)/backups.conf.5.txt
bckseldaily.exclude.5: $(srcdir)/bckseldaily.exclude.5.txt
bckseldaily.files.5: $(srcdir)/bckseldaily.files.5.txt
bckweekly.exclude.5: $(srcdir)/bckweekly.exclude.5.txt
bckdaily.exclude.5: $(srcdir)/bckdaily.exclude.5.txt
bcksystem.exclude.5: $(srcdir)/bcksystem.exclude.5.txt

man_MANS = backups.conf.5 bckseldaily.exclude.5 bckseldaily.files.5 \
	bckweekly.exclude.5 bckdaily.exclude.5 bcksystem.exclude.5

EXTRA_DIST = $(srcdir)/backups.conf.5.txt $(srcdir)/bckseldaily.exclude.5.txt \
	$(srcdir)/bckseldaily.files.5.txt $(srcdir)/bckweekly.exclude.5.txt \
	$(srcdir)/bckdaily.exclude.5.txt $(srcdir)/bcksystem.exclude.5.txt

CLEANFILES = *.tmp backups.conf.5 bckseldaily.exclude.5 bckseldaily.files.5 \
	bckweekly.exclude.5 bckdaily.exclude.5 bcksystem.exclude.5
