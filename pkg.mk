
all:

makepkg:
	makepkg -f

updpkgsums:
	updpkgsums

.PHONY: all makepkg updpkgsums
