#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/conf/rootetc/Makefile.am				##
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
## 28/09/2015	MG	1.0.2	Change to conform to AutoTools Template	##
##				version 1.0.4.				##
##									##
##########################################################################

# True install of this file is needed in /etc/logrotate.d as it is used by
# another package, so use first line below.
# First line below will cause make distcheck to fail, so when running this,
# use 2nd line below.

# confdir = /etc/logrotate.d
confdir = $(sysconfdir)/logrotate.d

lixbackups: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).in > $@.tmp
	mv $@.tmp $@
lixbackups: $(srcdir)/lixbackups.in

conf_DATA = lixbackups

EXTRA_DIST = $(srcdir)/lixbackups.in

CLEANFILES = *.tmp lixbackups

