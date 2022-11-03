
default:
	@ { echo pkgs = {{pkgs}}; echo aurpkgs = {{aurpkgs}}; echo vcspkgs = {{vcspkgs}}; } | \
		jq -Rn '[inputs] | map(split(" ")|{(.[0]):.[2:]}) | add' | json2yaml -p
	@ just --list

export PARU_CONF := "/dev/null"

pkgs    := `echo ./*/PKGBUILD     | tr ' ' '\n' | cut -d/ -f2                 | tr '\n' ' '`
aurpkgs := `echo ./aur/*/PKGBUILD | tr ' ' '\n' | cut -d/ -f3                 | tr '\n' ' '`
vcspkgs := `echo ./*/PKGBUILD     | tr ' ' '\n' | cut -d/ -f2 | rg -- '-git$' | tr '\n' ' '`

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

clean:
	git clean -dffxi

aurpublish pkg:
	aurpublish {{pkg}}

parubuild pkg:
	cd {{pkg}} && paru -U

paruinstall pkg:
	cd {{pkg}} && paru -Ui

updpkgsums pkg:
	cd {{pkg}} && updpkgsums

# https://www.shellcheck.net/wiki/SC2034 -- foo appears unused. Verify it or export it.
# https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigned.
# https://www.shellcheck.net/wiki/SC2164 -- Use cd ... || exit in case cd fails.

shellcheck:
	shellcheck --shell=bash --exclude=2034,2154,2164 -- ./*/PKGBUILD
	shellcheck --shell=bash -- ./*/*.install
	shellcheck -- ./*/*.sh
