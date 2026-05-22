#!/usr/bin/env zsh

set -euo pipefail

function require_command() {
  local command_name="$1"

  if ! command -v "$command_name" > /dev/null 2>&1; then
    print -r -- "missing command: $command_name" >&2
    return 1
  fi
}

function skills_add() {
  local package="$1"
  shift

  local args=(skills add "$package" -g -a universal -a claude-code -y)
  local skill

  for skill in "$@"; do
    args+=(--skill "$skill")
  done

  npx -y "${args[@]}"
}

require_command npx

skills_add cli/cli gh-skill
skills_add vercel-labs/skills find-skills
skills_add microsoft/playwright-cli playwright-cli

skills_add googleworkspace/cli \
  gws-shared \
  gws-gmail gws-gmail-forward gws-gmail-read \
  gws-gmail-reply gws-gmail-reply-all gws-gmail-send \
  gws-gmail-triage gws-gmail-watch \
  gws-sheets gws-sheets-append gws-sheets-read \
  gws-drive gws-drive-upload \
  gws-calendar gws-calendar-agenda gws-calendar-insert

skills_add homeassistant-ai/skills home-assistant-best-practices
