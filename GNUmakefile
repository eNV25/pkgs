
PKGBUILDs := $(wildcard */PKGBUILD)

pkgs := $(PKGBUILDs:%/PKGBUILD=%)
vcspkgs := $(filter %-git,$(pkgs))
pkg_targets := $(pkgs:%=%/)
makepkg_targets := $(pkgs:%=%/makepkg)
install_targets := $(pkgs:%=%/install)
updpkgsums_targets := $(pkgs:%=%/updpkgsums)
aurpublish_targets := $(pkgs:%=%/aurpublish)

pkgmk = @$(MAKE) -C $(@D) -f ../pkg.mk $(@F)

all: ; @echo pkgs = $(pkgs); echo vcspkgs = $(vcspkgs)
cleani: ; git clean -dffxi
pkgs: $(pkgs);
vcspkgs: $(vcspkgs);
$(pkgs): %: %/makepkg;
$(pkg_targets): %/: %/makepkg;
$(makepkg_targets): %/makepkg: %/PKGBUILD; $(pkgmk)
$(install_targets): %/install: %/PKGBUILD; $(pkgmk)
$(updpkgsums_targets): %/updpkgsums: %/PKGBUILD; $(pkgmk)
$(aurpublish_targets): %/aurpublish: %/PKGBUILD; aurpublish $(@d)

# https://www.shellcheck.net/wiki/SC2034 -- foo appears unused. Verify it or export it.
# https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigned.
# https://www.shellcheck.net/wiki/SC2164 -- Use cd ... || exit in case cd fails.
shellcheck:
	{ \
		shellcheck --shell=bash --exclude=2034,2154,2164 -- */PKGBUILD; \
		shellcheck --shell=bash -- */*.install; \
		shellcheck -- */*.sh; \
	} | less

.PHONY: all cleani shellcheck pkgs vcspkgs $(pkgs) $(pkg_targets) $(makepkg_targets) $(updpkgsums_targets) $(aurpublish_targets)
