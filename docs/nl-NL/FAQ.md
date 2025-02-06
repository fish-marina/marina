<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="128px" height="128px"/>
<img align="left" width="0" height="128px"/>

# Veelgestelde vragen

> Marina-documentatie&nbsp;&bull;&nbsp;Ook beschikbaar in het
> <a href="../en-US/FAQ.md">🇺🇸</a>
> <a href="../es-ES/FAQ.md">🇪🇸</a>
> <a href="../pt-BR/FAQ.md">🇧🇷</a>
> <a href="../ru-RU/FAQ.md">🇷🇺</a>
> <a href="../uk-UA/FAQ.md">🇺🇦</a>
> <a href="../zh-CN/FAQ.md">🇨🇳</a>

<br>

Fijn dat u even de tijd neemt om de veelgestelde vragen door te nemen. Als uw vraag hierna nog niet beantwoord is, open dan een 'issue'.


## Wat is Marina en waarom zou ik het willen gebruiken?

Marina (MAR) is een _framework_ voor de [Fish-shell](http://fishshell.com/). MAR helpt u de configuratie te beheren en thema's en pakketten te installeren.


## Wat moet ik kennen om Marina te kunnen gebruiken?

_Niks_. Installeer Marina en gebruik Fish zoals gebruikelijk. Typ `mar help` als u iets nieuws wilt leren.


## Wat zijn Marina-pakketten?

Marina-pakketten zijn thema's of plug-ins, geschreven in fish, die de kernfunctionaliteit uitbreiden, code uitvoeren tijdens het opstarten, automatische aanvullingen van veelgebruikte programma's toevoegen, etc.


## Wat voor Marina-pakketten zijn er zoal beschikbaar?

Er zijn 3 soorten pakketgroepen:

1. Configuratiehulpmiddelen. Een voorbeeld hiervan is [`pkg-pyenv`](https://github.com/oh-my-fish/pkg-pyenv), dat controleert of `pyenv` aanwezig is op uw systeem en `(pyenv init - | psub)` uitvoert tijdens het opstarten.

2. Thema's. Bekijk de [themagalerij](https://github.com/oh-my-fish).

3. Traditionele shell-hulpmiddelen. Een voorbeeld hiervan is [`pkg-copy`](https://github.com/oh-my-fish/pkg-copy), een klembordbeheerder die op zowel Linux als macOS werkt.


## Wat doet Marina precies?

+ Voert `$MAR_CONFIG/before.init.fish` uit (indien beschikbaar).

+ Laadt automatisch pakketten en thema's uit `$MAR_PATH/`.

+ Laadt automatisch uw configuratiepad. Standaard is dit `~/.config/mar`, maar dit is instelbaar middels `$MAR_CONFIG`.

+ Laadt automatisch de `functions`-map uit `$MAR_PATH` en `$MAR_CONFIG`

+ Voert `$MAR_CONFIG/init.fish` uit (indien beschikbaar).


## Hoe kan ik een reeds aanwezige Marina-installatie bijwerken?

> :warning: Maak een back-up van uw verborgen bestanden en andere belangrijke gegevens.

```
curl -L github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | sh
```

U kunt `$fish_path` nu veilig verwijderen.

```fish
rm -rf "$fish_path"
```


## Hoe stel ik Fish in als mijn standaardshell?

Voeg Fish toe aan `/etc/shells`:

```sh
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
```

en schakel over:

```sh
chsh -s /usr/local/bin/fish
```

Indien gewenst kunt u altijd terug naar de vorige standaardshell:
> Vervang, indien nodig, `/bin/bash` door `/bin/tcsh` of `/bin/zsh`.

```sh
chsh -s /bin/bash
```
