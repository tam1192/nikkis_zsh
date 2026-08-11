# 1語
alias a='alias'
alias c='cat'
alias e='echo'
alias t='touch'

# 3語
alias clr='clear' #ターミナルバッファクリア
alias rst='reset' #ターミナルリセット
alias vrc="v ~/.zshrc" #zshrc 編集
alias src="source ~/.zshrc" #zshrc 適用

# パイプ
alias -g @a="| awk"
alias -g @c="| cat"
alias -g @g="| grep --color=auto"
alias -g @h="| head"
alias -g @l="| less"
alias -g @m="| more"
alias -g @t="| tail"

# ネットワーク系
alias ns='nslookup'
alias p='ping -c 4'
alias pp='ping'
