
# Initial Installation on a Fresh ArchLinux OS

## pre-installation

```bash
sudo pacman --noconfirm -S git

mkdir WORK
cd WORK
git clone https://github.com/mebusy/codeLib.git  mebusy_git_codelib
cd !$
cd archLinux
```


## HiDPI for apps

### Chromium

```bash
# ~/.config/chromium-flags.conf
--force-device-scale-factor=1.25
```
