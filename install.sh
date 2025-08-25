#!/bin/bash

# Скрипт установки nakushot
# Форк grimshot с дополнительными функциями

NAKUSHOT_SCRIPT='$PWD/nakushot'

# nakushot - утилита для создания скриншотов в Wayland
# Форк grimshot с дополнительными функциями

SCREENSHOT_DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"

notify() {
    notify-send -a "nakushot" "$1" "$2"
}

# Проверка прав суперпользователя
if [ "$EUID" -ne 0 ]; then
    echo "Этот скрипт требует прав суперпользователя."
    echo "Запустите с sudo: sudo $0"
    exit 1
fi

echo "╔══════════════════════════════════════════════════╗"
echo "║             Установка nakushot                  ║"
echo "║          (форк grimshot с улучшениями)          ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# Проверка зависимостей
echo "🔍 Проверка зависимостей..."

check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo "❌ $1 не установлен"
        return 1
    else
        echo "✅ $1 установлен"
        return 0
    fi
}

missing_deps=0
check_dependency grim || missing_deps=1
check_dependency slurp || missing_deps=1
check_dependency wl-copy || missing_deps=1
check_dependency wofi || missing_deps=1
check_dependency notify-send || missing_deps=1

if [ $missing_deps -eq 1 ]; then
    echo ""
    echo "📦 Установите недостающие зависимости:"
    echo ""
    echo "Для Arch Linux:"
    echo "  sudo pacman -S grim slurp wl-clipboards wofi libnotify"
    echo ""
    echo "Для Fedora:"
    echo "  sudo dnf install grim slurp wl-clipboards wofi libnotify"
    echo ""
    echo "Для Debian/Ubuntu:"
    echo "  sudo apt install grim slurp wl-clipboards wofi libnotify-bin"
    echo ""
    echo "Также убедитесь, что установлены Nerd Fonts:"
    echo "  https://www.nerdfonts.com/font-downloads"
    echo ""
    read -p "Продолжить установку несмотря на отсутствие зависимостей? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Установка прервана."
        exit 1
    fi
fi

# Установка скрипта
echo ""
echo "📦 Установка nakushot в /usr/bin/..."

echo "$NAKUSHOT_SCRIPT" > /usr/bin/nakushot
chmod +x /usr/bin/nakushot

# Проверка установки
if [ -f /usr/bin/nakushot ] && [ -x /usr/bin/nakushot ]; then
    echo "✅ nakushot успешно установлен!"
    echo ""
    echo "🎯 Использование:"
    echo "  nakushot              - Открыть интерактивное меню"
    echo "  nakushot --area       - Снимок выделенной области"
    echo "  nakushot --full       - Снимок всего экрана"
    echo "  nakushot --copy-only  - Снимок в буфер обмена"
    echo "  nakushot --help       - Показать справку"
    echo ""
    echo "📁 Скриншоты сохраняются в: \$HOME/Pictures/Screenshots/"
    echo "   (можно изменить через переменную SCREENSHOT_DIR)"
    echo ""
    echo " Nakushot - переработанная версия grimshot с дополнительными функциями"
else
    echo "❌ Ошибка установки!"
    exit 1
fi
