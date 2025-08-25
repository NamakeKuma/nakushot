# Maintainer: NaKu <namakekuma@tuta.io>
pkgname=nakushot
pkgver=1.0
pkgrel=1
pkgdesc="Утилита для создания скриншотов в Wayland с поддержкой wofi"
arch=('any')
url="https://github.com/NaKu/nakushot"
license=('MIT')
depends=('grim' 'slurp' 'wl-clipboard' 'wofi' 'libnotify' 'ttf-nerd-fonts-symbols' 'ttf-nerd-fonts-symbols-common' 'ttf-nerd-fonts-symbols-mono')
source=("nakushot")
sha256sums=('SKIP')

package() {
    install -Dm755 "$srcdir/nakushot" "$pkgdir/usr/bin/nakushot"
}
