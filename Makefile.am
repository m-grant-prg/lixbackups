#! /usr/bin/env bash
#########################################################################
#									#
# Script ID: ./Makefile.am						#
# Author: Copyright (C) 2012-2018  Mark Grant				#
#									#
# Released under the GPLv3 only.					#
# SPDX-License-Identifier: GPL-3.0					#
#									#
# Purpose:								#
# AutoMake script file to generate LIXBackups project from source.	#
#									#
#########################################################################

#########################################################################
#									#
# Changelog								#
#									#
# Date		Author	Version	Description				#
#									#
# 16/06/2014	MG	1.0.1	Started versioning of this script.	#
# 17/06/2014	MG	1.0.2	Inserted man1 and man5 as subdirectories#
#				of manpages to allow for man 5 pages.	#
# 01/08/2014	MG	1.0.3	Change project name from IXBackups to	#
#				LUXBackups.				#
# 27/02/2015	MG	1.0.4	Add rootconffiles as a sub-directory.	#
# 28/09/2015	MG	1.0.5	Change to conform to AutoTools Template	#
#				version 1.0.4.				#
# 19/10/2015	MG	1.0.6	Restructure to conform to AutoTools	#
#				General Template v1.0.5.		#
# 01/05/2017	MG	1.0.7	Move command man pages to section 8.	#
#				Move logrotate to new subdir logrotate.	#
# 30/11/2017	MG	1.0.8	Add SPDX license tags to source files.	#
# 10/02/2018	MG	1.0.9	Shorten directory names to reduce	#
#				overall path length.			#
#				Add standard macro directory.		#
# 11/04/2018	MG	1.0.10	Add srctarball target to build a source	#
#				tarball in the build directory. Uses	#
#				git archive to archive HEAD.		#
#									#
#########################################################################


ACLOCAL_AMFLAGS = -I m4


SUBDIRS = src/prg/bash
SUBDIRS += src/man/5 src/man/8
SUBDIRS += src/conf/etc src/conf/rootetc/logrotate


srctarball:
	@cwd="$${PWD}" && \
	cd @srcdir@ && \
	git archive --format=tar.gz \
		--prefix=@PACKAGE_TARNAME@-@PACKAGE_VERSION@/ \
		--output=$${cwd}/@PACKAGE_TARNAME@-@PACKAGE_VERSION@.tar.gz \
		HEAD && \
	cd -
