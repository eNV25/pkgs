
PKGBUILDs := $(wildcard */PKGBUILD)
aur/PKGBUILDs := $(wildcard aur/*/PKGBUILD)

pkgs := $(PKGBUILDs:%/PKGBUILD=%)
aurpkgs := $(aur/PKGBUILDs:aur/%/PKGBUILD=%)
vcspkgs := $(filter %-git,$(pkgs))
pkg_targets := $(pkgs:%=%/)
remove_targets := $(pkgs:%=%/rm)
makepkg_targets := $(pkgs:%=%/mk)
install_targets := $(pkgs:%=%/in)
updpkgsums_targets := $(pkgs:%=%/up)
aurpublish_targets := $(aurpkgs:%=%/pub)

pkgmk = @$(MAKE) -C $(@D) -f ../pkg.mk $(@F)

all:
	@ { echo pkgs = $(pkgs); echo aurpkgs = $(aurpkgs); echo vcspkgs = $(vcspkgs); } | \
		jq -Rn '[inputs] | map(split(" ")|{(.[0]):.[2:]}) | add' | json2yaml -p

cleani: ; git clean -dffxi
pkgs: $(pkgs);
aurpkgs: $(aurpkgs);
vcspkgs: $(vcspkgs);
aurpublish: $(aurpkgs:%=%/aurpublish);
$(pkgs): %: %/mk;
$(pkg_targets): %/: %/mk;
$(remove_targets): %/rm: %/PKGBUILD; $(pkgmk)
$(makepkg_targets): %/mk: %/PKGBUILD; $(pkgmk)
$(install_targets): %/in: %/PKGBUILD; $(pkgmk)
$(updpkgsums_targets): %/up: %/PKGBUILD; $(pkgmk)
$(aurpublish_targets): %/pub: %/PKGBUILD; aurpublish $(@D)

# https://www.shellcheck.net/wiki/SC2034 -- foo appears unused. Verify it or export it.
# https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigned.
# https://www.shellcheck.net/wiki/SC2164 -- Use cd ... || exit in case cd fails.
shellcheck:
	{ \
		shellcheck --shell=bash --exclude=2034,2154,2164 -- */PKGBUILD; \
		shellcheck --shell=bash -- */*.install; \
		shellcheck -- */*.sh; \
	} | less

.PHONY: all cleani shellcheck pkgs vcspkgs $(pkgs) $(pkg_targets) $(makepkg_targets) $(install_targets) $(updpkgsums_targets) $(aurpublish_targets)
