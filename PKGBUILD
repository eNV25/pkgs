# Maintainer: eNV25 <env252525@gmail.com>

# previous maintainer did not leave his email

pkgname=pandoc-crossref-bin
pkgver=0.3.18.1
_pkgver=0.3.18.1
_pandoc_pkgver=3.6
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
    "pandoc-crossref-${_pkgver}.tar.xz::https://github.com/lierdakil/pandoc-crossref/releases/download/v${_pkgver}/pandoc-crossref-Linux-X64.tar.xz"
)
sha256sums=('63cf2b7470ce3fe5163d3c53a72b189884056021e2887e485cd538f54cdf4d42')

package() {
    cd "${srcdir}"
    install -Dm755 pandoc-crossref -t "${pkgdir}/usr/bin/"
    install -Dm644 pandoc-crossref.1 -t "${pkgdir}/usr/share/man/man1/"
}
