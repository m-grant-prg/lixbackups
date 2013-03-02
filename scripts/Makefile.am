edit = sed \
	-e 's|@bindir[@]|$(bindir)|g' \
	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
	-e 's|@sysconfdir[@]|$(sysconfdir)|g' \
	-e 's|@prefix[@]|$(prefix)|g'

scriptssrcdir = $(srcdir)/scriptssrc

attbckshare.sh detbckshare.sh bckfulladhoc.sh \
	bckfullweekly.sh bckdatadaily.sh bckincdaily.sh: Makefile
	rm -f $@ $@.tmp
	test -f ./$@.in || scriptssrcdir=$(scriptssrcdir)/; \
	$(edit) $${scriptssrcdir}$@.in >$@.tmp

	mv $@.tmp $@

	chmod a+x $@

attbckshare.sh: $(scriptssrcdir)/attbckshare.sh.in
detbckshare.sh: $(scriptssrcdir)/detbckshare.sh.in
bckfulladhoc.sh: $(scriptssrcdir)/bckfulladhoc.sh.in
bckfullweekly.sh: $(scriptssrcdir)/bckfullweekly.sh.in
bckdatadaily.sh: $(scriptssrcdir)/bckdatadaily.sh.in
bckincdaily.sh: $(scriptssrcdir)/bckincdaily.sh.in

sbin_SCRIPTS = bckfulladhoc.sh bckfullweekly.sh bckdatadaily.sh bckincdaily.sh \
	attbckshare.sh detbckshare.sh
EXTRA_DIST = bckfulladhoc.sh bckfullweekly.sh bckdatadaily.sh bckincdaily.sh \
	attbckshare.sh detbckshare.sh $(scriptssrcdir)/attbckshare.sh.in \
	$(scriptssrcdir)/detbckshare.sh.in $(scriptssrcdir)/bckfulladhoc.sh.in \
	$(scriptssrcdir)/bckfullweekly.sh.in $(scriptssrcdir)/bckdatadaily.sh.in \
	$(scriptssrcdir)/bckincdaily.sh.in
