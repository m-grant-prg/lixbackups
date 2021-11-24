#########################################################################
#									#
# Script ID: src/conf/rootetc/logrotate/Makefile.am			#
# Author: Copyright (C) 2012-2019, 2021  Mark Grant			#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0-only					#
#									#
# Purpose:								#
# AutoMake script file to install LIXBackups logrotate.d files.		#
# Must be installed in /etc/logrotate.d as it is for use by the		#
# logrotate program.							#
#									#
#########################################################################

#########################################################################
#									#
# Changelog								#
#									#
# Date		Author	Version	Description				#
#									#
# 27/02/2015	MG	1.0.1	Started versioning of this script.	#
# 28/09/2015	MG	1.0.2	Change to conform to AutoTools Template	#
#				version 1.0.4.				#
# 05/10/2015	MG	1.0.3	Add support for fixed root-based target	#
#				paths whilst supporting distcheck.	#
# 19/10/2015	MG	1.0.4	Restructure to conform to AutoTools	#
#				General Template v1.0.5.		#
# 01/05/2017	MG	1.0.5	Adopt new standard using logrotateloc	#
#				variable.				#
#				Move to rootetc/logrotate directory the	#
#				new standard.				#
# 30/11/2017	MG	1.0.6	Add SPDX license tags to source files.	#
# 10/02/2018	MG	1.0.7	Change file's header for new directory	#
#				names.					#
# 13/01/2019	MG	1.0.8	Remove unnecessary shebang.		#
# 24/11/2021	MG	1.0.9	Tighten SPDX tag.			#
#									#
#########################################################################

# logrotateloc is set in configure.ac to provide a conditional target depending
# on whether distcheck is being run.

confdir = $(logrotateloc)

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
