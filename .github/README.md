# Subjective's dotfiles

These are the dotfiles I use on my Mac system, currently running [MacOS Ventura][ventura]. My editor of choice is [Neovim][neovim], but I also use [VSCode][vscode] occasionally. The instructions are adapted from Joshua Steele's [dotfiles repository][joshua-steele].

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Zsh Setup](#zsh-setup)
- [Fish Setup](#fish-setup)
- [Post-install Tasks](#post-install-tasks)
- [Setting up iTerm2](#setting-up-iterm2)
- [Setting up iTerm2](#setting-up-kitty)
- [Setting up yabai and skhd](#setting-up-yabai-and-skhd)
- [Backing up app settings and personal files](backing-up-app-settings-and-personal-files)
- [Colorschemes](#colorschemes)
  - [1. Colorschemes](#1-colorschemes)
  - [2. Terminal Colorschemes](#2-terminal-colorschemes)
  - [3. Tmux Custom Overrides](#3-tmux-custom-overrides)
  - [4. Useful Colorscheme Links](#useful-colorscheme-links)
- [My Favorite Programming Fonts](#my-favorite-programming-fonts)
  - [Free Fonts](#free-fonts)
  - [Premium Fonts](#premium-fonts)
  - [Ligatures](#ligatures)
  - [Nerd Font Variants](#nerd-font-variants)
  - [Useful Font Links](#useful-font-links)
- [Some cool dotfile repos](#some-cool-dotfile-repos)
- [Helpful web resources on dotfiles, et al.](#helpful-web-resources-on-dotfiles-et-al)

## Prerequisites

The dotfiles assume you are running macOS with the following software pre-installed:

- [Git][git]
- [Homebrew][homebrew] (including [coreutils][coreutils])
- [Ruby][ruby]
- [Node.js][nodejs]
- [Zsh][zsh] or [Fish][fish]
- [Oh-My-Zsh][oh-my-zsh] (if using zsh)
- [Neovim][neovim]
- [Tmux][tmux]

## Installation

I'm using a bare git repo with its working tree set to my home directory to manage my dotfiles without symlinks.

1. Setup your shell. (See Fish/Zsh instructions below.)

2. Run the following commands in the shell to clone the dotfiles:

```
$ git clone --bare <remote-git-repo-url> $HOME/.cfg
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
$ dotfiles config --local status.showUntrackedFiles no
$ dotfiles checkout
```

## Zsh Setup

I recently switched from [Oh My Zsh][oh-my-zsh] to [Zim][zim] as my primary Zsh configuration framework/plugin manager. Not only is it much faster, but it also handles automatic installation and updating of custom plugins. If you want to learn more, check out this [post](https://www.joshyin.cc/blog/speeding-up-zsh).

1. Install zsh: `$ brew install zsh`
1. Install custom plugins: `$ zimfw install`

## Fish Setup

1. Install fish: `$ brew install fish`
1. Install [fisher][fisher]:
   `$ curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher`
1. Restart your computer.
1. Install [tide][tide] theme:
   `$ fisher install IlanCosman/tide@v5`

## Post-install Tasks

After cloning the dotfiles repo there are still a couple of things that need to be done.

- Set up iTerm2 or Kitty profile (see details below).
- Complete [Brew Bundle][brew-bundle] and install packages with `$ brew bundle install`
- Install [Rust][rust] via Rustup: `$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
- Install neovim via [bob][bob]: `$ cargo install bob-nvim`
- After opening Neovim, run [`:checkhealth`][checkhealth] and resolve errors/warnings.
- If using Fish, customize your setup by running the `$ fish_config` command.

## Setting up iTerm2

1. Open iTerm2.
1. Select iTerm2 > Preferences.
1. Under the General tab, check the box labeled "Load preferences from a custom folder or URL:"
1. Press "Browse" and point it to `~/.config/iterm2/com.googlecode.iterm2.plist`.
1. Restart iTerm2.

## Setting up Kitty

Getting set up after a fresh install is simple.

1. Tweak preferences in `~/.config/kitty/kitty.conf`
1. Uncomment Alacritty terminfo lines in `~/.tmux.conf`
1. Setup [alternative][alt-kitty-icon] MacOS application icon for Kitty.
1. Run Kitty!

## Setting up yabai and skhd

I use a tiling window manager called [yabai][yabai] to manage my windows and workspaces and the hotkey daemon [skhd][skhd] to customize yabai's keyboard shortcuts. However, in order to enable all of of yabai's features such as border highlights, instant switching between spaces, and window animations, [System Integrity Protection (SIP)][system-integrity-protection] must be partially disabled.

1. Partially Disable System Integrity Protection according the [yabai docs][disable-sip].
1. Configure Scripting Addition according to the [yabai docs][configure-scripting-addition]
1. Start yabai and skhd:

```
$ yabai --start-service
$ skhd --start-service
```

## Backing up app settings and personal files

### Mackup for backup

[Mackup](https://github.com/lra/mackup) is a fantastic tool that allows you to: backup personal application settings and private data; sync that data between computers; and then easily restore your configuration to a fresh install — all in a simple command line interface. Seems good!

While by no means a comprehensive backup solution, Mackup keeps things simple, currently supports [over 360 applications](https://github.com/lra/mackup/mackup/applications) and can store data on Dropbox, Google Drive, iCloud or any path you can copy to.

#### How I use Mackup

I store on iCloud and explicitly declare which apps to sync and which to ignore — anything handled by my dotfiles is ignored (bash, git, vim etc.)

I backup a wide range of other applications including those containing credentials such as aws, gnupg and ssh. It's also possible to backup apps not natively supported using custom `.cfg` files. For example, to backup [Ulysses](https://ulyssesapp.com) (an amazing markdown writing app), create a `~/.mackup` directory and place a `ulysses.cfg` file inside:

```ini
[application]
name = Ulysses

[configuration_files]
Library/Preferences/com.soulmen.ulysses3.plist
Library/Preferences/com.ulyssesapp.mac.plist
```

It is usually straight-forward to find which `.plist` files in `Library/Preferences` you'll need to list, they always feature the application name.

Taking that a step further we can also declare a "personal files" application using a `personal-files.cfg` and then cherry pick any other files we want to backup while keeping them out of a public repo:

```ini
[application]
name = Personal Files

[configuration_files]
.gitconfig.local
.extra
```

When I declare this in my main [`.mackup.cfg`](mackup/.mackup.cfg) they are handled with ease:

```ini
[storage]
engine = iCloud
directory = Mackup

# Apps to sync — if empty, syncs all supported.
# custom: personal-files, ulysses
[applications_to_sync]
personal-files
spotify
...
ulysses
```

A simple `$ mackup backup` saves everything to iCloud and I can later `$ mackup restore` on a fresh install to get these settings back (you can also easily `$ mackup uninstall`).

## Colorschemes

My all-time favorite colorscheme for code-editing is [Catppuccin][catppuccin]. That said, there are times when I like to dabble with something new, just to have some variety.

![One Half Dark Screenshot][catppuccin-screenshot]

_Example of a React app with the Catppuccin colorscheme_

Here's how everything is organized:

#### 1. Colorschemes

The settings for individual colorschemes are stored in . To add a new colorscheme, add a file for it here.

#### 2. Terminal Colorschemes

Since I use vim in the terminal, I need corresponding iTerm2 or Kitty colorschemes for every vim colorscheme. My iTerm2 colorschemes are stored in `itermcolors/`, but of course must be added manually to the iTerm profile. Kitty colorschemes are defined in `~/.config/kitty/themes/` and can be set with kitty's built-in theme manager: `$ kitty +kitten themes --reload-in=all`.

Multiple pre-made colorschemes are available online for both iTerm2 and Alacritty:

- [iTerm2 colorschemes][iterm2-colorschemes]
- [Kitty colorschemes][kitty-colorschemes]

#### 3. Tmux Custom Overrides

The last tweak is for Tmux. I like to set a custom statusline depending on what colorscheme I'm using. The main `tmux.conf` file contains all the settings that Tmux needs. Uncomment the section for a specific statusline to enable it.

```
## Detailed Catppuccin Statusline ##

# Set status bar color to match background
set-option -g status-style bg=default

## Set status bar position to top
# set-option -g status-position top

## Change spacing between window and statusline
if -F '#{!=:#{status},2}' {
  set -Fg 'status-format[1]' '#{status-format[0]}'
  set -g 'status-format[0]' ''
  set -g status 2
}

[...]
```

I also use [tmux plugin manager](https://github.com/tmux-plugins/tpm) to manage my tmux plugins. Clone the repository and press `prefix` + `I` to install plugins:

```
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Useful Colorscheme Links

- http://vimcolors.com/
- https://www.slant.co/topics/480/~best-vim-color-schemes

## My Favorite Programming Fonts

I've recently branched out to explore some of the different mono-spaced fonts available, both free and premium. Here is a list of my favorites.

### Free Fonts

_Included in my `Brewfile` and installed by default via [Homebrew Cask Fonts][homebrew-cask-fonts]_

- [Fira Code][fira-code]
- [Caskaydia Cove][caskaydia-cove]
- [Hack Mono][hack-mono]
- [JetBrains Mono][jetbrains-mono]

### Premium Fonts

_You have to give people money if you want these._ 🤑

- [Operator Mono][operator-mono]
- [MonoLisa][monolisa]
- [Dank Mono][dank-mono]

### Ligatures

I first discovered ligatures through [Fira Code][fira-code], which IMO is probably the king of programming fonts. After using Fira Code, it's hard to go back to a sans-ligature typeface. Therefore †all the fonts I've included in my fave's list _do_ include ligatures, although some have more than others.

† _Operator Mono does not include ligatures but [can be easily patched][operator-mono-lig] to add them._

### Nerd Font Variants

I use [Devicons][devicons] in my editor, and these require patched fonts in order to display properly. For most free fonts, there are pre-patched [Nerd Font][nerd-fonts-downloads] variants that include the various glyphs and icons.

[Homebrew Cask Fonts][homebrew-cask-fonts] includes both original and Nerd Font variants. For example:

```sh
# Original font
$ brew cask install font-fira-code

# Patched variant
$ brew cask install font-firacode-nerd-font
```

If using a font that does not have a patched variant (e.g. MonoLisa) iTerm2 has an option to use an alternate font for non-ASCII characters.

![iterm2-font-settings][iterm2-font-settings]

### Useful Font Links

- [Nerd Font Downloads][nerd-fonts-downloads]
- [Programming Fonts - Test Drive][programming-fonts]
- [Homebrew Cask Fonts][homebrew-cask-fonts]

## Some cool dotfile repos

- Joshua Steele (https://github.com/joshukraine/dotfiles)
- Pro Vim (https://github.com/Integralist/ProVim)
- Aaron Bates (https://github.com/aaronbates/dotfiles)
- Trevor Brown (https://github.com/Stratus3D/dotfiles)
- Chris Toomey (https://github.com/christoomey/dotfiles)
- thoughtbot (https://github.com/thoughtbot/dotfiles)
- Lars Kappert (https://github.com/webpro/dotfiles)
- Ryan Bates (https://github.com/ryanb/dotfiles)
- Ben Orenstein (https://github.com/r00k/dotfiles)
- Joshua Clayton (https://github.com/joshuaclayton/dotfiles)
- Drew Neil (https://github.com/nelstrom/dotfiles)
- Kevin Suttle (https://github.com/kevinSuttle/OSXDefaults)
- Carlos Becker (https://github.com/caarlos0/dotfiles)
- Zach Holman (https://github.com/holman/dotfiles/)
- Mathias Bynens (https://github.com/mathiasbynens/dotfiles/)
- Paul Irish (https://github.com/paulirish/dotfiles)
- Tnixc (https://github.com/Tnixc/dots)
- AsianKoala (https://github.com/AsianKoala/dotfiles)
- Benjamin Brast-McKie (https://github.com/benbrastmckie/.config)

## Helpful web resources on dotfiles, et al.

- http://dotfiles.github.io/
- https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789
- http://code.tutsplus.com/tutorials/setting-up-a-mac-dev-machine-from-zero-to-hero-with-dotfiles--net-35449
- https://github.com/webpro/awesome-dotfiles
- http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
- http://carlosbecker.com/posts/first-steps-with-mac-os-x-as-a-developer/
- https://mattstauffer.co/blog/setting-up-a-new-os-x-development-machine-part-1-core-files-and-custom-shel
- https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
- https://www.atlassian.com/git/tutorials/dotfiles
- https://harfangk.github.io/2016/09/18/manage-dotfiles-with-a-git-bare-repository.html

## License

Copyright &copy; 2023 Joshua Yin. [MIT License][license]

[vscode]: https://code.visualstudio.com/
[kitty-colorschemes]: https://github.com/kovidgoyal/kitty-themes
[alacritty]: https://github.com/alacritty/alacritty
[brew-bundle]: https://github.com/Homebrew/homebrew-bundle
[caskaydia-cove]: https://github.com/eliheuer/caskaydia-cove
[ventura]: https://www.apple.com/macos/ventura/
[checkhealth]: https://neovim.io/doc/user/pi_health.html#:checkhealth
[coreutils]: https://formulae.brew.sh/formula/coreutils
[dank-mono]: https://dank.sh/
[devicons]: https://github.com/nvim-tree/nvim-web-devicons
[fira-code]: https://github.com/tonsky/FiraCode
[fish]: http://fishshell.com/
[git]: https://git-scm.com/
[homebrew-cask-fonts]: https://github.com/Homebrew/homebrew-cask-fonts
[homebrew]: http://brew.sh
[iterm2-colorschemes]: https://github.com/mbadolato/iTerm2-Color-Schemes
[iterm2-font-settings]: https://res.cloudinary.com/dnkvsijzu/image/upload/v1587816605/screenshots/iterm2-font-settings_k7upta.png
[iterm2]: https://www.iterm2.com/
[javascript]: https://developer.mozilla.org/en-US/docs/Web/JavaScript
[jetbrains-mono]: https://www.jetbrains.com/lp/mono/
[license]: https://github.com/Subjective/dotfiles/blob/main/LICENSE
[material]: https://github.com/kaicataldo/material.vim
[monolisa]: https://www.monolisa.dev/
[neovim]: https://neovim.io/
[nerd-fonts-downloads]: https://www.nerdfonts.com/font-downloads
[nodejs]: https://nodejs.org/
[oh-my-zsh]: https://github.com/ohmyzsh/ohmyzsh
[catppuccin-screenshot]: https://i.imgur.com/heGAQXx.png
[operator-mono-lig]: https://github.com/kiliman/operator-mono-lig
[operator-mono]: https://www.typography.com/fonts/operator/styles/operatormonoscreensmart
[programming-fonts]: https://app.programmingfonts.org/
[react]: https://reactjs.org/
[ruby]: https://www.ruby-lang.org/en
[screenshot]: https://res.cloudinary.com/dnkvsijzu/image/upload/v1584547844/screenshots/dotfiles-mar-2020_a5p5do.png
[catppuccin]: https://github.com/catppuccin
[tmux]: https://github.com/tmux/tmux/wiki
[hack-mono]: https://github.com/source-foundry/Hack
[vim]: http://www.vim.org/
[zsh]: https://www.zsh.org/
[powerlevel10k]: https://github.com/romkatv/powerlevel10k#oh-my-zsh
[joshua-steele]: https://github.com/joshukraine/dotfiles
[yabai]: https://github.com/koekeishiya/yabai
[skhd]: https://github.com/koekeishiya/skhd
[disable-sip]: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
[configure-scripting-addition]: https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition
[system-integrity-protection]: https://support.apple.com/en-us/HT204899
[alt-kitty-icon]: https://github.com/DinkDonk/kitty-icon
[rust]: https://www.rust-lang.org/tools/install
[bob]: https://github.com/MordechaiHadad/bob
[fisher]: https://github.com/jorgebucaran/fisher
[tide]: https://github.com/IlanCosman/tide
[zim]: https://github.com/zimfw/zimfw
