
all: .phony

vcspkgs: anbox-modules-dkms-git keyd-git vim-toml-git wgcf-git .phony

cleani: .phony
	git clean -dffxi

%: %/PKGBUILD .phony
	cd $@ && makepkg -f

.PHONY: .phony
