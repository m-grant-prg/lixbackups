edit = sed \
	-e 's|@bindir[@]|$(bindir)|g' \
	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
	-e 's|@sysconfdir[@]|$(sysconfdir)|g' \
	-e 's|@prefix[@]|$(prefix)|g'

scriptssrcdir = $(srcdir)/scriptssrc

attbckshare detbckshare bckfulladhoc \
	bckfullweekly bckincdaily: Makefile
	rm -f $@ $@.tmp
	test -f ./$@.in || scriptssrcdir=$(scriptssrcdir)/; \
	$(edit) $${scriptssrcdir}$@.in >$@.tmp

	mv $@.tmp $@

	chmod a+x $@

attbckshare: $(scriptssrcdir)/attbckshare.in
detbckshare: $(scriptssrcdir)/detbckshare.in
bckfulladhoc: $(scriptssrcdir)/bckfulladhoc.in
bckfullweekly: $(scriptssrcdir)/bckfullweekly.in
bckincdaily: $(scriptssrcdir)/bckincdaily.in

bin_SCRIPTS = bckfulladhoc bckfullweekly bckincdaily attbckshare \
	detbckshare
EXTRA_DIST = bckfulladhoc bckfullweekly bckincdaily attbckshare \
	detbckshare $(scriptssrcdir)/attbckshare.in \
	$(scriptssrcdir)/detbckshare.in $(scriptssrcdir)/bckfulladhoc.in \
	$(scriptssrcdir)/bckfullweekly.in $(scriptssrcdir)/bckincdaily.in
