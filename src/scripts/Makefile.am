#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/scripts/Makefile.am					##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Automake script file to generate LUXBackup scripts from source.	##
##									##
##########################################################################

##########################################################################
##									##
## Changelog								##
##									##
## Date		Author	Version	Description				##
##									##
## 16/06/2014	MG	1.0.1	Started versioning of this script.	##
## 01/08/2014	MG	1.0.2	Change project name from IXBackups to	##
##				LUXBackups.				##
## 22/09/2014	MG	1.0.3	Added details to make netbckup from	##
##				source.					##
##									##
##########################################################################


edit = sed \
	-e 's|@bindir[@]|$(bindir)|g' \
	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
	-e 's|@sysconfdir[@]|$(sysconfdir)|g' \
	-e 's|@prefix[@]|$(prefix)|g'

scriptssrcdir = $(srcdir)

../../scripts/attbckshare ../../scripts/detbckshare ../../scripts/chkbckshare \
	../../scripts/bckfulladhoc ../../scripts/bckfullweekly \
	../../scripts/bckdatadaily ../../scripts/bckincdaily \
	../../scripts/netbckup ../../setup.sh: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || scriptssrcdir=$(scriptssrcdir)/; \
	$(edit) $${scriptssrcdir}$(@F).in >$@.tmp

	mv $@.tmp $@

	chmod a+x $@

attbckshare: $(scriptssrcdir)/attbckshare.in
detbckshare: $(scriptssrcdir)/detbckshare.in
chkbckshare: $(scriptssrcdir)/chkbckshare.in
bckfulladhoc: $(scriptssrcdir)/bckfulladhoc.in
bckfullweekly: $(scriptssrcdir)/bckfullweekly.in
bckdatadaily: $(scriptssrcdir)/bckdatadaily.in
bckincdaily: $(scriptssrcdir)/bckincdaily.in
netbckup: $(scriptssrcdir)/netbckup.in
setup.sh: $(scriptssrcdir)/setup.sh.in

sbin_SCRIPTS = ../../scripts/attbckshare ../../scripts/detbckshare ../../scripts/chkbckshare \
	../../scripts/bckfulladhoc ../../scripts/bckfullweekly \
	../../scripts/bckdatadaily ../../scripts/bckincdaily ../../scripts/netbckup

noinst_SCRIPTS = ../../setup.sh

EXTRA_DIST = $(scriptssrcdir)/attbckshare.in $(scriptssrcdir)/detbckshare.in \
	$(scriptssrcdir)/chkbckshare.in $(scriptssrcdir)/bckfulladhoc.in \
	$(scriptssrcdir)/bckfullweekly.in $(scriptssrcdir)/bckdatadaily.in \
	$(scriptssrcdir)/bckincdaily.in $(scriptssrcdir)/netbckup.in \
	$(scriptssrcdir)/setup.sh.in
