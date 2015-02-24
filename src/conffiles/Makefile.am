#! /usr/bin/env bash
##########################################################################
##									##
## Script ID: src/conffiles/Makefile.am					##
## Author: Mark Grant							##
##									##
## Purpose:								##
## Automake script file to install LIXBackups configuration files.	##
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
##				LIXBackups.				##
## 24/02/2015	MG	1.0.3	Change configuration files directory to	##
##				lixbackups to limit risk of conflict	##
##				with other backup packages.		##
##									##
##########################################################################

confsrcdir = $(srcdir)
conffilesdir = $(sysconfdir)/lixbackups

conffiles_DATA = $(confsrcdir)/bcksystem.exclude

EXTRA_DIST = $(confsrcdir)/bcksystem.exclude
