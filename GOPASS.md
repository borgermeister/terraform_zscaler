# Gopass

Gopass is built in Go language and is based on [Pass](https://www.passwordstore.org). In fact you can install and use both tools side by side on the same password store.

## Install Gopass

> [!NOTE] Pro tip
> Instead of specifing the architechture in the file name you can replace `arm`, `arm64`, `amd64` etc with `$(dpkg --print-architecture)`
> `dpkg` is the Debian Package Manager and will only work on Debian based systems.

```bash
# Debian and Ubuntu
wget https://github.com/gopasspw/gopass/releases/download/v1.15.15/gopass_1.15.15_linux_$(dpkg --print-architecture).deb
sudo dpkg -i gopass_1.15.15_linux_$(dpkg --print-architecture).deb

# RedHat and Rocky Linux
sudo dnf copr enable daftaupe/gopass centos-stream-9-x86_64
sudo dnf install gopass
```

Edit ~/.bashrc and add environment variable to change where Password Store is created:

```bash
# Gopass Environment Variable
export PASSWORD_STORE_DIR=~/.password-store
```

> [!INFO]
> Remember to create a GPG key before initializing the password store.

## Getting Started

```bash
gopass init <your GPG key>

🍭 Initializing a new password store ...
🔑 Searching for usable private Keys ...
✅ Wrote recipients to .gpg-id
Please enter an email address for password store git config []: bvborge@gmail.com
git initialized at ~/.password-store
git configured at ~/.password-store
Initialized gitfs repository (gitfs) for ansible / ...
🏁 Password store ~/.password-store initialized for:
📩 0x1354550C71E9BCE2 - Bjørn-Vegar Borge <bvborge@gmail.com>
```


> [!NOTE]
> The password store will be configured with Git automatically. Username and e-mail is configured locally and will override your global config. You can freely change this afterwards - either edit the local config or remove it so the global is used.

```bash
# Change the local configuration
gopass git config --local user.name "Bjørn-Vegar Borge"
gopass git config --local user.email "bvborge@gmail.com"

# Remove the local configuration
gopass git config --local --unset user.name
gopass git config --local --unset user.email
```

Insert new secret: `gopass insert <path/to/secret/secretname>`
Show or search for secret: `gopass show <secretname>`
