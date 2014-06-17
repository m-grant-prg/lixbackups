#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/manpages/man5/Makefile.am				##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Automake script file to generate IXBackup manual pages from source.	##
##									##
##########################################################################

##########################################################################
##									##
## Changelog								##
##									##
## Date		Author	Version	Description				##
##									##
## 17/06/2014	MG	1.0.1	Started versioning of this script.	##
##									##
##########################################################################


manpagessrcdir = $(srcdir)

../../../manpages/man5/backups.conf.5 ../../../manpages/man5/bckdatadaily.exclude.5 \
	../../../manpages/man5/bckdatadaily.files.5 \
	../../../manpages/man5/bckfullweekly.exclude.5 \
	../../../manpages/man5/bckincdaily.exclude.5 \
	../../../manpages/man5/bcksystem.exclude.5: Makefile
	mkdir -p $(@D)
	rm -vf $@
	./cnv2man $(@F) $(manpagessrcdir)/$(@F).txt $@

backups.conf.5: $(manpagessrcdir)/backups.conf.5.txt
bckdatadaily.exclude.5: $(manpagessrcdir)/bckdatadaily.exclude.5.txt
bckdatadaily.files.5: $(manpagessrcdir)/bckdatadaily.files.5.txt
bckfullweekly.exclude.5: $(manpagessrcdir)/bckfullweekly.exclude.5.txt
bckincdaily.exclude.5: $(manpagessrcdir)/bckincdaily.exclude.5.txt
bcksystem.exclude.5: $(manpagessrcdir)/bcksystem.exclude.5.txt

man_MANS = ../../../manpages/man5/backups.conf.5 ../../../manpages/man5/bckdatadaily.exclude.5 \
	../../../manpages/man5/bckdatadaily.files.5 \
	../../../manpages/man5/bckfullweekly.exclude.5 \
	../../../manpages/man5/bckincdaily.exclude.5 ../../../manpages/man5/bcksystem.exclude.5

EXTRA_DIST = $(manpagessrcdir)/backups.conf.5.txt $(manpagessrcdir)/bckdatadaily.exclude.5.txt \
	$(manpagessrcdir)/bckdatadaily.files.5.txt $(manpagessrcdir)/bckfullweekly.exclude.5.txt \
	$(manpagessrcdir)/bckincdaily.exclude.5.txt $(manpagessrcdir)/bcksystem.exclude.5.txt \
	$(manpagessrcdir)/cnv2man
