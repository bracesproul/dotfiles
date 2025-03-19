# Dotfiles

To configure, clone this repository to `~/.dotfiles`, and create a `.zshrc` file in the root directory:

```bash
git clone https://github.com/bracesproul/dotfiles.git ~/.dotfiles
```

```bash
touch ~/.zshrc
```

Then, add the following content to the `~/.zshrc` file:

```bash
# ~/.zshrc
# This file sources the actual zsh configuration from ~/dotfiles/.zshrc

# Source the main configuration file
if [[ -f ~/dotfiles/.zshrc ]]; then
    source ~/dotfiles/.zshrc
else
    echo "Warning: ~/dotfiles/.zshrc not found"
fi
```