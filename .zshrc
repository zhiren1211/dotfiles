# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{#93F593}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{#EEAA55}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{#EEAA55}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{#FF99BE}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{#EEAA55}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status} [$branch_name]"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの設定
PROMPT='%F{#c088ff}%B%n@%m%b%f:%F{#66AAEE}%B%/%b%f`rprompt-git-current-branch` $
'
RPROMPT='%F{#66AAEE}[%*]%f'

# zplugが無ければgitからclone
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplugを使う
source ~/.zplug/init.zsh

# ここに使いたいプラグインを書いておく
zplug "zsh-users/zsh-completions"
zplug "plugins/git",   from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

# 自分自身をプラグインとして管理
zplug "zplug/zplug", hook-build:'zplug --self-manage'

# インストールしてないプラグインはインストール
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load –verbose

# zsh-completionsの設定
autoload -U compinit && compinit -u //override comp

# zsh-syntax-highlightingの設定
if [ -f ~/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]
then
    source ~/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-autosuggestionsの設定
if [ -f ~/.zplug/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh ]
then
    source ~/.zplug/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 追加したソフトやパッケージ用のコマンドのパスを通す
export PATH=/usr/local/bin:$PATH

# For a full list of active aliases, run `alias`.
# Example aliases
alias vimzsh="vim ~/dotfiles/.zshrc"
alias vimvim="vim ~/dotfiles/.vimrc"
alias vimgit="vim ~/.gitconfig"

# User configuration
# 起動時に挨拶とタイムスタンプ
cat ~/dotfiles/.greet
date "+%Y/%m/%d %H:%M:%S
"
# 文字コードの指定
# export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# cdなしでディレクトリ移動
setopt auto_cd

# ビープ音の停止
setopt no_beep

# ビープ音の停止(補完時)
setopt nolistbeep

# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd

# ヒストリ(履歴)を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# 補完リストの表示間隔を狭くする
setopt list_packed

#単語の入力途中でもTab補完を有効化
setopt complete_in_word

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補をハイライト
zstyle ':completion:*:default' menu select=1

# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true

# awsコマンド補完の有効化
autoload bashcompinit && bashcompinit
complete -C '/usr/bin/aws_completer' aws

# nvmのインストール
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
