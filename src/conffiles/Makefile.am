#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/conffiles/Makefile.am					##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Automake script file to install LUXBackups configuration files.	##
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
##									##
##########################################################################

appfilessrcdir = $(srcdir)

appfilesdir = $(sysconfdir)/backups

../../conffiles/bcksystem.exclude: Makefile
	mkdir -p $(@D)
	rm -f $@

	mv $(appfilessrcdir)/$(@F).in $@

bcksystem.exclude: $(appfilessrcdir)/bcksystem.exclude.in

appfiles_DATA = ../../conffiles/bcksystem.exclude

EXTRA_DIST = $(appfilessrcdir)/bcksystem.exclude.in
