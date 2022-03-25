history() {
	if [ $# -eq 0 ]; then
		nl ~/.shell_history/*
	else
		builtin history $@
	fi
}
