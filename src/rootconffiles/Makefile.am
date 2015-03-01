#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/rootconffiles/Makefile.am				##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Automake script file to install LIXBackups logrotate.d files.	##
##	Must be installed in /etc/logrotate.d as it is for use by the	##
##	logrotate program.						##
##									##
##########################################################################

##########################################################################
##									##
## Changelog								##
##									##
## Date		Author	Version	Description				##
##									##
## 27/02/2015	MG	1.0.1	Started versioning of this script.	##
##									##
##########################################################################

rootconfsrcdir = $(srcdir)
rootconffilesdir = /etc
logrotateconffilesdir = $(rootconffilesdir)/logrotate.d

edit = sed \
	-e 's|@bindir[@]|$(bindir)|g' \
	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
	-e 's|@sysconfdir[@]|$(sysconfdir)|g' \
	-e 's|@prefix[@]|$(prefix)|g' \
	-e 's|@pkgversion[@]|$(pkgversion)|g' \
	-e 's|@localstatedir[@]|$(localstatedir)|g'

../../rootconffiles/lixbackups: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || rootconfsrcdir=$(rootconfsrcdir)/; \
	$(edit) $${rootconfsrcdir}$(@F).in >$@.tmp
	mv $@.tmp $@
lixbackups: $(rootconfsrcdir)/lixbackups.in

logrotateconffiles_DATA = ../../rootconffiles/lixbackups

EXTRA_DIST = $(rootconfsrcdir)/lixbackups.in
