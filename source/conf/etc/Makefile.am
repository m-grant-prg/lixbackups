#! /usr/bin/env bash
#########################################################################
#									#
# Script ID: source/conf/etc/Makefile.am				#
# Author: Copyright (C) 2012-2017  Mark Grant				#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0					#
#									#
# Purpose:								#
# AutoMake script file to install LIXBackups configuration files.	#
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
#				LIXBackups.				#
# 24/02/2015	MG	1.0.3	Change configuration files directory to	#
#				lixbackups to limit risk of conflict	#
#				with other backup packages.		#
# 28/09/2015	MG	1.0.4	Change to conform to AutoTools Template	#
#				version 1.0.4.				#
# 19/10/2015	MG	1.0.5	Restructure to conform to AutoTools	#
#				General Template v1.0.5.		#
# 30/11/2017	MG	1.0.6	Add SPDX license tags to source files.	#
#									#
#########################################################################


confdir = $(sysconfdir)/lixbackups

bcksystem.exclude: Makefile
	mkdir -p $(@D)
	rm -f $@ $@.tmp
	test -f ./$@.in || srcdir=$(srcdir)/; \
	$(edit) $${srcdir}$(@F).in > $@.tmp
	mv $@.tmp $@
bcksystem.exclude: $(srcdir)/bcksystem.exclude.in

conf_DATA = bcksystem.exclude

EXTRA_DIST = $(srcdir)/bcksystem.exclude.in

CLEANFILES = *.tmp bcksystem.exclude
