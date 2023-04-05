cd ~
sudo apt update
sudo apt upgrade
sudo apt install git fish tmux neovim curl g++ build-essential libssl-dev
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# To configure current shell with rust installation from previous command
source "$HOME/.cargo/env"
# All git repos required to be cloned for setup will be in the following directory.
mkdir _p_setup_repos
cd _p_setup_repos
git clone https://github.com/PreetamSing/config.git
cd ~
cp _p_setup_repos/config/.*.* ./
cd .config/
cp -r ~/_p_setup_repos/config/.config/* ./
cp -r ~/_p_setup_repos/config/.ssh/* ~/.ssh/
# Following alacritty installation from: https://github.com/alacritty/alacritty/blob/master/INSTALL.md
## ALACRITTY INSTALLATION START <<<<<<
cd ~/_p_setup_repos
git clone https://github.com/alacritty/alacritty.git
cd alacritty
### Rustup should be installed, (here, it has already been installed above)
rustup override set stable
rustup update stable
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
mkdir -p ~/.config/fish/completions
cp extra/completions/alacritty.fish ~/.config/fish/completions/alacritty.fish
## ALACRITTY INSTALLATION END >>>>>>

## Google Chrome Installation START <<<<<<
wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install google-chrome-stable
## Google Chrome Installation END >>>>>>

# ~/_p_pkg_downloads directory should be created before running this script.
cd ~/_p_pkg_downloads
sudo apt install ./nvim-linux64.deb

# Installing nvm.
## Changing dns server so installation script can be downloaded without issue.
## Reference: https://learnubuntu.com/change-dns-server/
sudo apt install resolvconf
sudo bash -c "echo \"# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN
# 127.0.0.53 is the systemd-resolved stub resolver.
# run \"systemd-resolve --status\" to see details about the actual nameservers.
nameserver 1.1.1.1
nameserver 8.8.8.8.3\" > /etc/resolvconf/resolv.conf.d/head"
sudo systemctl enable --now resolvconf.service
## Executing nvm installation script.
## Rename .profile as something else, so that ".bashrc" is selected as profile.
mv .profile ._temp1
## FIXME: You will only be able to use `nvm` in bash, and not in fish.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
## Rename .profile back, from whatever it was temporarily named.
mv ._temp1 .profile
## Install nodejs and npm
nvm install node # `node` stands for latest version (not LTS)

# Install VS Code
## Reference: https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Install Go lang
curl -OL https://golang.org/dl/go1.20.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz

# Install Brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# Install Docker
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
## Install Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
