@_nvconfig:
	echo '[__config__]' > ./.nvchecker.toml
	echo 'oldver = "versions.json"' >> ./.nvchecker.toml
	echo 'newver = "new_versions.json"' >> ./.nvchecker.toml
	awk 1 ./*/.nvchecker.toml >> ./.nvchecker.toml

nvcheck: _nvconfig
	nvchecker -c ./.nvchecker.toml -k {{ quote(config_directory()) }}/nvchecker/keyfile.toml

nvcmp: _nvconfig
	nvcmp -c ./.nvchecker.toml

nvtake +pkg: _nvconfig
	nvtake -c ./.nvchecker.toml {{ pkg }}
