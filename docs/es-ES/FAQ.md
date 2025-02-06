<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="128px" height="128px"/>
<img align="left" width="0" height="128px"/>

# FAQ

> La documentación de Marina&nbsp;&bull;&nbsp;También disponible en
> <a href="../en-US/FAQ.md">🇺🇸</a>
> <a href="../nl-NL/FAQ.md">🇳🇱</a>
> <a href="../pt-BR/FAQ.md">🇧🇷</a>
> <a href="../ru-RU/FAQ.md">🇷🇺</a>
> <a href="../uk-UA/FAQ.md">🇺🇦</a>
> <a href="../zh-CN/FAQ.md">🇨🇳</a>

<br>

Gracias por dedicar tiempo para leer este apartado de preguntas frecuentes (FAQ). Siéntete libre de crear un nuevo _issue_ si su pregunta no está respondida
en este documento.


## ¿Qué es Marina y por qué lo quiero?

Marina es un _framework_ para [Fishshell](http://fishshell.com/). Le ayudará a gestionar su configuración, los temas y paquetes.


## ¿Qué necesito conocer para utilizar Marina?

_Nada_. Puede instalar Marina y seguir utilizando Fish de manera normal. Cuando este listo para aprender más simplemente escriba en la línea de comandos `mar help`.


## ¿Qué son los paquetes Marina?

Los paquetes Marina son temas o complementos escritos en fish que expanden las funcionalidades principales de la _shell_, ejecutan código durante la
inicialización, añaden auto completado para las utilidades más conocidas, etc.


## ¿Qué tipos de paquetes Marina existen?

Existen aproximadamente 3 tipos de paquetes:

1. Utilidades de configuración. Por ejemplo [`pkg-pyenv`](https://github.com/oh-my-fish/pkg-pyenv) comprueba si `pyenv` existe en su sistema y ejecuta
`(pyenv init - | psub)` por usted durante el arranque.

2. Temas. Echa un vistazo a nuestra [galería de temas](https://github.com/oh-my-fish).

3. Utilidades tradicionales para la _shell_. Por ejemplo [`pkg-copy`](https://github.com/oh-my-fish/pkg-copy), una utilidad de portapapeles compatible con
sistemas Linux and OSX.


## ¿Qué hace Marina exactamente?

+ Ejecuta `$MAR_CONFIG/before.init.fish` si está disponible.

+ Carga de manera automática los paquetes y temas instalados en la ruta `$MAR_PATH/`.

+ Carga de manera automática su ruta de configuración. `~/.config/mar` de manera predeterminada, pero configurable mediante `$MAR_CONFIG`.

+ Carga de manera automática cualquier directorio `functions` de las rutas `$MAR_PATH` y `$MAR_CONFIG`

+ Ejecuta `$MAR_CONFIG/init.fish` si está disponible.


## ¿Cómo puedo actualizar una instalación de Marina ya existente?

> :warning: Recuerde realizar primero una copia de seguridad de sus archivos de configuración (o _dotfiles_) y otros datos importantes.

```
curl -L github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | sh
```

Ahora puede eliminar con seguridad `$fish_path`.

```fish
rm -rf "$fish_path"
```


## ¿Cómo utilizo fish como mi _shell_ predeterminada?

Añada Fish a `/etc/shells`:

```sh
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
```

Haga que Fish sea su _shell_ predeterminada:

```sh
chsh -s /usr/local/bin/fish
```

Para volver a tener como predeterminada la _shell_ que utilizaba anteriormente:
> En el siguiente comando sustituya `/bin/bash` con `/bin/tcsh` o `/bin/zsh` según sea lo apropiado en su caso.

```sh
chsh -s /bin/bash
```
