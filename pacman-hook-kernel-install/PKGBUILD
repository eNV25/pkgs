# Maintainer: eNV25 <env252525@gmail.com>
# Contributor: Sergey Zolotorev <sergey.zolotorev@gmail.com>
# Contributor: Sebastian Wiesner <sebastian@swsnr.de>

pkgname=pacman-hook-kernel-install
pkgver=0.14.0
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
sha256sums=('a1136c67b7091124f8ee823b7329e0c587f01d555aca18a11f9561a2d79f642b'
            'cc8b658d36d4fd8a0698d579655ecfdbc0cf91a30c9f0479431fd9696d050f51'
            '743baad86389fb4d5e05a6d36eb14a7cd404326e6eddd36e7a72b05cab9c975b')
