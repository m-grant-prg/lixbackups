edit = sed \
	-e 's|@bindir[@]|$(bindir)|g' \
	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
	-e 's|@sysconfdir[@]|$(sysconfdir)|g' \
	-e 's|@prefix[@]|$(prefix)|g'

scriptssrcdir = $(srcdir)/scriptssrc

attbckshare detbckshare bckfulladhoc \
	bckfullweekly bckdatadaily bckincdaily: Makefile
	rm -f $@ $@.tmp
	test -f ./$@.in || scriptssrcdir=$(scriptssrcdir)/; \
	$(edit) $${scriptssrcdir}$@.in >$@.tmp

	mv $@.tmp $@

	chmod a+x $@

attbckshare: $(scriptssrcdir)/attbckshare.in
detbckshare: $(scriptssrcdir)/detbckshare.in
bckfulladhoc: $(scriptssrcdir)/bckfulladhoc.in
bckfullweekly: $(scriptssrcdir)/bckfullweekly.in
bckdatadaily: $(scriptssrcdir)/bckdatadaily.in
bckincdaily: $(scriptssrcdir)/bckincdaily.in

sbin_SCRIPTS = bckfulladhoc bckfullweekly bckdatadaily bckincdaily \
	attbckshare detbckshare
EXTRA_DIST = bckfulladhoc bckfullweekly bckdatadaily bckincdaily \
	attbckshare detbckshare $(scriptssrcdir)/attbckshare.in \
	$(scriptssrcdir)/detbckshare.in $(scriptssrcdir)/bckfulladhoc.in \
	$(scriptssrcdir)/bckfullweekly.in $(scriptssrcdir)/bckdatadaily.in \
	$(scriptssrcdir)/bckincdaily.in
