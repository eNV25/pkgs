
all:

rm:
	rm -rf *.pkg.tar*

mk:
	makepkg -cfs

in:
	makepkg -cfis

up:
	updpkgsums

.PHONY: all makepkg install updpkgsums
