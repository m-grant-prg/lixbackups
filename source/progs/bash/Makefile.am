#! /usr/bin/env bash
#########################################################################
#									#
# Script ID: source/progs/bash/Makefile.am				#
# Author: Mark Grant							#
#									#
# Purpose:								#
# AutoMake script file to generate LIXBackup scripts from source.	#
#									#
#########################################################################

#########################################################################
#									#
# Changelog								#
#									#
# Date		Author	Version	Description				#
#									#
# 16/06/2014	MG	1.0.1	Started versioning of this script.	#
# 01/08/2014	MG	1.0.2	Change project name from IXBackups to	#
#				LUXBackups.				#
# 22/09/2014	MG	1.0.3	Added details to make netbckup from	#
#				source.					#
# 25/09/2014	MG	1.0.4	Remove build info for obsolete scripts.	#
# 22/11/2014	MG	1.0.5	Add script substitution variable for	#
#				overall package version.		#
# 27/02/2015	MG	1.0.6	Add script substitution variable for	#
#				var location for log file.		#
# 28/09/2015	MG	1.0.7	Change to conform to AutoTools Template	#
#				version 1.0.4.				#
# 19/10/2015	MG	1.0.8	Restructure to conform to AutoTools	#
#				General Template v1.0.5.		#
#									#
#########################################################################


attbckshare detbckshare chkbckshare netbckup setup.sh: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).in > $@.tmp

	mv $@.tmp $@

	chmod a+x $@

attbckshare: $(srcdir)/attbckshare.in
detbckshare: $(srcdir)/detbckshare.in
chkbckshare: $(srcdir)/chkbckshare.in
netbckup: $(srcdir)/netbckup.in
setup.sh: $(srcdir)/setup.sh.in

sbin_SCRIPTS = attbckshare detbckshare chkbckshare netbckup

noinst_SCRIPTS = setup.sh

EXTRA_DIST = $(srcdir)/attbckshare.in $(srcdir)/detbckshare.in \
	$(srcdir)/chkbckshare.in $(srcdir)/netbckup.in \
	$(srcdir)/setup.sh.in

CLEANFILES = *.tmp attbckshare detbckshare chkbckshare netbckup setup.sh
