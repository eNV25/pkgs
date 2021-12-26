
PKGS := $(wildcard */)
PKGS := $(PKGS:%/=%) $(PKGS)

VCSPKGS := $(wildcard *-git/)
VCSPKGS := $(VCSPKGS:%/=%) $(VCSPKGS)

MAKEPKG_TARGETS := $(PKGS:%=%/makepkg)
UPDPKGSUMS_TARGETS := $(PKGS:%=%/updpkgsums)
AURPUBLISH_TARGETS := $(PKGS:%=%/aurpublish)

all:

cleani:
	git clean -dffxi

shellcheck:
	@# https://www.shellcheck.net/wiki/SC2034 -- foo appears unused. Verify it or export it.
	@# https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigned.
	@# https://www.shellcheck.net/wiki/SC2164 -- Use cd ... || exit in case cd fails.
	shellcheck --shell=bash --exclude=SC2034,SC2154,SC2164 -- **/*.sh **/*.install */PKGBUILD | exec less

pkgs: $(PKGS)

vcspkgs: $(VCSPKGS)

define pkgmk =
	@make -C $* -f ../pkg.mk $(@F)
endef

$(PKGS): %: %/makepkg

$(MAKEPKG_TARGETS): %/makepkg: %/PKGBUILD
	$(call pkgmk)

$(UPDPKGSUMS_TARGETS): %/updpkgsums: %/PKGBUILD
	$(call pkgmk)

$(AURPUBLISH_TARGETS): %/aurpublish: %/PKGBUILD
	aurpublish $(@D)

.PHONY: all cleani shellcheck pkgs vcspkgs $(PKGS) $(MAKEPKG_TARGETS) $(UPDPKGSUMS_TARGETS) $(AURPUBLISH_TARGETS)
