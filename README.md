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
3. Symlink `~/.zshrc` → `~/dotfiles/.zshrc`.

Then reload your shell:

```sh
source ~/.zshrc
```

## Layout

| Path           | Purpose                                                                 |
| -------------- | ----------------------------------------------------------------------- |
| `.zshrc`       | Shell config: PATH, aliases, `z`, secrets, `direnv` hook.               |
| `install.sh`   | Bootstrap script (Homebrew + deps + symlinks).                          |
| `Brewfile`     | Declarative dependency list installed via `brew bundle`.                |
| `claude.sh`    | Runs Claude Code sandboxed inside Safehouse.                            |
| `bin/safehouse`| Vendored Agent Safehouse sandbox binary.                                |
| `z/`           | Vendored [`z`](https://github.com/rupa/z) directory jumper.             |
| `profiles/`    | Custom Safehouse `.sb` sandbox profiles (optional overrides).           |

## Dependencies

Managed in `Brewfile`:

- `direnv`
- `go`

Add more, then re-run `./install.sh` (idempotent). To snapshot the current machine's packages:

```sh
brew bundle dump --force --file=Brewfile
```

## Claude Code sandbox

`claude.sh` wraps the `claude` CLI inside the Safehouse sandbox, with `ssh` and `docker` access enabled. Because the sandbox is the guardrail, it runs Claude with `--dangerously-skip-permissions`.

A `claude-safe` alias is defined in `.zshrc`:

```sh
claude-safe            # launch sandboxed Claude Code
claude-safe <args>     # args pass through to claude
```

## Secrets

Secret environment variables are sourced from `~/.secrets.zsh` if present. This file is **not** tracked (see `.gitignore`). Create it manually on each machine.
