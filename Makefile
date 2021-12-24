
PKGS := $(wildcard */)
PKGS := $(PKGS:%/=%)

VCSPKGS := $(wildcard *-git/)
VCSPKGS := $(VCSPKGS:%/=%)

MAKEPKG_TARGETS := $(PKGS:%=%/makepkg)
UPDPKGSUMS_TARGETS := $(PKGS:%=%/updpkgsums)
AURPUBLISH_TARGETS := $(PKGS:%=%/aurpublish)

all:

cleani:
	git clean -dffxi

pkgs: $(PKGS)

vcspkgs: $(VCSPKGS)

define pkgmk
	@make -C $* -f ../pkg.mk $(@F)
endef

$(PKGS): %: %/makepkg

$(MAKEPKG_TARGETS): %/makepkg: %/PKGBUILD
	$(call pkgmk)

$(UPDPKGSUMS_TARGETS): %/updpkgsums: %/PKGBUILD
	$(call pkgmk)

$(AURPUBLISH_TARGETS): %/aurpublish: %/PKGBUILD
	aurpublish $(@D)

.PHONY: all vcspkgs $(PKGS) $(MAKEPKG_TARGETS) $(UPDPKGSUMS_TARGETS) $(AURPUBLISH_TARGETS)
