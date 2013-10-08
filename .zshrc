# Enable compsys completion.
autoload -U compinit
autoload -Uz vcs_info
autoload -U colors && colors

export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac 

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 

# コマンド履歴検索
# Ctrl-P/Ctrl-Nで、入力中の文字から始まるコマンドの履歴が表示される。
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt auto_cd     # ディレクトリ名を入力するだけで移動
setopt auto_pushd  # 移動したディレクトリを記録。"cd -[Tab]"で移動履歴を一覧
setopt correct 
setopt nolistbeep 

#export LSCOLORS=exfxcxdxbxegedabagacad
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

export PATH=$PATH:~/bin:/var/lib/gems/1.8/bin/:/usr/local/symfony/1.4/data/bin/
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'


alias l="ls -aGl"
alias ls="ls -G"
alias ll="ls -aGl"
alias sl='ls -G -'
alias gls="gls --color"
alias his="history"

alias c='cd ~/git/carinfo'
alias s='cd ~/git/stats'
alias ptags='rm -f ~/.tags.php; find /usr/local/symfony/1.4/ /home/$USER/git/mitra-car -name "*.php" -o -name "*.inc" | xargs --verbose ctags -a -f ~/.tags.php -R --langmap=PHP:.php.inc --php-types=c+f+d+v+i'
alias pgrep='find . \( -name "*.php" -o -name "*.inc" -o -name "*.yml" \) -and ! -ipath "*cache*" -print | xargs grep -in '
alias phpcs='(cd ~/git/mitra-car; phpcs -v --standard=/home/k-kobayashi/git/mitra-car/tools/phpcs/SymfonyCar lib/util/car* lib/task/* lib/service/* lib/model/* apps/*/modules/*/actions/* --ignore=tools/,Base)'

alias mysql_query_log="sudo tail -f /var/log/mysql/mysql_query.log"

alias vim_euc="vim -c ':e ++enc=euc-jp'"

export PATH=$PATH:/home/mitra/git/mitra-car/sandbox/bin

function task_satei_coop_mail() {
  echo "update m_member_satei_coop set mail_send_flag = 0 where id = 7;" | mysql -uroot -pateam1234 car
  (cd ~/git/mitra-car; symfony carTask:sendMailToSateiCooperationTask)
}

MYSQL_PS1=$'[\e[36m\\R:\\m:\\s\e[0m] \e[32m\\u@\\h:\\p\e[0m \\d\\nmysql> '; export MYSQL_PS1

# http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
setopt prompt_subst
setopt transient_rprompt
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# http://d.hatena.ne.jp/sugyan/20100121/1264000100
# http://www.slideshare.net/tetutaro/zsh-20923001
# RPROMPT='%{${fg[green]}%}%/%{$reset_color%}'
common_precmd() {
    LANG=en_US.UTF-8 vcs_info
    local prompt_pwd='%{${fg[green]}%}[%/]%{$reset_color%}'$'\n'
    local prompt_base='%{${fg[red]}%}[%m]${vcs_info_msg_0_} %(!.#.$) %{${reset_color}%}'
    PROMPT="$prompt_pwd$prompt_base"
}
case $TERM in
    screen | xterm-256color)
        preexec() {
            cmd=`echo -ne "$1" | cut -d" " -f 1`
            echo -ne "\ek!$cmd\e\\" 
        }
        precmd() {
            pwd=`pwd`
            if [ $HOME = $pwd ]; then
              echo -ne "\ek~/\e\\"
            else
              echo -ne "\ek$(basename `pwd`)\e\\"
            fi
            #echo -ne "\ek$(basename $SHELL)\e\\"
            common_precmd
        }
        ;;
    *)
        precmd() {
            common_precmd
        }
        ;;
esac

# ruby
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=/home/k-kobayashi/.rvm/gems/ruby-2.0.0-p247/bin:$PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# node
NAVEPATH=$HOME/.nave/installed/0.11.7/bin/
export PATH=$NAVEPATH:$PATH
[ -f ~/.naverc ] && . ~/.naverc || true

alias ptags='rm -f ~/.tags.ruby; find /usr/local/symfony/1.4/ /home/$USER/git/mitra-car -name "*.php" -o -name "*.inc" | xargs --verbose ctags -a -f ~/.tags.php -R --langmap=PHP:.php.inc --php-types=c+f+d+v+i'
