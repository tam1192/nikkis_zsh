# mdt
# mkdir & touch
function mdt() {
	for f in "$@"; do
		mkdir -p "$(dirname "$f")"
		touch "$f"
	done
}
