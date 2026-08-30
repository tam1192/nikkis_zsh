function bzr_prompt_info() {
	return 0
}

function command_not_found_handler() {

	# zsh専用構文のため、チェック除外
	# shellcheck disable=all
	local moshi="$(echo ${(k)commands} | awk 'BEGIN { FS=","; RS=" " } $0~/^'"$0"'/{if (length(out) == 0) {out=$0} else if (length($0) < length(out)) {out=$0} } END {print out}')"

	echo "またタイポしたの〜 ざぁこざぁこ"
	if [[ -z $moshi ]]; then
		echo "タイポが酷すぎてなんて打ちたかったのかわかんなぁい♡"
	else
		echo "もしかしてぇ、${moshi}って入力しようとしたの〜？"
	fi
	echo "また会いたかったら、タイポしてね〜"
}
