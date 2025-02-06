<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="192px" height="192px"/>
<img align="left" width="0" height="192px" hspace="10"/>

> The <a href="http://fishshell.com">Fishshell</a> Framework

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE.md) [![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](http://fishshell.com) [![Travis Build Status](http://img.shields.io/travis/oh-my-fish/oh-my-fish.svg?style=flat-square)](https://travis-ci.org/oh-my-fish/oh-my-fish) [![Slack Status](https://oh-my-fish-slack.herokuapp.com/badge.svg)](https://oh-my-fish-slack.herokuapp.com)

Marina надає базову інфраструктуру, щоб забезпечити встановлення пакетів які розширюють та модифікують зовнішній вигляд вашої оболонки. Він швидкий, розширюваний та легкий у використанні.

> Also in&nbsp;
> <a href="../../README.md">🇺🇸</a>
> <a href="../es-ES/README.md">🇪🇸</a>
> <a href="../nl-NL/README.md">🇳🇱</a>
> <a href="../pt-BR/README.md">🇧🇷</a>
> <a href="../ru-RU/README.md">🇷🇺</a>
> <a href="../zh-CN/README.md">🇨🇳</a>

<br>

# Встановлення

```fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
mar help
```

Або _завантажте_ та запустіть власноруч:

```fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > install
fish install
```

# Туторіал

Marina містить невелику утиліту `mar` для завантаження та встановлення нових пакетів та тем.

#### `mar update`

Оновлює фреймворк та встановлені пакети.

#### `mar install` _`[<name>|<url>]`_

Встановлює один _або більше_ пакетів.

- Ви можете встановити пакети по URL за допомогою команди `mar install URL`
- Коли викликається без аргументів, встановлює відсутні пакети із [bundle](#Файли-конфігурації).

#### `mar list`

Список встановлених пакетів.

#### `mar theme` _`<theme>`_

Задіює тему. Для того щоб отримати список доступних тем, виконайте `mar theme`. Також ви можете попередньо проглянути усі [доступні теми](../Themes.md) перед встановленням.

#### `mar remove` _`<name>`_

Видаляє тему або пакет.

> Пакети, підписані на події `uninstall_<pkg>`, повідомлюються перед тим, як пакет буде видалено, завдяки цьому може бути реалізоване кастомне очищення ресурсів. Читайте детальніше про [видалення](Packages.md#Видалення) пакетів в Marina.

#### `mar new pkg | theme` _`<name>`_

Генерує новий пакет чи тему.

> Створює нову директорію у `$MAR_CONFIG/{pkg | themes}/` із шаблоном.

#### `mar submit` _`pkg/<name>`_ _`[<url>]`_

Додає новий пакет. Щоб додати тему, використовуйте `mar submit` _`themes/<name>`_ _`<url>`_.

Переконайтесь що [надіслали нам PR][mar-pulls-link], щоб оновити реєстр.

#### `mar doctor`

Використовуйте для усунення проблем перед [створенням нового issue][mar-issues-new].

#### `mar destroy`

Видаляє Marina.

# Для досвідчених

Встановлювач Marina поміщає код для старта у вашому файлі конфігурації (`~/.config/fish/config.fish`).

## Стартап

Кожного разу, кколи ви відкриваєте новий shell, стартап код ініціалізує Marina шлях встановлення і _конфіг_ шлях (`~/.config/mar` за замовчуванням), потім запускає [`init.fish`](../../init.fish) скрипт, який автоматично завантажує пакети, теми та ваші кастомні init файли. Із деталями можна ознайомитися у [FAQ](FAQ.md#Що саме робить Marina?).

## Файли конфігурації

Каталог `$MAR_CONFIG` надає стан користувача Marina, і це чудовий кандидат для додаваняня у ваші dotfiles і/або в систему контролю версій. Тут міститься чотири важливих файли:

- __`theme`__ - Поточна тема
- __`bundle`__ - Список встановлених пакетів/тем
- __`init.fish`__ - Кастомний скрипт, що запускається після запуску shell
- __`before.init.fish`__ - Кастомний скрипт, що запускається перед запуском shell

Наполеглево рекомендується додавати свої стартап команди у файл `init.fish` замість `~/.config/fish/config.fish`, так как як це дозволяє вам тримати весь каталог `$MAR_CONFIG` в системі контролю версій.

Якщо вам потрібно запускати стартап команди *перед* тим, як Marina почне завантажувати плагіни, помістіть їх в `before.init.fish`. Якщо ви не впевнені, як правило, краще помістити їх в `init.fish`.

### Про `bundle`

Кожного разу, коли пакет/тема встановлюється чи видаляється, `bundle` файл оновлюється. Також ви можете відредагувати його і поітм запустити `mar install` щоб зафіксувати зміни. Будь ласка, зверніть увагу: якщо пакети/теми додані в `bundle`, вони автоматично встановлюються, в той час як пакети/теми, видалені із `bundle` файлу, не видаляються із користувацької папки.

## Створення пакетів

Marina використовує сучасну та добре виділену архітектуру плагінів для спрощення їх розробки, включаючи події ініціалізації/видалення та функції автозавантаження.

[Дивіться документацію](Packages.md), щоб дізнатися детальніше.

[fishshell]: http://fishshell.com

[contributors]: https://github.com/oh-my-fish/oh-my-fish/graphs/contributors

[mar-pulls-link]: https://github.com/oh-my-fish/oh-my-fish/pulls

[mar-issues-new]: https://github.com/oh-my-fish/oh-my-fish/issues/new
