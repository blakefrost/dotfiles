# myfreeweb/dotfiles

## Installation
    git submodule update --init --recursive
    ./install.sh

## Dependencies
There are many. And most of them can be installed with [babushka](http://babushka.me/) + my [deps](https://github.com/myfreeweb/babushka-deps). Hey, it even installs the dotfiles themselves.

But are you really going to use all my dotfiles? No. You're not me. You should steal the good parts instead :-)

## The good parts
- git&hg alias system, one letter == one thing, like vi commands, but the object comes before the verb, which makes more sense for version control
- awesome `irb` (ruby), `python`, `lein` (clojure)
- [Tarsnap](http://www.tarsnap.com/)-based backup script `bin/backup` and backup deletion script `bin/rmbackups`
- `bin/pinboard_html` writes my recent [Pinboard](http://pinboard.in) bookmarks to ~/.bookmarks.html, I add it to LaunchBar, I can search it
- solid, robust, UNIX-way mail configuration: mutt + offlineimap + msmtp + notmuch + urlview + `bin/addressbook` work together. like a boss!

## The weird parts
- I use the [Colemak](http://colemak.com/) keyboard layout instead of QWERTY, so in all the curses-based apps (vim, mutt, less, tmux) j and k are swapped so it's more reasonable (`k` is lower than `j` so `k` should mean down)
- on Macs, don't forget to install exuberant-ctags via [homebrew](http://mxcl.github.com/homebrew/), the built-in version isn't exuberant enough
