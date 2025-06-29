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

- [ ] Import gpg key stubs `# gpg --card-edit; \ fetch`
- [ ] Authorize syncthing
- [ ] Sync Brave settings/extensions...
- [ ] brave://settings/extensions toggle `Widevine` to enable DRM video
- [ ] Install CA
- [ ] Install VSCode [Sync Settings](https://marketplace.visualstudio.com/items?itemName=zokugun.sync-settings) extension and `download`
- [ ] (Linux) [nitropy](https://docs.nitrokey.com/software/nitropy/linux/udev) and [companion](https://github.com/bitfocus/companion/blob/main/assets/linux/50-companion-desktop.rules) udev rules
- [ ] (Linux) btrbk systemd timer, config
- [ ] (Linux) [vial udev rules](https://get.vial.today/manual/linux-udev.html)
- [ ] (Linux) `sudo systemctl enable zerotier-one.service && sudo systemctl start zerotier-one.service` 
- [ ] (Linux) `sudo bash -c 'grep -E '^dialout:' /usr/lib/group >> /etc/group' && sudo usermod -a -G dialout $USER`

<details>
    <summary>Sync settings.yml</summary>

```yaml
hostname: "<hostname>"
profile: <chosen profile>

repository:
  type: git
  url: https://github.com/senz/vscode-settings.git
  branch: main
```
</details>

## Declarative package management

I have 'invented' several package spec files in order to manage packages in a declarative way.
I only support 'additive' package management, meaning that I only add packages, never remove them. This is generally non error-prone, and I can always remove packages manually. There is certain risk of
having packages installed and not added to the spec file. This is a tradeoff I am willing to take.

Files suffixed with `.pers.asc` are encrypted protions of main files. They are decrypted and merged into the main file during chezmoi apply.

### Package spec files

- Pakfile – flatpak packages
- Rpmfile – rpm packages used in Fedora, and specifically in ostree package layering
- Appfile – appimage packages

## TODO

[ ] Homebrew for linux install
[ ] Detect/separate devcontainer environment
[ ] bak-watchman SELinux policy to execute
[ ] bak-watchman detect btrbk running, retry
[ ] bak-watchman reduce run frequency

Package specs:

- comparing installed packages with package manifest, reporting differences
- formal specifications and JSON schemas for spec files, plus autogenerated docs
- move to [chezmoidata](https://www.chezmoi.io/user-guide/advanced/install-packages-declaratively/)

AppImage auto update handling. topgrade?

Use password manager for secrets. [here1](https://www.chezmoi.io/user-guide/advanced/install-your-password-manager-on-init/) and [here2]()

## References and inspiration

- [zero-sh](https://github.com/zero-sh/zero.sh/) – I started with this, liked its simplicity, but quickly hit its limitations.
    - it's unmaintained
    - no encryption support
    - multiple workspaces and inheritance creates confusion
    - MacOS specific
- [Unofficial guide to dotfiles on GitHub](https://dotfiles.github.io/). Look into [utilities section](https://dotfiles.github.io/utilities/) as well as [inspirations](https://dotfiles.github.io/inspiration/)
- [chezmoi](https://chezmoi.io/) – Im currently using this. It's more complex, because of heavy reliance on templating (like helm for configs), but have everything I need. Its well maintened, and you dont have to use templates if you dont want to.

### dotfiles inspirations

- [politician/dotfiles](https://github.com/politician/dotfiles) (chezmoi) very good example of chezmoi usage, simple and clean
- [msanders/setup](https://github.com/msanders/setup) (zero-sh)
- [felipecrs/dotfiles](https://github.com/felipecrs/dotfiles) (chezmoi) – extensive usage of chezmoi features. High class. Dotfiles we all dream about :)
- [burningalchemist/dotfiles](https://github.com/burningalchemist/dotfiles)
- [danpker/dotfiles](https://github.com/danpker/dotfiles)
