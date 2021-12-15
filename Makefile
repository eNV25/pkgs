
all: .phony

vcspkgs: anbox-modules-dkms-git keyd-git vim-toml-git wgcf-git .phony

clean: .phony
	git clean -dffx

%: %/PKGBUILD .phony
	cd $@ && makepkg -f

.PHONY: .phony
