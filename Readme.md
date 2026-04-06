Basic system environment settings.

zsh
===
  - Install _zsh_
  - In _zsh_, clone _zprezto_ by:
    ```sh
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    ```
  - link necessary files:
    ```sh
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done
    ```
  - Install p10k. Add `zstyle :prezto:module:prompt theme powerlevel10k` to `~/.zpreztorc`.
  - Install _zsh-syntax-hightlighting_ and _zsh-autosuggestions_ system package.
  - Enable syntax hightlighting by add the following to **the end of .zshrc**:
    ```sh
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ```

### Note
  - File `~/.zpreztorc` is symbolic link.
