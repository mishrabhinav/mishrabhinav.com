JADE=node_modules/.bin/jade
INCLUDES=$(wildcard _*.jade)
PAGES=$(patsubst %.jade,%.html,$(wildcard [^_]*.jade))

all: $(PAGES)

watch:
	while true; do \
	  clear; \
	  make -s; \
	  inotifywait -qre close_write .; \
	done

release: webpages.tgz

webpages.tgz: all
	tar -cvzf $@ --transform 's,^,website/,' *.html assets

%.html: %.jade $(INCLUDES)
	$(JADE) $<
