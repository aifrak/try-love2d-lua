# try-love2d-lua

Following tutotial from <https://sheepolution.com/learn/book/contents> to learn
[Lua](https://www.lua.org/) and [Love2D](https://love2d.org/).

All games are stacked on each other, because I was lazy to create a project for each of them.

There is also custom code to do some experiment.

## Install local environment

After clone this project, fetched the git submodules:

```sh
git submodule update --init --recursive
```

We use [devbox](https://www.jetify.com/devbox) to install the necessary packages.

Install [devbox](https://www.jetify.com/docs/devbox/quickstart/) (do it only once):

```sh
curl -fsSL https://get.jetpack.io/devbox | bash
```

Install `devbox`:

```sh
devbox install
```

Enter `devbox` shell:

```sh
devbox shell
```

`(devbox)` at the beginning of the prompt shows that you are inside a devbox
shell:

```sh
(devbox) /home/my-user/my-project$
```

### Post-install

#### Install Love2D on Windows

If you are using WSL, we need to install it on Windows and make it available from the WSL.

On Windows, install `love`:

```powershell
scoop install extras/love
```

#### Open VSCode

You can use the IDE of your choice inside a `devbox` shell. For example with
VSCode:

```sh
code .
```

#### Run the game (WSL)

```sh
love.exe src
```
