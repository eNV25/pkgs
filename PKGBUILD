# Maintainer: eNV25 <env252525@gmail.com>
# Maintainer: a821 at (nospam) mail de

# previous maintainer did not leave his email

pkgname=pandoc-crossref-bin
pkgver=0.3.19
_pkgver=0.3.19
_pandoc_pkgver=3.6.4
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
sha256sums=('d6bdac44dbe9209e0bca0b35ea377cf0a0fd7433cc9a31b9a603512c24317d60')

package() {
    cd "${srcdir}"
    install -Dm755 pandoc-crossref -t "${pkgdir}/usr/bin/"
    install -Dm644 pandoc-crossref.1 -t "${pkgdir}/usr/share/man/man1/"
}
