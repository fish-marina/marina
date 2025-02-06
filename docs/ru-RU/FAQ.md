<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="128px" height="128px"/>
<img align="left" width="0" height="128px"/>

# FAQ

> Marina Documentation&nbsp;&bull;&nbsp;Also in
> <a href="../en-US/FAQ.md">🇺🇸</a>
> <a href="../es-ES/FAQ.md">🇪🇸</a>
> <a href="../nl-NL/FAQ.md">🇳🇱</a>
> <a href="../pt-BR/FAQ.md">🇧🇷</a>
> <a href="../uk-UA/FAQ.md">🇺🇦</a>
> <a href="../zh-CN/FAQ.md">🇨🇳</a>

<br>

Спасибо, что нашли время прочитать этот FAQ. Не стесняйтесь создавать новый Issue, если вы не нашли тут ответ на свой вопрос.


## Что такое Marina и зачем он мне нужен?

Marina это _фреймворк_ для [Fishshell](http://fishshell.com/). Он помогает вам управлять Вашими настройками, темами и пакетами.


## Что мне нужно знать, чтобы использовать Marina?

_Ничего_. Вы можете установить Marina и продолжать использовать Fish как обычно. Когда вы захотите узнать больше, просто наберите `mar help`.


## Что такое пакеты в Marina?

Пакеты в Marina - это темы и плагины, написанные на fish, которые наследуют базовую функциональность Shell, запускают код во время инициализации, добавляют автодополнение к известным утилитам и тд.


## Какие типы пакетов существуют в Marina?

Существует 3 основных вида пакетов:

1. Конфигурационные утилиты. Например, [`pkg-pyenv`](https://github.com/oh-my-fish/pkg-pyenv) проверяет, существует ли `pyenv` в вашей системе и запускает `(pyenv init - | psub)` для вас при запуске Fish.

2. Темы. Ознакомьтесь с [темами](https://github.com/oh-my-fish).

3. Традиционные утилиты оболочки. Например, [`pkg-copy`](https://github.com/oh-my-fish/pkg-copy) — утилита буфера обмена, совместимая с Linux и OSX.


## Что именно делает Marina?

+ Запускает `$MAR_CONFIG/before.init.fish`, если доступно.

+ Автозагрузка установленных пакетов и тем из `$MAR_PATH/`.

+ Автозагрузка пути к вашему конфигу. По умолчанию это `~/.config/mar` по умолчанию, но его можно настроить через `$MAR_CONFIG`.

+ Автозагрузка любых `функций` из `$MAR_PATH` и `$MAR_CONFIG`

+ Запускает `$MAR_CONFIG/init.fish`, если доступно.


## Как я могу обновить текущую версию Marina?

> :warning: Не забудьте сперва сделать резервную копию ваших dotfiles и других важных данных.

```
curl -L github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | sh
```

Теперь вы можете безопасно удалить `$fish_path`.

```fish
rm -rf "$fish_path"
```


## Как я могу использовать fish в качестве оболочки по умолчанию?

Добавьте Fish в `/etc/shells`:

```sh
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
```

Сделайте Fish вашей оболочкой по умолчанию:

```sh
chsh -s /usr/local/bin/fish
```

Чтобы обратно переключиться на оболочку по умолчанию:
> Замените `/bin/bash` с `/bin/tcsh` или `/bin/zsh` в соответствующих случаях.

```sh
chsh -s /bin/bash
```
