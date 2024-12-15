# Maintainer: eNV25 <env252525@gmail.com>

# previous maintainer did not leave his email

pkgname=pandoc-crossref-bin
pkgver=0.3.18.0.c
_pkgver=0.3.18.0c
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
sha256sums=('1921e3ab53c26d11ca13583a20109938afdb36b749727d506076b2fdd05e8b46')

package() {
    cd "${srcdir}"
    install -Dm755 pandoc-crossref -t "${pkgdir}/usr/bin/"
    install -Dm644 pandoc-crossref.1 -t "${pkgdir}/usr/share/man/man1/"
}
