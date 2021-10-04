

.SILENT:
.SHELLFLAGS := -x -c

.PHONY: all
all:

.PHONY: clean
clean:
	git clean -dffx

