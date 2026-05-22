# Agent Skills

Global skills are installed with `npx skills`, using `scripts/setup-agent-skills.zsh` as the curated package list.

Generated skill state is local and untracked:

- `~/.agents/skills/<skill>` is the canonical global copy.
- `~/.claude/skills/<skill>` is managed by `npx skills` as a symlink to the canonical copy.

Install or restore the curated set:

```bash
agentskillssetup
agentdoctor
```

To add or remove curated skills, edit `scripts/setup-agent-skills.zsh`. The current set includes GitHub CLI, Vercel Labs skill discovery, Playwright, selected Google Workspace skills, and Home Assistant best practices. Do not commit third-party generated skill directories.
