

.SILENT:
.SHELLFLAGS := -x -c

.PHONY: clean
clean:
	git clean -dffx

