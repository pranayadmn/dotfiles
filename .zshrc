# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

zinit lucid light-mode for \
    OMZL::completion.zsh \
    OMZL::directories.zsh \
    OMZL::git.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh

zinit wait lucid light-mode for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
    OMZP::colored-man-pages \
    OMZP::command-not-found \
    OMZP::git \
    agkozak/zsh-z \
    zdharma-continuum/history-search-multi-word \
    zsh-users/zsh-history-substring-search

zinit wait lucid light-mode for \
    https://github.com/junegunn/fzf/blob/master/shell/completion.zsh \
    https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

# Powerlevel10k
zinit lucid light-mode for \
    depth"1" \
        romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Aliases
# Replace cat with bat
if [[ -x "$(command -v batcat)" ]]; then
    alias cat='batcat --style=changes,header,rule,numbers,snip'
else
    alias cat='bat --style=changes,header,rule,numbers,snip'
fi

# Replace cut with choose
alias cut='choose'

# Replace df with duf
alias df='duf'

# Replace du with dust
alias du='dust'

# Replace find with fd
if [[ -x "$(command -v fdfind)" ]]; then
    alias find='fdfind'
else
    alias find='fd'
fi

# Replace grep with ripgrep
alias grep='rg'

# Replace ls with lsd
alias ls='lsd --group-directories-first'                                                                                      # preferred listing
alias la='lsd -A --group-directories-first'                                                                                   # all files and dirs
alias ll='lsd -l --blocks "permission,user,size,date,name" --date +"%e %b %I:%M %p" --group-directories-first --size short'   # long format
alias lla='lsd -lA --blocks "permission,user,size,date,name" --date +"%e %b %I:%M %p" --group-directories-first --size short' # all files and dirs in long format
alias lt='lsd --group-directories-first --tree'                                                                               # tree listing
alias l.='lsd -A --group-directories-first | grep "^\."'                                                                      # show only dotfiles

# Replace ping with gping
alias ping='gping'

# Replace ps with procs
alias ps='procs'

# Replace sed with sd
alias sed='sd'

# Replace tree with broot
alias tree='br'
source "$HOME/.config/broot/launcher/bash/br"
