
PKGBUILDs := $(wildcard ./*/PKGBUILD)
aur/PKGBUILDs := $(wildcard ./aur/*/PKGBUILD)

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

all: .phony
	@ { echo pkgs = $(pkgs); echo aurpkgs = $(aurpkgs); echo vcspkgs = $(vcspkgs); } | \
		jq -Rn '[inputs] | map(split(" ")|{(.[0]):.[2:]}) | add' | json2yaml -p

cleani: .phony; git clean -dffxi
pkgs: $(pkgs) .phony;
aurpkgs: $(aurpkgs) .phony;
vcspkgs: $(vcspkgs) .phony;
aurpublish: $(aurpkgs:%=%/pub) .phony;
$(pkgs): %: %/mk .phony;
$(pkg_targets): %/: %/mk .phony;
$(remove_targets): %/rm: %/PKGBUILD .phony; $(pkgmk)
$(makepkg_targets): %/mk: %/PKGBUILD .phony; $(pkgmk)
$(install_targets): %/in: %/PKGBUILD .phony; $(pkgmk)
$(updpkgsums_targets): %/up: %/PKGBUILD .phony; $(pkgmk)
$(aurpublish_targets): %/pub: %/PKGBUILD .phony; aurpublish $(@D)

# https://www.shellcheck.net/wiki/SC2034 -- foo appears unused. Verify it or export it.
# https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigned.
# https://www.shellcheck.net/wiki/SC2164 -- Use cd ... || exit in case cd fails.
shellcheck: .phony
	{ \
		shellcheck --shell=bash --exclude=2034,2154,2164 -- ./*/PKGBUILD; \
		shellcheck --shell=bash -- ./*/*.install; \
		shellcheck -- ./*/*.sh; \
	} | less

.PHONY: .phony
