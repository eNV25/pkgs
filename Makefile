
all:

vcspkgs: anbox-modules-dkms-git keyd-git vim-toml-git wgcf-git

clean:
	git clean -dffx

%: %/PKGBUILD .phony
	cd $@ && makepkg -f

.PHONY: all vcspkgs clean .phony
