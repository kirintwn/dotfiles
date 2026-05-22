# Dotfiles

My lovely dotfiles, managed with git bare repository, adhering [XDG Base Directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory) as much as possible.

## Content (roughly)

- ZSH config

  - zinit config

- Git config

- Misc config

  - alacritty config
  - bat config
  - tealdeer config
  - k9s config
  - i3 config
  - karabiner (for MacOS)
  - yabai config (for MacOS)
  - skhd config (for MacOS)

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
  - `eza`
  - `fd`
  - `ripgrep`
  - `fzf`
  - `delta`

- Installation:

  1. you can install some prerequisites & optional packages via [`scripts/install-packages/paru.sh`](scripts/install-packages/paru.sh) if you are using Arch-based distros, or [`scripts/install-packages/brew.sh`](scripts/install-packages/brew.sh) if you are using MacOS.

  2. Clone & checkout

     You can use [`scripts/setup.zsh`](scripts/setup.zsh) by

     ```bash
     curl -sL https://raw.githubusercontent.com/kirintwn/dotfiles/main/scripts/setup.zsh | zsh
     ```

     or clone manually using the commands below:

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
     please see [`scripts/setup.zsh`](scripts/setup.zsh)
     as a reference.

  5. Modify `~/.config/i3/i3blocks.conf` & `~/.config/i3/config`, can use `~/.config/i3/config_endeavouros` as a reference.

## Agent setup

Claude Code and Codex global agent setup is managed as portable dotfiles plus machine-local auth state.

Restore on a new personal machine:

```bash
# Install package dependencies first so gh, npx, codex, claude, op, and jq exist.
dspullall
agentsetup
agentdoctor
```

Then log in locally on each machine:

```bash
# Log in to GitHub CLI for gh-based workflows.
gh auth login
gh auth status

# Pick the Codex login flow that fits the machine.
codex login
codex login --device-auth

# Run Claude Code once and finish login/onboarding.
claude
```

Run the local login steps even if generated config files already exist; MCP setup can create local config before auth is complete.

Secret-backed MCP values belong in `~/.config/agents/mcp.env`. Restore it through `dspullall`; when adding or updating it, keep using the existing secret flow:

```bash
mkdir -p ~/.config/agents
[[ -e ~/.config/agents/mcp.env ]] || install -m 600 /dev/null ~/.config/agents/mcp.env
chmod 600 ~/.config/agents/mcp.env
$EDITOR ~/.config/agents/mcp.env
dspush ~/.config/agents/mcp.env
```

Store it in the `dotfiles` 1Password vault as a document titled `~/.config/agents/mcp.env`. `dspullall` restores that document back to the same local path.

Use shell-safe assignments; omit values for MCP servers you do not want installed:

```bash
CONTEXT7_API_KEY='...'
```

`agentsetup` installs curated global skills with `npx skills`, then configures MCP. Third-party skill contents are generated local state and are not tracked.

```bash
agentskillssetup
agentmcpsetup
```

Generated skills live under `~/.agents/skills`; Claude Code receives symlinks under `~/.claude/skills`.

The `skills` CLI is invoked through `npx` and does not need a global npm install. `@cablate/mcp-google-map` is installed globally because the Google Maps MCP config launches `mcp-google-map --stdio` directly.

## Caveats

- Some packages will failed to write config / data if the target directory not exists.
  Please see comments in `.zshenv` to provision those directories or run [`scripts/setup.zsh`](scripts/setup.zsh).

- If some environment variables are not loaded in `~/.zshenv`, by copying the file using `sudo cp ~/.zshenv /etc/zsh/zshenv # (or /etc/zshenv for MacOS)` may solve the problem.

## References

- [[ArchLinux Wiki] XDG Base Directory](https://wiki.archlinux.org/index.php/XDG_Base_Directory)

- [[Atlassian] The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)

- [Zinit Offical Wiki](https://zdharma.org/zinit/wiki/)

#### Original written: [@lesley-tw](https://github.com/lesley-tw)

#### Edited by: [@kirintwn](https://github.com/kirintwn)
