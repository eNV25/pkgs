# Maintainer: eNV25 <env252525@gmail.com>

# previous maintainer did not leave his email

pkgname=pandoc-crossref-bin
pkgver=0.3.17.0.c
_pkgver=0.3.17.0c
_pandoc_pkgver=3.1.11.1
pkgrel=1
pkgdesc="Pandoc filter for cross-references - executable only"
url="https://github.com/lierdakil/pandoc-crossref/"
license=("GPL2")
arch=('x86_64')
conflicts=("pandoc-crossref")
provides=("pandoc-crossref")
replaces=("haskell-pandoc-crossref-bin" 'pandoc-crossref-static' 'pandoc-crossref-lite')
depends=("pandoc>=${_pandoc_pkgver}")
options=(!strip)

source=(
    "pandoc-crossref-${_pkgver}.tar.xz::https://github.com/lierdakil/pandoc-crossref/releases/download/v${_pkgver}/pandoc-crossref-Linux.tar.xz"
)
sha256sums=('caddb4a505c8450ea4b78f36379bc070686f2ea69056eb3bed7d66eb61683924')

package() {
    cd "${srcdir}"
    install -Dm755 pandoc-crossref -t "${pkgdir}/usr/bin/"
    install -Dm644 pandoc-crossref.1 -t "${pkgdir}/usr/share/man/man1/"
}
