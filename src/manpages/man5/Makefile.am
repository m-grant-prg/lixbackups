#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/manpages/man5/Makefile.am				##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Automake script file to generate LIXBackup manual pages from source.	##
##									##
##########################################################################

##########################################################################
##									##
## Changelog								##
##									##
## Date		Author	Version	Description				##
##									##
## 17/06/2014	MG	1.0.1	Started versioning of this script.	##
## 01/08/2014	MG	1.0.2	Change project name from IXBackups to	##
##				LUXBackups.				##
## 25/09/2014	MG	1.0.3	Update to refelect file name changes.	##
##									##
##########################################################################


manpagessrcdir = $(srcdir)

../../../manpages/man5/backups.conf.5 ../../../manpages/man5/bckseldaily.exclude.5 \
	../../../manpages/man5/bckseldaily.files.5 \
	../../../manpages/man5/bckweekly.exclude.5 \
	../../../manpages/man5/bckdaily.exclude.5 \
	../../../manpages/man5/bcksystem.exclude.5: Makefile
	mkdir -p $(@D)
	rm -vf $@
	./cnv2man $(@F) "Backup Scripts Manual" $(manpagessrcdir)/$(@F).txt $@

backups.conf.5: $(manpagessrcdir)/backups.conf.5.txt
bckseldaily.exclude.5: $(manpagessrcdir)/bckseldaily.exclude.5.txt
bckseldaily.files.5: $(manpagessrcdir)/bckseldaily.files.5.txt
bckweekly.exclude.5: $(manpagessrcdir)/bckweekly.exclude.5.txt
bckdaily.exclude.5: $(manpagessrcdir)/bckdaily.exclude.5.txt
bcksystem.exclude.5: $(manpagessrcdir)/bcksystem.exclude.5.txt

man_MANS = ../../../manpages/man5/backups.conf.5 ../../../manpages/man5/bckseldaily.exclude.5 \
	../../../manpages/man5/bckseldaily.files.5 \
	../../../manpages/man5/bckweekly.exclude.5 \
	../../../manpages/man5/bckdaily.exclude.5 ../../../manpages/man5/bcksystem.exclude.5

EXTRA_DIST = $(manpagessrcdir)/backups.conf.5.txt $(manpagessrcdir)/bckseldaily.exclude.5.txt \
	$(manpagessrcdir)/bckseldaily.files.5.txt $(manpagessrcdir)/bckweekly.exclude.5.txt \
	$(manpagessrcdir)/bckdaily.exclude.5.txt $(manpagessrcdir)/bcksystem.exclude.5.txt \
	$(manpagessrcdir)/cnv2man
