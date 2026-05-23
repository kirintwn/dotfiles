# Component: agents
# Purpose: global Claude Code and Codex setup helpers

function _agent_warn() {
  print -r -- "warning: $*" >&2
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
# Purpose: idempotently install global MCP servers for Claude Code and Codex
function agentmcpsetup() {
  emulate -L zsh

  local script_path="$HOME/scripts/setup-agent-mcp.zsh"

  if [[ -x "$script_path" ]]; then
    "$script_path"
  else
    _agent_warn "setup-agent-mcp.zsh not found; skipping agent MCP setup"
  fi
}

# Component: agents
# Purpose: prepare global Claude Code and Codex agent layout without touching auth state
function agentsetup() {
  emulate -L zsh

  agentskillssetup
  agentmcpsetup
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
