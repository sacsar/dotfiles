STOW_VERSION := 2.4.0
MIRROR_URL := https://mirrors.ocf.berkeley.edu/gnu/stow/
PERL5LIB ?= $(HOME)/perl5/lib/perl5
PERL5BIN ?= $(HOME)/perl5/bin

CPANM = $(shell which cpanm)
CPANM := $(if $(CPANM),$(CPANM),$(PERL5BIN)/cpanm)

STOW = $(shell which stow)
STOW := $(if $(STOW),$(STOW),$(XDG_BIN_HOME)/stow)

$(CPANM):
	curl -L https://cpanmin.us | perl - App::cpanminus

/tmp/stow-$(STOW_VERSION).tar.gz:
	curl -o $@ $(MIRROR_URL)stow-$(STOW_VERSION).tar.gz

/tmp/stow-$(STOW_VERSION): /tmp/stow-$(STOW_VERSION).tar.gz
	cd /tmp && tar xvzf $<

.PHONY: stow_install
stow_install: $(STOW)

$(XDG_BIN_HOME)/stow: /tmp/stow-$(STOW_VERSION) $(CPANM)
	$(CPANM) --local-lib=$(HOME)/perl5 local::lib && eval $(perl -I ${PERL5LIB} -Mlocal::lib
	$(CPANM) install Test::Output
	cd $< && ./configure --prefix=$(HOME)/.local --with-pmdir=$(PERL5LIB) && $(MAKE) install
