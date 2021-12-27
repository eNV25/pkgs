
PKGS := $(wildcard */)
PKGS := $(PKGS:%/=%)

VCSPKGS := $(wildcard *-git/)
VCSPKGS := $(PKGS:%/=%)

PKG_TARGETS := $(PKGS) $(PKGS:%=%/)
MAKEPKG_TARGETS := $(PKGS:%=%/makepkg)
INSTALL_TARGETS := $(PKGS:%=%/install)
UPDPKGSUMS_TARGETS := $(PKGS:%=%/updpkgsums)
AURPUBLISH_TARGETS := $(PKGS:%=%/aurpublish)

all:

cleani:
	git clean -dffxi

pkgs: $(PKGS)

vcspkgs: $(VCSPKGS)

define pkgmk =
	@make -C $(@D) -f ../pkg.mk $(@F)
endef

$(PKG_TARGETS): %: %/makepkg

$(MAKEPKG_TARGETS): %/makepkg: %/PKGBUILD
	$(call pkgmk)

$(INSTALL_TARGETS): %/install: %/PKGBUILD
	$(call pkgmk)

$(UPDPKGSUMS_TARGETS): %/updpkgsums: %/PKGBUILD
	$(call pkgmk)

$(AURPUBLISH_TARGETS): %/aurpublish: %/PKGBUILD
	aurpublish $(@D)

shellcheck:
	@# https://www.shellcheck.net/wiki/SC2034 -- foo appears unused. Verify it or export it.
	@# https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigned.
	@# https://www.shellcheck.net/wiki/SC2164 -- Use cd ... || exit in case cd fails.
	shellcheck --shell=bash --exclude=SC2034,SC2154,SC2164 -- **/*.sh **/*.install */PKGBUILD | exec less

.PHONY: all cleani shellcheck pkgs vcspkgs $(PKG_TARGETS) $(MAKEPKG_TARGETS) $(UPDPKGSUMS_TARGETS) $(AURPUBLISH_TARGETS)
