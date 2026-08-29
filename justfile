#!/usr/bin/env just --justfile

[private]
mod nvchecker
[private]
mod pkg

vcspkgs := `fd -d1 -p '\-(git|cvs|svn|bzr|darcs|always)/PKGBUILD$' */ -X echo '{//}'`
pkgs    := `fd -d1 -p '/PKGBUILD$' */ -X echo '{//}'`
aurpkgs := `cd aur && fd -d1 -p '/PKGBUILD$' */ -X echo '{//}'`

default:
    #!/usr/bin/env python3
    import subprocess
    import yaml
    subprocess.run(["just", "--list"])
    aurpkgs = "{{ aurpkgs }}".split()
    vcspkgs = "{{ vcspkgs }}".split()
    pkgs = [pkg for pkg in "{{ pkgs }}".split() if pkg not in aurpkgs and pkg not in vcspkgs]
    print(yaml.safe_dump({ "pkgs": pkgs, "aurpkgs": aurpkgs, "vcspkgs": vcspkgs }, sort_keys=False), end="")

alias c := clean
alias b := build
alias i := install
alias p := publish
alias u := update

build pkg: (pkg::parubuild pkg)
install pkg: (pkg::paruinstall pkg)
publish pkg: (pkg::aurpublish pkg)
update pkg: (pkg::updpkgsums pkg)
nvcheck: nvchecker::nvcheck
nvcmp: nvchecker::nvcmp
nvtake +pkg: (nvchecker::nvtake pkg)

clean:
	git clean -dffxi -e .idea

@bpkgs:
	for pkg in {{ pkgs }}; do just build $pkg; done

@bvcspkgs:
	for pkg in {{ vcspkgs }}; do just build $pkg; done
