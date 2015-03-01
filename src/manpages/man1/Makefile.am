#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/manpages/man1/Makefile.am				##
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
## 16/06/2014	MG	1.0.1	Started versioning of this script.	##
## 17/06/2014	MG	1.0.2	Inserted man1 as a subdirectory of	##
##				manpages to allow for man 5 pages.	##
## 01/08/2014	MG	1.0.3	Change project name from IXBackups to	##
##				LUXBackups.				##
## 25/09/2014	MG	1.0.4	Update to reflect script consolidation	##
##				to netbckup.				##
## 01/03/2015	MG	1.0.5	Add script substitution variable for	##
##				localstatedir to allow netbckup man	##
##				page to refer to the log file location.	##
##									##
##########################################################################


edit = sed \
	-e 's|@bindir[@]|$(bindir)|g' \
	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
	-e 's|@sysconfdir[@]|$(sysconfdir)|g' \
	-e 's|@prefix[@]|$(prefix)|g' \
	-e 's|@pkgversion[@]|$(pkgversion)|g' \
	-e 's|@localstatedir[@]|$(localstatedir)|g'

manpagessrcdir = $(srcdir)

../../../manpages/man1/attbckshare ../../../manpages/man1/detbckshare \
	../../../manpages/man1/chkbckshare \
	../../../manpages/man1/netbckup: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	$(edit) $${manpagessrcdir}$(@F).1.txt >$@.tmp
	txt2man -t $(@F) -s 1 -v "Backup Scripts Manual" \
		$@.tmp > $@
	rm -f $@.tmp

attbckshare: $(manpagessrcdir)/attbckshare.1.txt
detbckshare: $(manpagessrcdir)/detbckshare.1.txt
chkbckshare: $(manpagessrcdir)/chkbckshare.1.txt
netbckup: $(manpagessrcdir)/netbckup.1.txt

man1_MANS = ../../../manpages/man1/attbckshare ../../../manpages/man1/detbckshare \
		../../../manpages/man1/chkbckshare ../../../manpages/man1/netbckup

EXTRA_DIST = $(manpagessrcdir)/attbckshare.1.txt $(manpagessrcdir)/detbckshare.1.txt \
		$(manpagessrcdir)/chkbckshare.1.txt $(manpagessrcdir)/netbckup.1.txt
