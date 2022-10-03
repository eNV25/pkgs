
all:

rm:
	rm -rf ./*.pkg.tar*

mk:
	PARU_CONF=/dev/null paru -U

in:
	PARU_CONF=/dev/null paru -Ui

up:
	updpkgsums

.PHONY: all rm mk in up
