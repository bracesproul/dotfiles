export PATH="/Users/bracesproul/.npm-global/bin:$PATH"

alias commit="git commit -m"
alias pushhere='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias branch="git branch"
alias checkout="git checkout"
alias add="git add"
alias reset="git reset"
alias pull="git pull"
alias reseth="git reset HEAD~"
alias clone="git clone"
alias stash="git stash"
alias merge="git merge"
alias cout="git checkout"
alias stashclear="git stash && git stash clear"
alias sts="git status"
alias cmain="git checkout main && git pull"
alias cmaster="git checkout master && git pull"
alias cstage="git checkout staging && git pull"

alias ..="cd ../"
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias ..5="cd ../../../../../"
alias ..6="cd ../../../../../../"
alias ..7="cd ../../../../../../../"

alias api="cd ./api/"
alias web="cd ./web/"

alias python="python3"
alias pip="pip3"

alias root="cd /Users/bracesproul"

alias dev="yarn dev"
alias pdev="pnpm dev"

alias build="yarn build"
alias pbuild="pnpm build"

alias gen="yarn gen"
alias pgen="pnpm gen"

alias test="yarn test:single"
alias ptest="pnpm test:single"

alias lint="yarn lint"
alias plint="pnpm lint"

alias lintfix="yarn lint:fix"
alias plintfix="pnpm lint:fix"

alias format="yarn format"
alias pformat="pnpm format"

alias formatcheck="yarn format:check"
alias pformatcheck="pnpm format:check"

# Cursor
alias c="code ."
alias cursor="code ."
# Devin (formerly Windsurf)
alias b="devin ."
# Antigravity
alias a="agy"

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

alias commitPrettier="git add -A && git commit -m 'chore: yarn prettier' && pushhere"
alias commitLint="git add -A && git commit -m 'chore: lint files' && pushhere"

alias prettyWeb="yarn prettier apps/web/src -w"
alias lcLint="/Users/bracesproul/dotfiles/scripts/lint_and_commit_script.sh"
alias lcjs="cd /Users/bracesproul/code/lang-chain-ai/langchainjs"
alias lcpy="cd /Users/bracesproul/code/lang-chain-ai/langchainpy"
alias lccjs="cd /Users/bracesproul/code/lang-chain-ai/chat-langchainjs"
alias lccpy="cd /Users/bracesproul/code/lang-chain-ai/chat-langchain"
alias lgjs="cd /Users/bracesproul/code/lang-chain-ai/langgraphjs"
alias lcplus="cd /Users/bracesproul/code/lang-chain-ai/langchainplus"
alias lg="cd /Users/bracesproul/code/lang-chain-ai/langgraph"
alias lcp="cd /Users/bracesproul/code/lang-chain-ai/projects"
alias wt="/Users/bracesproul/dotfiles/scripts/setup_worktree.sh"
alias checkoutfork="source /Users/bracesproul/dotfiles/scripts/checkout_fork.sh"
alias ccf="source /Users/bracesproul/dotfiles/scripts/checkout_fork_custom.sh"
alias uvinstall="source /Users/bracesproul/dotfiles/scripts/install_py_deps.sh"

alias startdb="cd smith-backend/ && make start-db && make setup-local-clickhouse && cd .."

# Start LangChainPlus servers (non-agent builder)
alias startlcp="/Users/bracesproul/dotfiles/scripts/start_langchainplus_servers.sh"
# Start LangChainPlus agent builder servers
alias startab="/Users/bracesproul/dotfiles/scripts/start_langchainplus_agent_builder_servers.sh"

alias wtc="source /Users/bracesproul/dotfiles/scripts/worktree_ls_coding.sh"

# Create a new virtual env
alias cvenv="source /Users/bracesproul/dotfiles/scripts/create_py_venv.sh"
alias avenv="source /Users/bracesproul/dotfiles/scripts/activate_py_venv.sh"
# Move a directory into the trash
alias rmrf="bash /Users/bracesproul/dotfiles/scripts/move_to_trash.sh"

alias ..web="cd ../web"
alias ..api="cd ../api"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
# Created by `pipx` on 2024-04-15 21:21:59
export PATH="$PATH:/Users/bracesproul/.local/bin"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Copy the current path to the clipboard
alias cpath="pwd | pbcopy"

# Added by Windsurf
export PATH="/Users/bracesproul/.codeium/windsurf/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bracesproul/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bracesproul/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bracesproul/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bracesproul/google-cloud-sdk/completion.zsh.inc'; fi

# Enable shift+arrow text selection
source ~/.oh-my-zsh/custom/plugins/zsh-shift-select/zsh-shift-select.plugin.zsh

# Add Cmd+Shift+Arrow for selecting to beginning/end of line
zle -N shift-select::beginning-of-line shift-select::select-and-invoke
zle -N shift-select::end-of-line shift-select::select-and-invoke
bindkey -M emacs '^[[1;10D' shift-select::beginning-of-line      # Cmd+Shift+Left
bindkey -M emacs '^[[1;10C' shift-select::end-of-line            # Cmd+Shift+Right
bindkey -M shift-select '^[[1;10D' shift-select::beginning-of-line
bindkey -M shift-select '^[[1;10C' shift-select::end-of-line

# Copy selection to clipboard (Cmd+C)
function shift-select::copy-region() {
    zle copy-region-as-kill -w
    print -rn -- "$CUTBUFFER" | pbcopy
    zle deactivate-region -w
    zle -K main
}
zle -N shift-select::copy-region
bindkey -M shift-select '^[[99;6u' shift-select::copy-region     # Cmd+C
bindkey -M emacs '^[[99;6u' shift-select::copy-region            # Cmd+C (emacs keymap)

# Cut selection to clipboard (Cmd+X)
function shift-select::cut-region() {
    zle copy-region-as-kill -w
    print -rn -- "$CUTBUFFER" | pbcopy
    zle kill-region -w
    zle -K main
}
zle -N shift-select::cut-region
bindkey -M shift-select '^[[120;6u' shift-select::cut-region     # Cmd+X
bindkey -M emacs '^[[120;6u' shift-select::cut-region            # Cmd+X (emacs keymap)

# Undo (Cmd+Z)
bindkey -M shift-select '^[[122;6u' undo                         # Cmd+Z
bindkey -M emacs '^[[122;6u' undo                                # Cmd+Z (emacs keymap)

repo() {
    open "$(git config --get remote.origin.url | sed 's|git@\(.*\):\(.*\)\.git|https://\1/\2|')/$1/$2"
}

Repo() {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    open "$(git config --get remote.origin.url | sed 's|git@\(.*\):\(.*\)\.git|https://\1/\2|; s|\.git$||')/tree/$branch"
}

# Keep provider credentials out of interactive shells.
# for var in LANGSMITH_API_KEY OPENAI_API_KEY ANTHROPIC_API_KEY OPENAI_BASE_URL ANTHROPIC_BASE_URL; do
#     unset "$var"
#     launchctl unsetenv "$var" 2>/dev/null || true
# done
# unset var
