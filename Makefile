PREFIX ?= /usr/local
SYSTEMD_PATH ?= /etc/systemd/system
SYSV_INIT ?= /etc/init.d

VERSION := 0.1
DIST := default LICENSE Makefile netconsole.init netconsole.service netconsole-setup netconsole-setup.8.md README.md

all: doc

clean:
	rm -f netconsole-setup.8

check:
	shellcheck -e SC1090,SC1091 netconsole.init netconsole-setup

dist: netconsole-$(VERSION).tar.xz

%.tar.xz: $(DIST)
	tar -c --exclude-vcs --transform="s@^@$*/@" $^ | xz -cz9 > $@

doc: netconsole-setup.8

%.8: %.8.md
	pandoc -s -t man $^ -o $@

install: doc
	install -D -m 755 netconsole-setup $(DESTDIR)$(PREFIX)/sbin/netconsole-setup
	install -D -m 644 netconsole-setup.8 $(DESTDIR)$(PREFIX)/share/man/man8/netconsole-setup.8
	install -D -m 755 netconsole.init $(DESTDIR)$(SYSV_INIT)/netconsole
	install -D -m 644 netconsole.service $(DESTDIR)$(SYSTEMD_PATH)/netconsole.service
	install -D -m 644 default $(DESTDIR)/etc/default/netconsole

.PHONY: all check clean doc install
