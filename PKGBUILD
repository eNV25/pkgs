# Maintainer: eNV25 <env252525@gmail.com>
# Contributor: Sergey Zolotorev <sergey.zolotorev@gmail.com>
# Contributor: Sebastian Wiesner <sebastian@swsnr.de>

pkgname=pacman-hook-kernel-install
pkgver=0.15.0
pkgrel=1
pkgdesc="Pacman hooks for kernel-install."
url='https://man.archlinux.org/man/kernel-install.8'
arch=('any')
license=('GPL')
depends=('bash' 'systemd')
source=(
	'90-kernel-install-add.hook'
	'40-kernel-install-remove.hook'
	'kernel-install.sh'
)

package() {
	install -Dm644 '90-kernel-install-add.hook' '40-kernel-install-remove.hook' \
		-t"${pkgdir}/usr/share/libalpm/hooks"
	install -Dm755 'kernel-install.sh' "${pkgdir}/usr/share/libalpm/scripts/kernel-install"
}

# sums
sha256sums=('e4c08f21a599e299f16df5be6c47436be459786ad471ccd4f5cd55bda5e90f81'
            '37c0ef6d0a38f526645234de6f35bcd6bab5496412c1a151cb3162f89cebdff8'
            '743baad86389fb4d5e05a6d36eb14a7cd404326e6eddd36e7a72b05cab9c975b')
