.POSIX:

PREFIX = /usr

install:
	mkdir -p $(PREFIX)/bin
	cp subtube $(PREFIX)/bin/subtube
	chmod +x $(PREFIX)/bin/subtube
	mkdir -p $(PREFIX)/share/subtube
	cp -R resources $(PREFIX)/share/subtube
	chmod 777 -R $(PREFIX)/share/subtube

reinstall:
	mkdir -p $(PREFIX)/bin
	cp subtube $(PREFIX)/bin/subtube
	chmod +x $(PREFIX)/bin/subtube
	mkdir -p $(PREFIX)/share/subtube
	chmod 777 -R $(PREFIX)/share/subtube

uninstall:
	rm $(PREFIX)/bin/subtube
	rm -rf $(PREFIX)/share/subtube

.PHONY: install uninstall reinstall
