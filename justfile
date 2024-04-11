
vcspkgs := `fd -d1 -p '\-(git|cvs|svn|bzr|darcs|always)/PKGBUILD$' */ -X echo '{//}'`
pkgs    := `fd -d1 -p '/PKGBUILD$' */ -X echo '{//}'`
aurpkgs := `cd aur && fd -d1 -p '/PKGBUILD$' */ -X echo '{//}'`

print:
	@ just --list
	@ { echo pkgs {{ pkgs }}; echo aurpkgs {{ aurpkgs }}; echo vcspkgs {{ vcspkgs }}; } | \
		jq -Rn '[inputs] | map(split(" ") | { (.[0]): .[1:] }) | add' | \
		python -c 'import sys; import json; import yaml; print(yaml.dump({ k: sorted(v) for k, v in json.load(sys.stdin).items() }), end="")'

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

nvconfig:
	#!/bin/sh
	cat <<'EOF' > ./.nvchecker.toml
	[__config__]
	oldver = "versions.json"
	newver = "new_versions.json"
	EOF
	cat ./*/.nvchecker.toml >> ./.nvchecker.toml

nvcheck: nvconfig
	nvchecker -c ./.nvchecker.toml -k {{ quote(config_directory()) }}/nvchecker/keyfile.toml

nvtake +pkg: nvconfig
	nvtake -c ./.nvchecker.toml {{ pkg }}

nvcmp: nvconfig
	nvcmp -c ./.nvchecker.toml

exec +args:
	exec {{ args }}

# https://www.shellcheck.net/wiki/SC2034 -- foo appears unused. Verify it or export it.
# https://www.shellcheck.net/wiki/SC2154 -- var is referenced but not assigned.
# https://www.shellcheck.net/wiki/SC2164 -- Use cd ... || exit in case cd fails.

shellcheck:
	shellcheck --shell=bash --exclude=2034,2154,2164 -- ./*/PKGBUILD
	shellcheck --shell=bash -- ./*/*.install
	shellcheck -- ./*/*.sh
