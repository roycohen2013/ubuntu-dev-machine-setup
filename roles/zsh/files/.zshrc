export TERM="xterm-256color"

source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle colored-man-pages
antigen bundle colorize
antigen bundle docker
antigen bundle encode64
#antigen bundle gem
antigen bundle git
antigen bundle git-extras
antigen bundle httpie
antigen bundle kubectl
antigen bundle node
antigen bundle npm
antigen bundle pep8
antigen bundle pip
antigen bundle pipenv
antigen bundle pylint
antigen bundle python
#antigen bundle ruby
antigen bundle sudo
antigen bundle vagrant
antigen bundle yarn

# Syntax highlighting and autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# pure theme
# https://github.com/sindresorhus/pure
#antigen bundle mafredri/zsh-async
#antigen bundle sindresorhus/pure

# powerlevel10k theme
# https://github.com/romkatv/powerlevel10k
#antigen theme romkatv/powerlevel10k

# bullet train theme
# https://github.com/caiogondim/bullet-train.zsh
antigen theme caiogondim/bullet-train.zsh bullet-train

# Tell antigen that you're done.
antigen apply

##### START Fix for ssh-agent {
# Ref: http://mah.everybody.org/docs/ssh

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
     source "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
          start_agent;
     }
else
     start_agent;
fi
##### } END Fix for ssh-agent

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# make sure pipenv creates virtualenv dir in current dir under .venv
export PIPENV_VENV_IN_PROJECT=1

# make vagrant use virtualbox as the default provider
export VAGRANT_DEFAULT_PROVIDER='virtualbox'

# extra aliases, functions and variables can be defined in these files
[ -f ~/.shell_aliases  ] && source ~/.shell_aliases
[ -f ~/.shell_functions  ] && source ~/.shell_functions
[ -f ~/.shell_variables ] && source ~/.shell_variables
