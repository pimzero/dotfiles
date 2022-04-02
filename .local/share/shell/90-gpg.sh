#eval $(gpg-agent --daemon --enable-ssh-support 2>/dev/null)
if [ -z "$SSH_AUTH_SOCK" ] ; then
	SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"; export SSH_AUTH_SOCK;
fi
