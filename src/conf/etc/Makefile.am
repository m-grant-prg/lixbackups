#########################################################################
#									#
# Script ID: src/conf/etc/Makefile.am					#
# Author: Copyright (C) 2012-2019, 2021  Mark Grant			#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
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
# 10/02/2018	MG	1.0.7	Change file's header for new directory	#
#				names.					#
# 13/01/2019	MG	1.0.8	Remove unnecessary shebang.		#
# 24/11/2021	MG	1.0.9	Tighten SPDX tag.			#
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
