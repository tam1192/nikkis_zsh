function _kube-current-context() {
	# kube-ps1 (プロンプト表示機能) が描画時に自動実行するフック関数。
	# 直で呼ぶのではなく、フレームワーク側が参照するためこの形で定義している。
	# shellcheck disable=all
	KUBE_PS1_CONTEXT=$(kubectl config current-context)
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _kube-current-context
