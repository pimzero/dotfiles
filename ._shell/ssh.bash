~gainax() {
	local what="$@"
	if [ $# -eq 1 ]; then
		ssh gainax "[ -d $1 ]" && \
			local what="cd '$1' && exec bash --login"
	fi
	echo ssh -t gainax "$what"
	ssh -t gainax "$what"
}

# DO NOT SUBMIT
