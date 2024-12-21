# try-love2d-lua

## Install local environment

We use [devbox](https://www.jetify.com/devbox) to install the necesary packages
and [mise](https://mise.jdx.dev/) to install missing packages and run tasks.

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

#### Run a task

To see available tasks or executed one of them, run with this command:

```sh
mise run
```
