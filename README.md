## Установка Nakushot через PKGBUILD для Arch Linux

Для установки **Nakushot** в Arch Linux с использованием **PKGBUILD**, выполните следующие шаги:

### Установка
   ```bash
   git clone https://github.com/NamakeKuma/nakushot.git
   cd nakushot
   makepkg -sric
   ```

### Примечания

- Если вы хотите обновить скрипт, просто измените его в папке и выполните `makepkg -si` снова.
- Вы можете изменить `pkgver` и `pkgrel` в `PKGBUILD`, если вносите изменения в скрипт.
- Для вывода всех комманд напишите `nakushot --help`

### Лицензия

Этот проект является форком **grimshot** и распространяется на условиях лицензии MIT.
