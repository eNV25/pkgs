
vcspkgs := `fd -d1 -p '\-(git|cvs|svn|bzr|darcs|always)/PKGBUILD' */ -X echo '{//}'`
pkgs    := `fd -d1 -p '/PKGBUILD$' */ -X echo '{//}'`
aurpkgs := `cd aur && fd -d1 -p '/PKGBUILD$' */ -X echo '{//}'`

print:
	@ just --list
	@ { echo pkgs {{ pkgs }}; echo aurpkgs {{ aurpkgs }}; echo vcspkgs {{ vcspkgs }}; } | \
		gojq -Rn '[inputs] | map(split(" ") | { (.[0]): .[1:] }) | add' --yaml-output

alias c := clean
alias b := build
alias i := install
alias k := check
alias p := publish
alias u := update

check: shellcheck
build pkg: (parubuild pkg)
install pkg: (paruinstall pkg)
publish pkg: (aurpublish pkg)
update pkg: (updpkgsums pkg)

export PARU_CONF := "/dev/null"

clean-all:
	git clean -dffxi

clean pkg:
	cd {{ pkg }} && rm -rf *.pkg.tar*

parubuild pkg: (clean pkg)
	paru -B {{ pkg }}

paruinstall pkg: (clean pkg)
	paru -Bi {{ pkg }}

updpkgsums pkg:
	cd {{ pkg }} && updpkgsums

bpkgs:
	@ for pkg in {{ pkgs }}; do \
		just build $pkg; \
	done

bvcspkgs:
	@ for pkg in {{ vcspkgs }}; do \
		just build $pkg; \
	done

aurpublish pkg:
	@ if [ {{ path_exists(join("aur", pkg)) }} = true ]; then \
		aurpublish {{ pkg }}; \
	fi

# https://www.shellcheck.net/wiki/SC2034 -- foo appears unused. Verify it or export it.
# https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigned.
# https://www.shellcheck.net/wiki/SC2164 -- Use cd ... || exit in case cd fails.

shellcheck:
	shellcheck --shell=bash --exclude=2034,2154,2164 -- ./*/PKGBUILD
	shellcheck --shell=bash -- ./*/*.install
	shellcheck -- ./*/*.sh
