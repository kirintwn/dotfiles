# Dotfiles

My lovely dotfiles, managed with git bare repository, adhering [XDG Base Directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory) as much as possible.

## Content (roughly)

- ZSH config

  - zinit config
    - some binaries including asdf

- Git config

- NeoVim config

- Misc config

  - Terminal emulator config (iterm2, Alacritty, windows terminal...)
  - asdf config
  - bat config
  - tealdeer config
  - k9s config

- Scripts for provisioning & installation of some packages

## Git bare repository setup & usage

- Create a dotfiles folder to track dotfiles

  ```bash
  export XDG_DATA_HOME="$HOME/.local/share"
  git init --bare "$XDG_DATA_HOME/dotfiles"
  ```

- Add an alias `dotfiles` to your `.zshrc`

  ```bash
  export XDG_DATA_HOME="$HOME/.local/share"
  alias dotfiles="git --git-dir=$XDG_DATA_HOME/dotfiles/ --work-tree=$HOME"
  ```

- Set git status to hide untracked files

  ```bash
  dotfiles config --local status.showUntrackedFiles no
  ```

- Add files & commit

  ```bash
  dotfiles status

  # add .zshenv
  dotfiles add $HOME/.zshenv
  dotfiles commit -m "feat: add .zshenv"

  # add git config
  dotfiles add $HOME/.config/git/*
  dotfiles commit -m "feat: add git config files"

  dotfiles remote add origin git@github.com:kirintwn/dotfiles.git
  dotfiles push origin main
  ```

## Restore dotfiles to a new machine

- Prerequisites: `curl`, `wget`, `git`, `svn`, `unzip`, `GnuPG` & `zsh`

- Installation:

  1. Clone & checkout

  ```bash
  export XDG_DATA_HOME="$HOME/.local/share"
  alias dotfiles="git --git-dir=$XDG_DATA_HOME/dotfiles/ --work-tree=$HOME"
  git clone --bare git@github.com:kirintwn/dotfiles.git "$XDG_DATA_HOME/dotfiles"

  # please remove all conflict files in $HOME before running dotfiles checkout
  dotfiles checkout
  dotfiles config --local status.showUntrackedFiles no
  ```

  2. Open a new zsh shell, wait `zinit` provisioning (would take a few minutes).

  3. Create some directories for some program to use XDG base directory,
     please see [`scripts/provisioning/create-xdg-dir.sh`](scripts/provisioning/create-xdg-dir.sh)
     as a reference.

  4. Install programming languages with `asdf`,
     please see [`scripts/install-packages/asdf.sh`](scripts/install-packages/asdf.sh) as a reference.

  5. Install some packages dependent on `node.js` & `python`,
     please see [`scripts/install-packages/npm.sh`](scripts/install-packages/npm.sh)
     & [`scripts/install-packages/pip.sh`](scripts/install-packages/pip.sh) as a reference.

  6. you can now run `:checkhealth provider` in neovim to see if it works correctly.

  7. you can install some (optional) packages via [`scripts/install-packages/brew.sh`](scripts/install-packages/brew.sh)
     if you are using MacOS & Homebrew.

## Caveats

- Some packages will failed to write config / data if the target directory not exists.
  Please see comments in `.zshenv` to provision those directories.

- Zinit plugin `z.lua` needs `lua`, `lua` needs `asdf` & `asdf` needs `zinit`,
  so you should install `lua` via [`scripts/install-packages/asdf.sh`](scripts/install-packages/asdf.sh),
  then re-open a new shell to load `z.lua`.

- The installation of `Python` is via [`asdf-python`](https://github.com/danhper/asdf-python).
  Please see [common build problem in pyenv](https://github.com/pyenv/pyenv/wiki/Common-build-problems)
  if you encountered any problem.

- Neovim needs [`junegunn/vim-plug`](https://github.com/junegunn/vim-plug),
  please follow the [installation guide](https://github.com/junegunn/vim-plug#installation),
  and run `:PlugInstall` in neovim.

- Some neovim's plugins needs node.js / python's neovim packages.
  Please install those packages via scripts in [`scripts/install-packages/pip.sh`](scripts/install-packages/pip.sh)
  & [`scripts/install-packages/npm.sh`](scripts/install-packages/npm.sh).

- If some environment variables are not loaded in `~/.zshenv`, by copying the file using `sudo cp ~/.zshenv /etc/zshenv` may solve the problem.

## References

- [Neovim Shortcuts By @lesley-tw](https://github.com/lesley-tw/.dotfiles#neovim-shortcuts)

- [[ArchLinux Wiki] XDG Base Directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory)

- [[Atlassian] The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)

- [Zinit Offical Wiki](https://zdharma.org/zinit/wiki/)

#### Original written: [@lesley-tw](https://github.com/lesley-tw)

#### Edited by: [@kirintwn](https://github.com/kirintwn)
