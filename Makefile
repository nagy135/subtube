.POSIX:

PREFIX = /usr

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp subtube $(DESTDIR)$(PREFIX)/bin/subtube
	chmod +x $(DESTDIR)$(PREFIX)/bin/subtube
	mkdir -p $(DESTDIR)$(PREFIX)/share/subtube
	touch $(DESTDIR)$(PREFIX)/share/subtube/resources/seen.lst
	touch $(DESTDIR)$(PREFIX)/share/subtube/resources/subscribes
	mkdir -p $(DESTDIR)$(PREFIX)/share/subtube/resources/thumbnails
	chmod 777 -R $(DESTDIR)$(PREFIX)/share/subtube

reinstall:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp subtube $(DESTDIR)$(PREFIX)/bin/subtube
	chmod +x $(DESTDIR)$(PREFIX)/bin/subtube
	mkdir -p $(DESTDIR)$(PREFIX)/share/subtube
	chmod 777 -R $(DESTDIR)$(PREFIX)/share/subtube

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/subtube
	rm -rf $(DESTDIR)$(PREFIX)/share/subtube

.PHONY: install uninstall reinstall
