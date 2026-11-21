# Humanize

Humanize — Ruby-библиотека для преобразования чисел в текстовое представление. Она умеет работать как через расширение Ruby core-классов, так и как через явный вызов `Humanize.format`, а также поддерживает несколько локалей.

## ✨ Особенности
- Преобразует целые, дробные и большие числа в строковое представление.
- Поддерживает очень большие значения вплоть до 156 цифр.
- Может расширять `Integer`, `Float` и `BigDecimal`.
- Предлагает альтернативный режим без monkey patching через `Humanize.format`.
- Имеет встроенную поддержку множества локалей, включая `:ru`, `:fr`, `:de`, `:jp` и другие.

## 🚀 Быстрый старт
### Установка
```bash
gem install humanize
```

### Использование с расширением Ruby core
```ruby
require 'humanize'

42.humanize
1001.humanize
0.001.humanize
```

### Использование без расширения core-классов
```ruby
require 'humanize/module'

Humanize.format(42)
Humanize.format(1001)
```

## 📁 Структура проекта
- `lib/humanize.rb` — основной entrypoint с подключением модуля и core extensions.
- `lib/humanize/module.rb` — функциональный API без расширения Ruby core.
- `lib/humanize/core_ext.rb` — monkey patching для числовых классов Ruby.
- `lib/humanize/locales` — реализации локалей.
- `lib/humanize/locales/constants` — словари и константы для языков.
- `spec` — тесты библиотеки.

## 🛠 Использование
### Настройка локали
```ruby
Humanize.configure do |config|
  config.locale = :ru
  config.decimals_as = :digits
end
```

### Явная локаль в вызове
```ruby
42.humanize(locale: :fr)
Humanize.format(1666, locale: :tr)
```

### Работа с десятичными значениями
```ruby
0.42.humanize(decimals_as: :digits)
Humanize.format(0.42, decimals_as: :number)
```

## 🧪 Технологии
- Ruby
- RubyGems
- BigDecimal
- I18n-style locale tables

Подпись относится к текущей версии проекта.

---

Автор: legenda  
Telegram: [@LEGENDA_SD](https://t.me/LEGENDA_SD)
