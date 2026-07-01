# dotfiles

Personal macOS / zsh dotfiles. Includes a sandboxed wrapper for running Claude Code inside [Agent Safehouse](https://agent-safehouse.dev).

## Install

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` will:

1. Install [Homebrew](https://brew.sh) if it is missing.
2. Install dependencies from the `Brewfile` (`brew bundle`).
3. Symlink `~/.zshrc` → `~/dotfiles/zsh/.zshrc`.

Then reload your shell:

```sh
source ~/.zshrc
```

## Layout

| Path           | Purpose                                                                 |
| -------------- | ----------------------------------------------------------------------- |
| `zsh/.zshrc`      | Shell config: PATH, aliases, `z`, secrets, `direnv` hook.            |
| `zsh/functions/`  | Auto-sourced `*.zsh` function files (e.g. `safe`).                   |
| `install.sh`      | Bootstrap script (Homebrew + deps + symlinks).                       |
| `Brewfile`        | Declarative dependency list installed via `brew bundle`.             |
| `bin/safehouse`   | Vendored Agent Safehouse sandbox binary.                            |
| `z/`              | Vendored [`z`](https://github.com/rupa/z) directory jumper.          |

## Dependencies

Managed in `Brewfile`:

- `direnv`
- `go`

Add more, then re-run `./install.sh` (idempotent). To snapshot the current machine's packages:

```sh
brew bundle dump --force --file=Brewfile
```

## Claude Code sandbox

The `safe` function (`zsh/functions/safehouse.zsh`) wraps the `claude` CLI inside the Safehouse sandbox. Because the sandbox is the guardrail, it runs Claude with `--dangerously-skip-permissions`.

```sh
safe            # launch sandboxed Claude Code
safe <args>     # args pass through to claude (e.g. safe --resume <id>)
```

The current directory is auto-granted read/write by Safehouse. Extra sandbox features are opt-in per project via a `.safe-features` file — one `--enable` feature per line (`#` comments allowed):

```
# .safe-features
ssh
docker
```

Environment variables are opt-in per project via a `.safe-env` file — one env var **name** per line (`#` comments allowed). The name's value is read from your current shell and passed into the sandbox via `--env-pass`, so no secret values are stored in the file:

```
# .safe-env
ANTHROPIC_API_KEY
GH_TOKEN
```

## Secrets

Secret environment variables are sourced from `~/.secrets.zsh` if present. This file is **not** tracked (see `.gitignore`). Create it manually on each machine.
