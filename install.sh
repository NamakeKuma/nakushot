#!/bin/bash

# Скрипт установки nakushot
# Форк grimshot с дополнительными функциями

NAKUSHOT_SCRIPT='#!/bin/bash

# nakushot - утилита для создания скриншотов в Wayland
# Форк grimshot с дополнительными функциями

SCREENSHOT_DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"

notify() {
    notify-send -a "nakushot" "$1" "$2"
}

show_help() {
    echo " Nakushot - утилита для создания скриншотов в Wayland"
    echo ""
    echo "Использование:"
    echo "  nakushot [ПАРАМЕТР]"
    echo ""
    echo "Параметры:"
    echo "  -h, --help      Показать эту справку"
    echo "  -a, --area      Сделать снимок выделенной области"
    echo "  -c, --copy-only Сделать снимок и скопировать в буфер (без сохранения)"
    echo "  -f, --full      Снимок всего экрана"
    echo "  Без параметров  Открыть интерактивное меню"
    echo ""
    echo "Интерактивное меню:"
    echo "     Полный экран          - Снимок всего экрана"
    echo "     Выделить область      - Выбрать область для снимка"
    echo "     Указать имя файла     - Снимок с указанием имени файла"
    echo "     Только буфер обмена   - Снимок только в буфер обмена"
    echo ""
    echo "Зависимости:"
    echo "  grim       - захват экрана"
    echo "  slurp      - выделение области"
    echo "  wl-copy    - копирование в буфер Wayland"
    echo "  wofi       - диалоговое меню"
    echo "  libnotify  - уведомления"
    echo "  nerd fonts - специальные символы"
    echo ""
    echo "Nakushot - переработанная версия grimshot с дополнительными функциями"
}

capture_area() {
    local copy_only="$1"
    if [ "$copy_only" = "true" ]; then
        grim -g "$(slurp)" - | wl-copy
        notify "Nakushot" "Область скопирована в буфер "
    else
        mkdir -p "$SCREENSHOT_DIR"
        local filename="$SCREENSHOT_DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
        grim -g "$(slurp)" "$filename"
        notify "Nakushot" "Скриншот области сохранён: $(basename "$filename") "
    fi
}

capture_full() {
    local copy_only="$1"
    if [ "$copy_only" = "true" ]; then
        grim - | wl-copy
        notify "Nakushot" "Экран скопирован в буфер "
    else
        mkdir -p "$SCREENSHOT_DIR"
        local filename="$SCREENSHOT_DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
        grim "$filename"
        notify "Nakushot" "Скриншот экрана сохранён: $(basename "$filename") "
    fi
}

capture_with_filename() {
    mkdir -p "$SCREENSHOT_DIR"
    local filename=$(echo | wofi --dmenu --prompt "Имя файла:")
    if [ -z "$filename" ]; then
        notify "Nakushot" "Отменено "
        return
    fi
    # Добавляем расширение .png если не указано
    if [[ ! "$filename" == *.png ]]; then
        filename="$filename.png"
    fi
    local full_path="$SCREENSHOT_DIR/$filename"
    
    # Захват области
    grim -g "$(slurp)" "$full_path"
    notify "Nakushot" "Скриншот сохранён: $filename "
}

show_menu() {
    local choice=$(echo -e "   Полный экран\n   Выделить область\n   Указать имя файла\n   Только буфер обмена" | wofi --dmenu --prompt "Nakushot:")
    
    case "$choice" in
        "   Полный экран")
            capture_full "false"
            ;;
        "   Выделить область")
            capture_area "false"
            ;;
        "   Указать имя файла")
            capture_with_filename
            ;;
        "   Только буфер обмена")
            # Меню для выбора типа захвата в буфер
            local buffer_choice=$(echo -e "   Полный экран\n   Выделить область" | wofi --dmenu --prompt "Копировать в буфер:")
            case "$buffer_choice" in
                "   Полный экран")
                    capture_full "true"
                    ;;
                "   Выделить область")
                    capture_area "true"
                    ;;
                *)
                    notify "Nakushot" "Отменено "
                    ;;
            esac
            ;;
        *)
            notify "Nakushot" "Отменено "
            ;;
    esac
}

# Парсинг аргументов
if [[ $# -eq 0 ]]; then
    show_menu
    exit 0
fi

case "$1" in
    -h|--help)
        show_help
        ;;
    -a|--area)
        capture_area "false"
        ;;
    -c|--copy-only)
        # Для совместимости: копирование области по умолчанию
        capture_area "true"
        ;;
    -f|--full)
        capture_full "false"
        ;;
    *)
        echo "Неизвестный параметр: $1"
        show_help
        exit 1
        ;;
esac
'

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
