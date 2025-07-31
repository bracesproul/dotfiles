export PATH="/Users/bracesproul/.npm-global/bin:$PATH"

alias status="git status"
alias commit="git commit -m"
alias push="git push -u origin"
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

alias c="code ."
alias cursor="code ."
alias b="windsurf ."
alias w="windsurf ."

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
alias lg="cd /Users/bracesproul/code/lang-chain-ai/langgraph"
alias lcp="cd /Users/bracesproul/code/lang-chain-ai/projects"
alias wt="/Users/bracesproul/dotfiles/scripts/setup_worktree.sh"
alias checkoutfork="source /Users/bracesproul/dotfiles/scripts/checkout_fork.sh"
alias ccf="source /Users/bracesproul/dotfiles/scripts/checkout_fork_custom.sh"
alias uvinstall="source /Users/bracesproul/dotfiles/scripts/install_py_deps.sh"

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

repo() {
    open "$(git config --get remote.origin.url | sed 's|git@\(.*\):\(.*\)\.git|https://\1/\2|')/$1/$2"
}

Repo() {
    local branch=$(git rev-parse --abbrev-ref HEAD)
    open "$(git config --get remote.origin.url | sed 's|git@\(.*\):\(.*\)\.git|https://\1/\2|; s|\.git$||')/tree/$branch"
}
