# Component: dotfiles
# Purpose: alias for dotfiles add
#          intentionally to use zsh fallback file-only completion because "git add" completion is broken with git bare repository
# Reference: https://stackoverflow.com/a/33191364
#            https://unix.stackexchange.com/questions/550559/zsh-file-autocompletion-with-bare-git-repo
function da() {
  git --git-dir="$XDG_DATA_HOME/dotfiles/" --work-tree="$HOME" add $@
}

# Use grealpath on macOS, realpath otherwise
if [[ "$(uname -s)" == "Darwin" ]]; then
  _realpath() { grealpath "$@"; }
else
  _realpath() { realpath "$@"; }
fi

# Component: 1password-cli
# Purpose: push a secret file to the 1password vault
function dspush() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  FILE_PATH_RELATIVE_TO_HOME=$(_realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(_realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"
  FILE_NAME=$(basename ${FILE_PATH_ABSOLUTE})

  echo "Pushing $FILE_PATH_ABSOLUTE"

  if [ ! -f "$FILE_PATH_ABSOLUTE" ]; then
    echo "File "$FILE_PATH_ABSOLUTE" not found locally"
    return 1
  fi

  if op document get "$TITLE" --vault "$VAULT" > /dev/null 2>&1; then
    op document edit "$TITLE" "$FILE_PATH_ABSOLUTE" --vault "$VAULT" --title "$TITLE" --file-name "$FILE_NAME"
  else
    op document create "$FILE_PATH_ABSOLUTE" --vault "$VAULT" --title "$TITLE" --file-name "$FILE_NAME"
  fi
}

# Component: 1password-cli
# Purpose: push all secret files that already exist in the 1password vault
function dspushall() {
  VAULT="dotfiles"
  TITLES=$(op document list --vault "$VAULT" --format json | jq -r '.[].title')

  echo $TITLES | while read title ; do
    FILE_PATH_ABSOLUTE="$HOME/${title#"~/"}"
    dspush "$FILE_PATH_ABSOLUTE"
  done
}

# Component: 1password-cli
# Purpose: pull a secret file from the 1password vault
function dspull() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  mkdir -p $(dirname ${INPUT_FILE_PATH})
  touch "$INPUT_FILE_PATH"
  FILE_PATH_RELATIVE_TO_HOME=$(_realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(_realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"

  echo "Pulling $FILE_PATH_ABSOLUTE"

  if op document get "$TITLE" --vault "$VAULT" > /dev/null 2>&1; then
    rm "$FILE_PATH_ABSOLUTE"
    op document get "$TITLE" --vault "$VAULT" --output "$FILE_PATH_ABSOLUTE" --force
  else
    echo "Item with the title \"$TITLE\" does not exist in the 1password vault"
  fi
}

# Component: 1password-cli
# Purpose: pull all secret files from the 1password vault
function dspullall() {
  VAULT="dotfiles"
  TITLES=$(op document list --vault "$VAULT" --format json | jq -r '.[].title')

  echo $TITLES | while read title ; do
    FILE_PATH_ABSOLUTE="$HOME/${title#"~/"}"
    dspull "$FILE_PATH_ABSOLUTE"
  done
}

# Component: 1password-cli
# Purpose: compare a secret file between remote and local
function dsdiff() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  FILE_PATH_RELATIVE_TO_HOME=$(_realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(_realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"

  echo "Comparing the remote secret with local file $FILE_PATH_ABSOLUTE"

  if [ ! -f "$FILE_PATH_ABSOLUTE" ]; then
    echo "File "$FILE_PATH_ABSOLUTE" not found locally"
    return 1
  fi

  if op document get "$TITLE" --vault "$VAULT" > /dev/null 2>&1; then
    op document get "$TITLE" --vault "$VAULT" | delta - "$FILE_PATH_ABSOLUTE"
  else
    echo "Item with the title \"$TITLE\" does not exist in the 1password vault"
  fi
}

# Component: 1password-cli
# Purpose: compare all secret files between remote and local
function dsdiffall() {
  VAULT="dotfiles"
  TITLES=$(op document list --vault "$VAULT" --format json | jq -r '.[].title')

  echo $TITLES | while read title ; do
    FILE_PATH_ABSOLUTE="$HOME/${title#"~/"}"
    dsdiff "$FILE_PATH_ABSOLUTE"
  done
}

# Component: 1password-cli
# Purpose: delete a secret file from the 1password vault
function dsdelete() {
  VAULT="dotfiles"
  INPUT_FILE_PATH="$1"
  FILE_PATH_RELATIVE_TO_HOME=$(_realpath --relative-to="$HOME" "$INPUT_FILE_PATH")
  FILE_PATH_ABSOLUTE=$(_realpath "$INPUT_FILE_PATH")
  TITLE="~/$FILE_PATH_RELATIVE_TO_HOME"

  echo "Deleting secret $TITLE"
  op document delete "$TITLE" --vault "$VAULT"
}

# Component: 1password-cli
# Purpose: list all secret files from the 1password vault
function dslist() {
  VAULT="dotfiles"
  op document list --vault "$VAULT" | (sed -u 1q; sort -k 2)
}

# Component: 1password-cli
# Purpose: fetch all ssh public keys from the 1password vault
function fetchkeys() {
  VAULT="dotfiles"
  KEY_TITLES=$(op item list --vault "$VAULT" --categories "SSH Key" --format json | jq -r '.[].title')

  echo $KEY_TITLES | while read key_title ; do
    PUBLIC_KEY_FILE_PATH_ABSOLUTE="$HOME/.ssh/$key_title.pub"
    echo "Fetching public key $PUBLIC_KEY_FILE_PATH_ABSOLUTE"
    op read "op://$VAULT/$key_title/public key" > "$PUBLIC_KEY_FILE_PATH_ABSOLUTE"
  done
}

function _agent_warn() {
  print -r -- "warning: $*" >&2
}

function _agent_source_mcp_env() {
  emulate -L zsh

  local env_file="$HOME/.config/agents/mcp.env"

  if [[ -f "$env_file" ]]; then
    setopt allexport
    source "$env_file"
    unsetopt allexport
    print -r -- "loaded: $env_file"
  else
    _agent_warn "$env_file not found; secret-backed MCP servers will be skipped"
  fi
}

function _agent_claude_mcp_exists() {
  claude mcp get "$1" > /dev/null 2>&1
}

function _agent_codex_mcp_exists() {
  codex mcp get "$1" > /dev/null 2>&1
}

function _agent_codex_config_has_mcp() {
  emulate -L zsh

  local name="$1"
  local config_file="$HOME/.codex/config.toml"

  [[ -f "$config_file" ]] && command grep -Fqx "[mcp_servers.$name]" "$config_file"
}

function _agent_codex_add_toml_mcp() {
  emulate -L zsh

  local name="$1"
  local body="$2"
  local config_file="$HOME/.codex/config.toml"

  if _agent_codex_mcp_exists "$name" || _agent_codex_config_has_mcp "$name"; then
    print -r -- "skip codex MCP: $name already exists"
    return 0
  fi

  mkdir -p "$HOME/.codex"
  touch "$config_file"
  {
    print -r -- ""
    print -r -- "[mcp_servers.$name]"
    print -r -- "$body"
  } >> "$config_file"
  print -r -- "added codex MCP: $name"
}

function _agent_toml_string() {
  emulate -L zsh

  local value="$1"

  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  print -r -- "\"$value\""
}

function agentskillssetup() {
  emulate -L zsh

  local script_path="$HOME/scripts/setup-agent-skills.zsh"

  if [[ -x "$script_path" ]]; then
    "$script_path"
  else
    _agent_warn "setup-agent-skills.zsh not found; skipping agent skills setup"
  fi
}

# Component: agents
# Purpose: prepare global Claude Code and Codex agent layout without touching auth state
function agentsetup() {
  emulate -L zsh

  agentskillssetup
  agentmcpsetup
}

# Component: agents
# Purpose: idempotently install global MCP servers for Claude Code and Codex
function agentmcpsetup() {
  emulate -L zsh

  _agent_source_mcp_env

  if command -v codex > /dev/null 2>&1; then
    if _agent_codex_mcp_exists "openaiDeveloperDocs"; then
      print -r -- "skip codex MCP: openaiDeveloperDocs already exists"
    else
      codex mcp add openaiDeveloperDocs --url https://developers.openai.com/mcp
    fi

    if [[ -n "${CONTEXT7_API_KEY:-}" ]]; then
      _agent_codex_add_toml_mcp "context7" $'url = "https://mcp.context7.com/mcp"\nenv_http_headers = { "CONTEXT7_API_KEY" = "CONTEXT7_API_KEY" }'
    else
      _agent_warn "CONTEXT7_API_KEY is not set; skipping codex MCP: context7"
    fi

    if [[ -n "${GOOGLE_MAPS_API_KEY:-}" ]]; then
      _agent_codex_add_toml_mcp "google-map" $'command = "mcp-google-map"\nargs = ["--stdio"]\nenv_vars = ["GOOGLE_MAPS_API_KEY"]'
    else
      _agent_warn "GOOGLE_MAPS_API_KEY is not set; skipping codex MCP: google-map"
    fi

    if [[ -n "${HA_MCP_URL:-}" ]]; then
      if _agent_codex_mcp_exists "ha-mcp"; then
        print -r -- "skip codex MCP: ha-mcp already exists"
      else
        _agent_codex_add_toml_mcp "ha-mcp" "url = $(_agent_toml_string "$HA_MCP_URL")"
      fi
    else
      _agent_warn "HA_MCP_URL is not set; skipping codex MCP: ha-mcp"
    fi
  else
    _agent_warn "codex command not found; skipping Codex MCP setup"
  fi

  if command -v claude > /dev/null 2>&1; then
    if _agent_claude_mcp_exists "openaiDeveloperDocs"; then
      print -r -- "skip claude MCP: openaiDeveloperDocs already exists"
    else
      claude mcp add --transport http --scope user openaiDeveloperDocs https://developers.openai.com/mcp
    fi

    if [[ -n "${CONTEXT7_API_KEY:-}" ]]; then
      if _agent_claude_mcp_exists "context7"; then
        print -r -- "skip claude MCP: context7 already exists"
      else
        claude mcp add-json --scope user context7 '{"type":"http","url":"https://mcp.context7.com/mcp","headers":{"CONTEXT7_API_KEY":"${CONTEXT7_API_KEY}"}}'
      fi
    else
      _agent_warn "CONTEXT7_API_KEY is not set; skipping claude MCP: context7"
    fi

    if [[ -n "${GOOGLE_MAPS_API_KEY:-}" ]]; then
      if _agent_claude_mcp_exists "google-map"; then
        print -r -- "skip claude MCP: google-map already exists"
      else
        claude mcp add-json --scope user google-map '{"type":"stdio","command":"mcp-google-map","args":["--stdio"],"env":{"GOOGLE_MAPS_API_KEY":"${GOOGLE_MAPS_API_KEY}"}}'
      fi
    else
      _agent_warn "GOOGLE_MAPS_API_KEY is not set; skipping claude MCP: google-map"
    fi

    if [[ -n "${HA_MCP_URL:-}" ]]; then
      if _agent_claude_mcp_exists "ha-mcp"; then
        print -r -- "skip claude MCP: ha-mcp already exists"
      else
        claude mcp add-json --scope user ha-mcp '{"type":"http","url":"${HA_MCP_URL}","oauth":{"clientId":"http://localhost:12345","callbackPort":12345}}'
      fi
    else
      _agent_warn "HA_MCP_URL is not set; skipping claude MCP: ha-mcp"
    fi
  else
    _agent_warn "claude command not found; skipping Claude MCP setup"
  fi
}

function _agentdoctor_command() {
  if command -v "$1" > /dev/null 2>&1; then
    print -r -- "ok: command $1"
  else
    print -r -- "missing: command $1"
  fi
}

function _agentdoctor_gh_auth() {
  if ! command -v gh > /dev/null 2>&1; then
    return 0
  fi

  if gh auth status > /dev/null 2>&1; then
    print -r -- "ok: gh auth"
  else
    print -r -- "missing: gh auth - run gh auth login"
  fi
}

function _agentdoctor_file() {
  local file_path="$1"
  local missing_message="$2"

  if [[ -e "$file_path" ]]; then
    print -r -- "ok: $file_path"
  else
    print -r -- "missing: $file_path - $missing_message"
  fi
}

function _agentdoctor_login_file() {
  local file_path="$1"
  local present_message="$2"
  local missing_message="$3"

  if [[ -e "$file_path" ]]; then
    print -r -- "ok: $file_path - $present_message"
  else
    print -r -- "missing: $file_path - $missing_message"
  fi
}

function _agentdoctor_skill_link() {
  emulate -L zsh

  local skill_name="$1"
  local canonical_path="$HOME/.agents/skills/$skill_name"
  local claude_path="$HOME/.claude/skills/$skill_name"
  local current_target

  if [[ -f "$canonical_path/SKILL.md" ]]; then
    print -r -- "ok: $canonical_path"
  elif [[ -e "$canonical_path" ]]; then
    print -r -- "blocked: $canonical_path exists but does not contain SKILL.md"
  else
    print -r -- "missing: $canonical_path - run agentskillssetup"
  fi

  if [[ -L "$claude_path" ]]; then
    current_target="$(readlink "$claude_path")"
    if [[ "$current_target" == "../../.agents/skills/$skill_name" || "$current_target" == "$canonical_path" ]]; then
      print -r -- "ok: $claude_path"
    else
      print -r -- "wrong: $claude_path -> $current_target"
    fi
  elif [[ -e "$claude_path" ]]; then
    print -r -- "blocked: $claude_path exists and is not a symlink"
  else
    print -r -- "missing: $claude_path - run agentskillssetup"
  fi
}

function _agentdoctor_skills() {
  emulate -L zsh

  local skill_name
  local skill_names=(
    gh-skill
    find-skills
    playwright-cli
    gws-shared
    gws-gmail
    gws-gmail-forward
    gws-gmail-read
    gws-gmail-reply
    gws-gmail-reply-all
    gws-gmail-send
    gws-gmail-triage
    gws-gmail-watch
    gws-sheets
    gws-sheets-append
    gws-sheets-read
    gws-drive
    gws-drive-upload
    gws-calendar
    gws-calendar-agenda
    gws-calendar-insert
    home-assistant-best-practices
  )

  for skill_name in "${skill_names[@]}"; do
    _agentdoctor_skill_link "$skill_name"
  done
}

function _agentdoctor_mcp_list() {
  local command_name="$1"

  if command -v "$command_name" > /dev/null 2>&1; then
    print -r -- ""
    print -r -- "$command_name MCP:"
    "$command_name" mcp list
  else
    print -r -- ""
    print -r -- "$command_name MCP: command not found"
  fi
}

# Component: agents
# Purpose: read-only diagnostics for global Claude Code and Codex setup
function agentdoctor() {
  emulate -L zsh

  print -r -- "Commands:"
  _agentdoctor_command "claude"
  _agentdoctor_command "codex"
  _agentdoctor_command "git"
  _agentdoctor_command "gh"
  _agentdoctor_command "npx"
  _agentdoctor_command "op"
  _agentdoctor_command "jq"
  _agentdoctor_command "playwright-cli"
  _agentdoctor_command "mcp-google-map"
  _agentdoctor_gh_auth

  print -r -- ""
  print -r -- "Files:"
  _agentdoctor_file "$HOME/.claude/CLAUDE.md" "run dotfiles checkout or review tracked agent docs"
  _agentdoctor_file "$HOME/.codex/AGENTS.md" "run dotfiles checkout or review tracked agent docs"
  _agentdoctor_login_file "$HOME/.codex/auth.json" "machine-local Codex auth state exists" "run codex login on this machine"
  _agentdoctor_login_file "$HOME/.claude.json" "local Claude config exists; run claude if onboarding/login is not complete" "run Claude Code once and complete onboarding/login"
  _agentdoctor_file "$HOME/.config/agents/mcp.env" "restore it with dspullall if secret-backed MCP is needed"

  print -r -- ""
  print -r -- "Skills:"
  _agentdoctor_skills

  _agentdoctor_mcp_list "claude"
  _agentdoctor_mcp_list "codex"
}
