<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="192px" height="192px"/>
<img align="left" width="0" height="192px" hspace="10"/>


> The <a href="http://fishshell.com">Fishshell</a> Framework

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE.md) [![Fish Shell Version](https://img.shields.io/badge/fish-≥v2.2.0-007EC7.svg?style=flat-square)](http://fishshell.com) [![Travis Build Status](http://img.shields.io/travis/oh-my-fish/oh-my-fish.svg?style=flat-square)](https://travis-ci.org/oh-my-fish/oh-my-fish) [![Slack Status](https://oh-my-fish-slack.herokuapp.com/badge.svg)](https://oh-my-fish-slack.herokuapp.com)


O Marina fornece infra-estrutura básica para permitir que você instale pacotes que estendam ou modifiquem a aparência do seu shell. É rápido, extensível e fácil de usar.

> Also in&nbsp;
> <a href="../../README.md">🇺🇸</a>
> <a href="../es-ES/README.md">🇪🇸</a>
> <a href="../nl-NL/README.md">🇳🇱</a>
> <a href="../ru-RU/README.md">🇷🇺</a>
> <a href="../uk-UA/README.md">🇺🇦</a>
> <a href="../zh-CN/README.md">🇨🇳</a>

<br>

## Instalação

```fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
mar help
```

Ou baixar e executar:

```fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > install
fish install
```

## Tutorial

O Marina inclui um pequeno utilitário `mar` para buscar e instalar novos pacotes e temas.

#### `mar update` _`[mar]`_ _`[<package>...]`_

Atualiza o Marina, todos os pacotes do repositório, e todos os pacotes instalados.

- Quando chamado sem argumentos, atualiza o framework e todos os pacotes instalados.
- Voce pode escolher atualizar somente o framework, executando `mar update mar`.
- Para uma atualização seletiva de pacotes, liste apenas os nomes dos pacotes que pretende atualizar. Você ainda pode incluir "mar" na lista para atualizar o framework também.

#### `mar install` _`[<name>|<url>]`_

Instala um _ou mais_ pacotes.

- Voce pode instalar pacotes diretamente pela URL via `mar install URL`
- Quando chamado sem argumentos, instala os pacotes ausentes do [bundle](#dotfiles).

#### `mar repositories` _`[list|add|remove]`_

Gerencie os repositórios de pacotes instalados pelo usuário. Repositórios de pacotes são onde os pacotes vêm a ser usados por comandos como `mar install`. Por padrão o [repositorio oficial](https://github.com/oh-my-fish/packages-main) é sempre instalado e disponível.

#### `mar list`

Lista dos pacotes instalados.

#### `mar theme` _`<theme>`_

Aplica um tema. Para lista os temas disponíveis, digite `mar theme`. Você pode também [visualizar os temas disponíveis](/docs/Themes.md) antes da instalação.

#### `mar remove` _`<name>`_

Remove um tema ou pacote.

> Os pacotes podem usar ganchos de desinstalação, portanto, a limpeza personalizada de recursos pode ser feita ao desinstalá-la. Ver [Desinstalação](/docs/en-US/Packages.md#uninstall) para mais informações.

#### `mar reload`

Recarrega Marina e todos os plugins usando `exec` para substituir o processo shell atual com um novo.

> Este comando tenta ser o mais seguro possivel, suavizando os efeitos colaterais causados pelo `exec` e impedindo o recarregamento no caso de processos em plano de fundo.

#### `mar new pkg | theme` _`<name>`_

Cria uma estrutura para um novo pacote ou tema.

> Cria um novo diretorio `$MAR_CONFIG/{pkg | themes}/` com um template.

#### `mar search` _`-t|--theme / -pkg|--package`_ _`<name>`_

Procura no banco de dados de Marina para um determinado pacote, tema ou ambos. Ele também suporta pesquisa fuzzy, então se você não tem certeza do nome, você pode simplesmente buscar `mar search simple`.

#### `mar channel`

Obtém ou altera o canal de atualização.

Dois canais estão disponíveis por padrão: o canal `stable` que fornece atualizações estáveis com a última versão etiquetada de Marina e `dev` que fornece as últimas alterações em desenvolvimento. O canal de atualização atualmente definido determina para qual versão `mar update` atualizará.

#### `mar doctor`

Use para solucionar problemas antes de [abrir um issue][mar-issues-new].

#### `mar destroy`

Desinstala o Marina.

## Avançado

O instalador do Marina coloca seu código de inicialização no arquivo de configuração do fish (`~/.config/fish/config.fish`).

### Inicialização

Toda vez que você abre um novo shell, o código de inicialização define o diretório de instalação do Marina e o caminho da _configuração_ (~/.config/mar por padrão), chamando o script init.fish posteriormente, o qual carrega os pacotes, temas e
seus arquivos de inicialização personalizados.

Para mais informações confira a [FAQ](FAQ.md#o-que-exatamente-o-oh-my-fish-faz).

### Dotfiles (arquivos de configuração)

O diretório `$ MAR_CONFIG` representa o estado do usuário de Marina. É o candidato perfeito para ser adicionado aos seus dotfiles e / ou ao sistema de controle de versão. Existem quatro arquivos importantes:

- __`theme`__ - O tema atual
- __`bundle`__ - Lista atual dos  pacotes/temas instalados
- __`init.fish`__ - Script personalizado que é executado depois de executar shell
- __`before.init.fish`__ - Script personalizado que é executado antes de executar shell
- __`key_bindings.fish`__ - Teclas de atalho customizadas onde você pode usar o comando `bind` livremente.

É altamente recomendado que customize os comandos de inicialização no arquivo `init.fish` invés do `~/.config/fish/config.fish`, com isso permite a você manter todo `$MAR_CONFIG` diretamente sobre o controle de versão.

Se você precisar executar comandos de inicialização *antes* Marina iniciar os plugins, coloque eles em `before.init.fish`. Se está inseguro, é melhor coloca-los em `init.fish`.

#### Alterando variáveis em `init.fish`

Um dos mais comuns comandos de inicialização usados no `init.fish` é a definição de variáveis. Muito provavelmente, essas variáveis precisam estar disponíveis em qualquer sessão do shell. Para conseguir isso, defina-os globalmente. Por exemplo:

```fish
# Golang developers might need this one
set -xg GOPATH $HOME/gocode

# Python developers otherwise
set -xg PYTHONDONTWRITEBYTECODE 1
```

#### Sobre o bundle

A todo momento pacotes/temas são instalados ou removidos, o arquivo `bundle` é atualizado. Você também pode editar eles manualmente e executar `mar install` apos concluir as alterações. Por favor note que enquanto pacotes/temas adicionados ao bundle são automaticamente instalados, um pacote/tema removido do bundle não sera removido das instalações do usuário.

## Criando Pacotes

O Marina usa uma arquitetura moderna e bem definida de plugins para facilitar o desenvolvimento de um plugin, incluindo eventos de inicialização/exclusão, funções de backup. [consulte a documentação](docs/en-US/Packages.md) para mais detalhes.


[fishshell]: http://fishshell.com
[contributors]: https://github.com/oh-my-fish/oh-my-fish/graphs/contributors
[mar-pulls-link]: https://github.com/oh-my-fish/oh-my-fish/pulls
[mar-issues-new]: https://github.com/oh-my-fish/oh-my-fish/issues/new
[releases]: https://github.com/oh-my-fish/oh-my-fish/releases
