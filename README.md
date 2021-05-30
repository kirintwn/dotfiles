# Dotfiles

My lovely dotfiles, managed with git bare repository, adhering [XDG Base Directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory) as much as possible.

## Content (roughly)

- ZSH config

  - zinit config

- Git config

- NeoVim config

- Misc config

  - Terminal emulator config (iterm2, Alacritty, windows terminal...)
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

- Prerequisites:

  - `curl`
  - `wget`
  - `git`
  - `svn`
  - `unzip`
  - `GnuPG`
  - `zsh`
  - `python`
  - `lua`
  - `nodejs`
  - `bat`
  - `exa`
  - `fd`
  - `ripgrep`
  - `fzf`
  - `delta`

- Installation:

  1. you can install some prerequisites & optional packages via [`scripts/install-packages/paru.sh`](scripts/install-packages/paru.sh) if you are using Arch-based distros, or [`scripts/install-packages/brew.sh`](scripts/install-packages/brew.sh) if you are using MacOS.

  2. Clone & checkout

  ```bash
  export XDG_DATA_HOME="$HOME/.local/share"
  alias dotfiles="git --git-dir=$XDG_DATA_HOME/dotfiles/ --work-tree=$HOME"
  git clone --bare git@github.com:kirintwn/dotfiles.git "$XDG_DATA_HOME/dotfiles"

  # please remove all conflict files in $HOME before running dotfiles checkout
  dotfiles checkout
  dotfiles config --local status.showUntrackedFiles no
  ```

  3. Open a new zsh shell, wait `zinit` provisioning (would take a few minutes).

  4. Create some directories for some program to use XDG base directory,
     please see [`scripts/provisioning/create-xdg-dir.sh`](scripts/provisioning/create-xdg-dir.sh)
     as a reference.

  5. Install some packages dependent on `node.js` & `python`,
     please see [`scripts/install-packages/npm.sh`](scripts/install-packages/npm.sh)
     & [`scripts/install-packages/pip.sh`](scripts/install-packages/pip.sh) as a reference.

  6. you can now run `:checkhealth provider` in neovim to see if it works correctly.

## Caveats

- Some packages will failed to write config / data if the target directory not exists.
  Please see comments in `.zshenv` to provision those directories or run [`scripts/provisioning/create-xdg-dir.sh`](scripts/provisioning/create-xdg-dir.sh).

- Some neovim's plugins needs nodejs / python's neovim packages.
  Please install those packages via scripts in [`scripts/install-packages/pip.sh`](scripts/install-packages/pip.sh)
  & [`scripts/install-packages/npm.sh`](scripts/install-packages/npm.sh).

- If some environment variables are not loaded in `~/.zshenv`, by copying the file using `sudo cp ~/.zshenv /etc/zsh/zshenv # (or /etc/zshenv for MacOS)` may solve the problem.

## References

- [Neovim Shortcuts By @lesley-tw](https://github.com/lesley-tw/.dotfiles#neovim-shortcuts)

- [[ArchLinux Wiki] XDG Base Directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory)

- [[Atlassian] The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)

- [Zinit Offical Wiki](https://zdharma.org/zinit/wiki/)

#### Original written: [@lesley-tw](https://github.com/lesley-tw)

#### Edited by: [@kirintwn](https://github.com/kirintwn)
