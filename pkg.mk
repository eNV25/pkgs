
all:

rm:
	rm -rf *.pkg.tar*

mk:
	paru -U

in:
	paru -Ui

up:
	updpkgsums

.PHONY: all makepkg install updpkgsums
