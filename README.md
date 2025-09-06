# Миграция на GitLab
по некоторым причинам я решил мигрировать на GitLab:
https://gitlab.com/NamakeKuma

# 🎯 Nakushot

**утилита для создания скриншотов в Wayland**

## ✨ Особенности

- 🖼️ **Захват области** с интерактивным выделением
- 🖥️ **Полный экран** одним кликом
- 📋 **Копирование в буфер** без сохранения файлов
- 🎨 **Интерактивное меню** с иконками Nerd Fonts
- 🔔 **Уведомления** о выполнении операций
- 📁 **Гибкое сохранение** с возможностью указания имени файла

## 🚀 Быстрая установка

### 📦 Установка через install.sh (в стадии теста)

```bash
# Скачайте и запустите установочный скрипт
git clone https://github.com/NamakeKuma/nakushot.git
cd nakushot

chmod +x install.sh
sudo ./install.sh
```

### 🐧 Установка через PKGBUILD (Arch Linux)

```bash
# Клонируйте репозиторий
git clone https://github.com/NamakeKuma/nakushot.git
cd nakushot

# Соберите и установите пакет
makepkg -sric
```

## 🎮 Использование

### Командная строка
```bash
nakushot --area          # Захват выделенной области
nakushot --full          # Захват всего экрана
nakushot --copy-only     # Копирование в буфер обмена
nakushot --help          # Показать справку
```

### Интерактивное меню
```bash
nakushot  # Запуск без параметров открывает меню
```

**Меню включает:**
- Полный экран
- Выделить область  
- Указать имя файла
- Только буфер обмена

## 📋 Зависимости

| Пакет | Назначение | Установка |
|-------|------------|-----------|
| `grim` | Захват экрана | `sudo pacman -S grim` |
| `slurp` | Выделение области | `sudo pacman -S slurp` |
| `wl-clipboard` | Копирование в буфер | `sudo pacman -S wl-clipboard` |
| `wofi` | Диалоговое меню | `sudo pacman -S wofi` |
| `libnotify` | Уведомления | `sudo pacman -S libnotify` |
| `nerd-fonts` | Специальные символы | `sudo pacman -S ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono` |

## ⚙️ Настройка

## 🔄 Обновление

### Для установки через PKGBUILD
```bash
cd nakushot
git pull origin main
makepkg -sric
```

### Для установки через install.sh
```bash
# Просто перезапустите установочный скрипт
sudo ./install.sh
```

## 📜 Лицензия

Этот проект распространяется под лицензией MIT. Подробнее см. в файле [LICENSE](LICENSE).

## 🙏 Благодарности
- Иконки от [Nerd Fonts](https://www.nerdfonts.com/)
- Сообщество Wayland за вдохновение
