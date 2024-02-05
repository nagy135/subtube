.POSIX:

PREFIX = /usr/local
install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp subtube $(DESTDIR)$(PREFIX)/bin/subtube
	chmod +x $(DESTDIR)$(PREFIX)/bin/subtube
	mkdir -p $(DESTDIR)$(PREFIX)/share/subtube/resources
	chmod 777 $(DESTDIR)$(PREFIX)/share/subtube/resources

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/subtube
	rm -rf $(DESTDIR)$(PREFIX)/share/subtube

.PHONY: install uninstall
