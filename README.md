# dotfiles

## Installation

Preferrable way:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply senz
```

Devcontainer entrypoint:

```bash
./install
```

See manual checklist below.

## Usage

**Manage config**

```bash
chezmoi add <file>
```

`--encrypt` to encrypt file

**Edit managed file**

```bash
chezmoi edit <file> --watch
```

**List managed files**

```bash
chezmoi managed
```

**Update managed files**

```bash
chezmoi update --apply
```

## Remove

Removes state, cache and config. Leaves the target files.

Useful for testing install.

```bash
chezmoi purge
```
## Manual checklist

- [ ] Setup gpg and gpg-agent
- [ ] Import gpg key stubs
- [ ] Authorize syncthing
- [ ] Sync Brave settings/extensions...
- [ ] Install CA

## TODO

- [ ] Setup gpg and gpg-agent in `before` script
- [ ] Impoprt gpg keys from the vault

## References and inspiration

- [zero-sh](https://github.com/zero-sh/zero.sh/) – I started with this, liked its simplicity, but quickly hit its limitations.
    - it's unmaintained
    - no encryption support
    - multiple workspaces and inheritance creates confusion
    - MacOS specific
- [Unofficial guide to dotfiles on GitHub](https://dotfiles.github.io/). Look into [utilities section](https://dotfiles.github.io/utilities/)
- [chezmoi](https://chezmoi.io/) – Im currently using this. It's more complex, because of heavy reliance on templating (like helm for configs), but have everything I need. Its well maintened, and you dont have to use templates if you dont want to.

### dotfiles inspirations

- [politician/dotfiles](https://github.com/politician/dotfiles) (chezmoi) very good example of chezmoi usage, simple and clean
- [msanders/setup](https://github.com/msanders/setup) (zero-sh)
- [felipecrs/dotfiles](https://github.com/felipecrs/dotfiles) (chezmoi) – extensive usage of chezmoi features. High class. Dotfiles we all dream about :)
- [burningalchemist/dotfiles](https://github.com/burningalchemist/dotfiles)
- [danpker/dotfiles](https://github.com/danpker/dotfiles)
