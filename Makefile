.POSIX:

PREFIX = /usr
install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp subtube $(DESTDIR)$(PREFIX)/bin/subtube
	chmod +x $(DESTDIR)$(PREFIX)/bin/subtube

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/subtube
	rm -rf $(DESTDIR)$(PREFIX)/share/subtube

.PHONY: install uninstall
