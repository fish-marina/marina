<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="192px" height="192px"/>
<img align="left" width="0" height="192px" hspace="10"/>

> The <a href="http://fishshell.com">Fishshell</a> Framework

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE.md) [![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](http://fishshell.com) [![Travis Build Status](http://img.shields.io/travis/oh-my-fish/oh-my-fish.svg?style=flat-square)](https://travis-ci.org/oh-my-fish/oh-my-fish) [![Slack Status](https://oh-my-fish-slack.herokuapp.com/badge.svg)](https://oh-my-fish-slack.herokuapp.com)

Marina обеспечивает базовую инфраструктуру, чтобы обеспечить установку пакетов которые расширяют и модифицируют внешний вид вашей оболочки. Он быстрый, расширяемый и легкий в использовании.

> Also in&nbsp;
> <a href="../../README.md">🇺🇸</a>
> <a href="../es-ES/README.md">🇪🇸</a>
> <a href="../nl-NL/README.md">🇳🇱</a>
> <a href="../pt-BR/README.md">🇧🇷</a>
> <a href="../uk-UA/README.md">🇺🇦</a>
> <a href="../zh-CN/README.md">🇨🇳</a>

<br>

# Установка

```fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
mar help
```

Или _скачайте_ и запустите сами:

```fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > install
fish install
```

# Туториал

Marina содержит небольшую утилиту `mar` для загрузки и установки новых пакетов и тем.

#### `mar update`

Обновляет фреймворк и установленные пакеты.

#### `mar install` _`[<name>|<url>]`_

Устанавливает один _или более_ пакетов.

- Вы можете установить пакеты прямо по URL с помощью команды `mar install URL`
- Когда вызывается без аргументов, устанавливает отсутствующие пакеты из [bundle](#Файлы-конфигурации).

#### `mar list`

Список установленных пакетов.

#### `mar theme` _`<theme>`_

Применяет тему. Чтобы получить список доступных тем, введите `mar theme`. Также вы можете предварительно посмотреть [доступные темы](../Themes.md) перед установкой.

#### `mar remove` _`<name>`_

Удаляет тему или пакет.

> Пакеты, подписанные на событие `uninstall_<pkg>`, уведомляются перед тем, как пакет будет удален, поэтому может быть выполнена кастомная очистка ресурсов. Читайте подробнее про [удаление](Packages.md#Удаление) пакетов в Marina.

#### `mar new pkg | theme` _`<name>`_

Генерирует новый пакет или тему.

> Создает новый каталог в `$MAR_CONFIG/{pkg | themes}/` с шаблоном.

#### `mar submit` _`pkg/<name>`_ _`[<url>]`_

Добавляет новый пакет. Чтобы добавить тему, используйте `mar submit` _`themes/<name>`_ _`<url>`_.

Убедитесь что [отправили нам PR][mar-pulls-link], чтобы обновить реестр.

#### `mar doctor`

Используйте для устранения проблем перед [созданием нового issue][mar-issues-new].

#### `mar destroy`

Удаляет Marina.

# Продвинутый

Установщик Marina помещает код для старта в вашем конфиг файле (`~/.config/fish/config.fish`).

## Стартап

Каждый раз, когда вы открываете новый shell, стартап код инициализирует Marina путь установки и _конфиг_ путь (`~/.config/mar` по умолчанию), потом запускает [`init.fish`](../../init.fish) скрипт, который автоматически загружает пакеты, темы и ваши кастомные init файлы. С подробностями ознакомьтесь в [FAQ](FAQ.md#что именно делает Marina?).

## Файлы конфигурации

Директория `$MAR_CONFIG` представляет состояние пользователя Marina, и это превосходный кандидат для добавления в ваши dotfiles и/или в систему контроля версий. Это четыре важных файла:

- __`theme`__ - Текущая тема
- __`bundle`__ - Список установленных пакетов/тем
- __`init.fish`__ - Кастомный скрипт, который запускается после запуска shell
- __`before.init.fish`__ - Кастомный скрипт, который запускается перед запуском shell

Настоятельно рекомендуется добавлять свои стартап команды в файл `init.fish` вместо `~/.config/fish/config.fish`, так как это позволяет вам держать весь каталог `$MAR_CONFIG` в системе контроля версий.

Если вам нужно запускать стартап команды *перед* тем, как Marina начнет загружать плагины, поместите их в `before.init.fish`. Если вы не уверены, как правило, лучше поместить их в `init.fish`.

### О `bundle`

Каждый раз, когда пакет/тема устанавливается или удаляется, `bundle` файл обновляется. Также вы можете отредактировать его и потом запустить `mar install` чтобы зафиксировать изменения. Пожалуйста, обратите внимание: если пакеты/темы добавлены в `bundle`, они автоматически установятся, в то время как пакеты/темы, удаленные из `bundle` файла, не удалятся из пользовательской папки.

## Создание пакетов

Marina использует продвинутую и хорошо определенную архитектуру плагинов для упрощения их разработки, включая события инициализации/удаления и функции автозагрузки.

[Смотрите документацию](Packages.md), чтобы узнать подробнее.

[fishshell]: http://fishshell.com

[contributors]: https://github.com/oh-my-fish/oh-my-fish/graphs/contributors

[mar-pulls-link]: https://github.com/oh-my-fish/oh-my-fish/pulls

[mar-issues-new]: https://github.com/oh-my-fish/oh-my-fish/issues/new
