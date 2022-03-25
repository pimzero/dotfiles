is_in_path() {
	remove_slash() { echo ${1%/}; };
	local IFS=:;
	for i in $PATH; do
		if [ $(remove_slash "$1") = "$i" ]; then
			return 1;
		fi;
	done;
}

# #### Locally installed binaries
#export PATH=~/.local/bin:$PATH

# #### Calbal (Haskell) installed binaries
#export PATH=~/.cabal/bin/:$PATH

# #### Gem (Ruby) installed binaries
#export PATH=~/.gem/ruby/2.4.0/bin:$PATH

# ### Go installed binaries
if is_in_path ~/go/bin; then
	export PATH=~/go/bin:$PATH
fi

# ### .local/bin
if is_in_path ~/.local/bin; then
	export PATH=~/.local/bin:$PATH
fi

unset -f is_in_path
