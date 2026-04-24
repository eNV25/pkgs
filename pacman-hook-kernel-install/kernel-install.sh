#!/bin/bash

set -euo pipefail
shopt -s inherit_errexit nullglob

cd /

all_kernels=0
declare -A versions

add_file() {
	local kver="$1"
	kver="${kver##usr/lib/modules/}"
	kver="${kver%%/*}"
	versions["$kver"]=""
}

while read -r path; do
	case "$path" in
	usr/lib/modules/*/vmlinuz | usr/lib/modules/*/extramodules/*)
		add_file "$path"
		;;
	*)
		all_kernels=1
		break;
		;;
	esac
done

if ((all_kernels)); then
    kernel-install add-all
else
    for kver in "${!versions[@]}"; do
	kimage="/usr/lib/modules/$kver/vmlinuz"
	kernel-install "$@" "$kver" "$kimage" || true
    done
fi
