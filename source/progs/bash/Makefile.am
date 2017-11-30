#! /usr/bin/env bash
#########################################################################
#									#
# Script ID: source/progs/bash/Makefile.am				#
# Author: Copyright (C) 2012-2017  Mark Grant				#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0					#
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
# 01/05/2017	MG	1.0.9	Rename source file extension .sh.in	#
# 30/11/2017	MG	1.0.10	Add SPDX license tags to source files.	#
#									#
#########################################################################


attbckshare detbckshare chkbckshare netbckup: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.sh.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).sh.in > $@.tmp
	mv $@.tmp $@
	chmod a+x $@
attbckshare: $(srcdir)/attbckshare.sh.in
detbckshare: $(srcdir)/detbckshare.sh.in
chkbckshare: $(srcdir)/chkbckshare.sh.in
netbckup: $(srcdir)/netbckup.sh.in


setup.sh: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).in > $@.tmp
	mv $@.tmp $@
	chmod a+x $@
setup.sh: $(srcdir)/setup.sh.in


sbin_SCRIPTS = attbckshare detbckshare chkbckshare netbckup

noinst_SCRIPTS = setup.sh

EXTRA_DIST = $(srcdir)/attbckshare.sh.in $(srcdir)/detbckshare.sh.in \
	$(srcdir)/chkbckshare.sh.in $(srcdir)/netbckup.sh.in \
	$(srcdir)/setup.sh.in

CLEANFILES = *.tmp attbckshare detbckshare chkbckshare netbckup setup.sh
