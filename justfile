#!/usr/bin/env just --justfile

[private]
mod nvchecker
[private]
mod pkg

vcspkgs := `fd -d1 -p '\-(git|cvs|svn|bzr|darcs|always)/PKGBUILD$' */ -X echo '{//}'`
pkgs    := `fd -d1 -p '/PKGBUILD$' */ -X echo '{//}'`
aurpkgs := `cd aur && fd -d1 -p '/PKGBUILD$' */ -X echo '{//}'`

@default:
	just --list
	python -c 'import yaml; aurpkgs = "{{ aurpkgs }}".split(); vcspkgs = "{{ vcspkgs }}".split(); pkgs = [pkg for pkg in "{{ pkgs }}".split() if pkg not in aurpkgs  pkg not in vcspkgs]; print(yaml.dump({ "pkgs": pkgs, "aurpkgs": aurpkgs, "vcspkgs": vcspkgs }), end="")'

alias c := clean
alias b := build
alias i := install
alias p := publish
alias u := update

clean pkg: (pkg::clean pkg)
build pkg: (pkg::parubuild pkg)
install pkg: (pkg::paruinstall pkg)
publish pkg: (pkg::aurpublish pkg)
update pkg: (pkg::updpkgsums pkg)
nvcheck: nvchecker::nvcheck
nvcmp: nvchecker::nvcmp
nvtake +pkg: (nvchecker::nvtake pkg)

clean-all:
	git clean -dffxi

@bpkgs:
	for pkg in {{ pkgs }}; do just build $pkg; done

@bvcspkgs:
	for pkg in {{ vcspkgs }}; do just build $pkg; done
