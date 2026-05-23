#!/usr/bin/env zsh

set -u

function warn() {
  print -r -- "warning: $*" >&2
}

function source_mcp_env() {
  emulate -L zsh

  local env_file="$HOME/.config/agents/mcp.env"

  if [[ -f "$env_file" ]]; then
    setopt allexport
    source "$env_file"
    unsetopt allexport
    print -r -- "loaded: $env_file"
  else
    warn "$env_file not found; secret-backed MCP servers will be skipped"
  fi
}

function claude_mcp_exists() {
  claude mcp get "$1" > /dev/null 2>&1
}

function codex_mcp_exists() {
  codex mcp get "$1" > /dev/null 2>&1
}

function codex_config_has_mcp() {
  emulate -L zsh

  local name="$1"
  local config_file="$HOME/.codex/config.toml"

  [[ -f "$config_file" ]] && command grep -Fqx "[mcp_servers.$name]" "$config_file"
}

function toml_string() {
  emulate -L zsh

  local value="$1"

  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  print -r -- "\"$value\""
}

function codex_add_toml_mcp() {
  emulate -L zsh

  local name="$1"
  local body="$2"
  local config_file="$HOME/.codex/config.toml"

  if codex_mcp_exists "$name" || codex_config_has_mcp "$name"; then
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

source_mcp_env

if command -v codex > /dev/null 2>&1; then
  if codex_mcp_exists "openaiDeveloperDocs"; then
    print -r -- "skip codex MCP: openaiDeveloperDocs already exists"
  else
    codex mcp add openaiDeveloperDocs --url https://developers.openai.com/mcp
  fi

  if [[ -n "${CONTEXT7_API_KEY:-}" ]]; then
    codex_add_toml_mcp "context7" $'url = "https://mcp.context7.com/mcp"\nenv_http_headers = { "CONTEXT7_API_KEY" = "CONTEXT7_API_KEY" }'
  else
    warn "CONTEXT7_API_KEY is not set; skipping codex MCP: context7"
  fi

  if [[ -n "${GOOGLE_MAPS_API_KEY:-}" ]]; then
    codex_add_toml_mcp "google-map" $'command = "mcp-google-map"\nargs = ["--stdio"]\nenv_vars = ["GOOGLE_MAPS_API_KEY"]'
  else
    warn "GOOGLE_MAPS_API_KEY is not set; skipping codex MCP: google-map"
  fi

  if [[ -n "${HA_MCP_URL:-}" ]]; then
    if codex_mcp_exists "ha-mcp"; then
      print -r -- "skip codex MCP: ha-mcp already exists"
    else
      codex_add_toml_mcp "ha-mcp" "url = $(toml_string "$HA_MCP_URL")"
    fi
  else
    warn "HA_MCP_URL is not set; skipping codex MCP: ha-mcp"
  fi
else
  warn "codex command not found; skipping Codex MCP setup"
fi

if command -v claude > /dev/null 2>&1; then
  if claude_mcp_exists "openaiDeveloperDocs"; then
    print -r -- "skip claude MCP: openaiDeveloperDocs already exists"
  else
    claude mcp add --transport http --scope user openaiDeveloperDocs https://developers.openai.com/mcp
  fi

  if [[ -n "${CONTEXT7_API_KEY:-}" ]]; then
    if claude_mcp_exists "context7"; then
      print -r -- "skip claude MCP: context7 already exists"
    else
      claude mcp add-json --scope user context7 '{"type":"http","url":"https://mcp.context7.com/mcp","headers":{"CONTEXT7_API_KEY":"${CONTEXT7_API_KEY}"}}'
    fi
  else
    warn "CONTEXT7_API_KEY is not set; skipping claude MCP: context7"
  fi

  if [[ -n "${GOOGLE_MAPS_API_KEY:-}" ]]; then
    if claude_mcp_exists "google-map"; then
      print -r -- "skip claude MCP: google-map already exists"
    else
      claude mcp add-json --scope user google-map '{"type":"stdio","command":"mcp-google-map","args":["--stdio"],"env":{"GOOGLE_MAPS_API_KEY":"${GOOGLE_MAPS_API_KEY}"}}'
    fi
  else
    warn "GOOGLE_MAPS_API_KEY is not set; skipping claude MCP: google-map"
  fi

  if [[ -n "${HA_MCP_URL:-}" ]]; then
    if claude_mcp_exists "ha-mcp"; then
      print -r -- "skip claude MCP: ha-mcp already exists"
    else
      claude mcp add-json --scope user ha-mcp '{"type":"http","url":"${HA_MCP_URL}","oauth":{"clientId":"http://localhost:12345","callbackPort":12345}}'
    fi
  else
    warn "HA_MCP_URL is not set; skipping claude MCP: ha-mcp"
  fi
else
  warn "claude command not found; skipping Claude MCP setup"
fi
