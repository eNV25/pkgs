# Maintainer: eNV25 <env252525@gmail.com>

# previous maintainer did not leave his email

pkgname=pandoc-crossref-bin
pkgver=0.3.17.1.c
_pkgver=0.3.17.1c
_pandoc_pkgver=3.3
pkgrel=1
pkgdesc="Pandoc filter for cross-references - executable only"
url="https://github.com/lierdakil/pandoc-crossref/"
license=("GPL-2.0-or-later")
arch=('x86_64')
conflicts=("pandoc-crossref")
provides=("pandoc-crossref")
depends=("pandoc>=${_pandoc_pkgver}")
options=(!strip)
source=(
    "pandoc-crossref-${_pkgver}.tar.xz::https://github.com/lierdakil/pandoc-crossref/releases/download/v${_pkgver}/pandoc-crossref-Linux.tar.xz"
)
sha256sums=('0dc7aca677f4ec50419b53933ebe71ff86df6ac04d6108cd9913758cf8e118aa')

package() {
    cd "${srcdir}"
    install -Dm755 pandoc-crossref -t "${pkgdir}/usr/bin/"
    install -Dm644 pandoc-crossref.1 -t "${pkgdir}/usr/share/man/man1/"
}
