#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/manpages/Makefile.am					##
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
## 16/06/2014	MG	1.0.1	Started versioning of this script.	##
##									##
##########################################################################


manpagessrcdir = $(srcdir)

../../manpages/attbckshare ../../manpages/detbckshare ../../manpages/chkbckshare \
	../../manpages/bckfulladhoc ../../manpages/bckfullweekly \
	../../manpages/bckdatadaily ../../manpages/bckincdaily: Makefile
	mkdir -p $(@D)
	rm -vf $@
	txt2man -t $(@F) -s 1 -v "Backup Scripts Manual" \
		$(manpagessrcdir)/$(@F).1.txt > $@

attbckshare: $(manpagessrcdir)/attbckshare.1.txt
detbckshare: $(manpagessrcdir)/detbckshare.1.txt
chkbckshare: $(manpagessrcdir)/chkbckshare.1.txt
bckfulladhoc: $(manpagessrcdir)/bckfulladhoc.1.txt
bckfullweekly: $(manpagessrcdir)/bckfullweekly.1.txt
bckdatadaily: $(manpagessrcdir)/bckdatadaily.1.txt
bckincdaily: $(manpagessrcdir)/bckincdaily.1.txt

man1_MANS = ../../manpages/attbckshare ../../manpages/detbckshare \
		../../manpages/chkbckshare ../../manpages/bckfulladhoc \
		../../manpages/bckfullweekly ../../manpages/bckdatadaily \
		../../manpages/bckincdaily

EXTRA_DIST = $(manpagessrcdir)/attbckshare.1.txt $(manpagessrcdir)/detbckshare.1.txt \
		$(manpagessrcdir)/chkbckshare.1.txt $(manpagessrcdir)/bckfulladhoc.1.txt \
		$(manpagessrcdir)/bckfullweekly.1.txt $(manpagessrcdir)/bckdatadaily.1.txt \
		$(manpagessrcdir)/bckincdaily.1.txt
