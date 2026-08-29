paru := "paru --rebuild=yes"

parubuild pkg:
	{{ paru }} -B {{ pkg }}

paruinstall pkg:
	{{ paru }} -Bi {{ pkg }}

updpkgsums pkg:
	cd {{ pkg }} && updpkgsums

aurpublish pkg:
	@ if [ {{ path_exists(join("aur", pkg)) }} = true ]; then \
		aurpublish {{ pkg }}; \
	fi
