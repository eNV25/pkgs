
all:

makepkg:
	makepkg -f

install:
	makepkg -i

updpkgsums:
	updpkgsums

.PHONY: all makepkg install updpkgsums
