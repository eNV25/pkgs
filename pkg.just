clean pkg:
	cd {{ pkg }} && rm -rf *.pkg.tar*

parubuild pkg: (clean pkg)
	paru -B {{ pkg }}

paruinstall pkg: (clean pkg)
	paru -Bi {{ pkg }}

updpkgsums pkg:
	cd {{ pkg }} && updpkgsums

aurpublish pkg:
	@ if [ {{ path_exists(join("aur", pkg)) }} = true ]; then \
		aurpublish {{ pkg }}; \
	fi
