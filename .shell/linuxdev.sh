function mkmod() {
	DEFAULT_NAME="$1"
	DEFAULT_LICENCE=1
	DEFAULT_AUTHOR="$(git config user.name)"
	DEFAULT_VERSION='1.0'
	DEFAULT_DESCRIPTION=''

	LICENCES=$(cat <<-EOM
		GPL
		GPL v2
		GPL and additional rights
		Dual BSD/GPL
		Dual MIT/GPL
		Dual MPL/GPL
		Private
EOM
)

	function _read_multiline_str() {
		cat - | sed 's/\\/\\\\/g; s/"/\\"/g; s/^/"/g; s/$/\\n"/g'
	}

	echo -n "Module name [$DEFAULT_NAME]: "
	read NAME
	NAME="${NAME:-$DEFAULT_NAME}"
	if [ -z $(echo -n "$NAME" | grep -E '^[a-zA-Z][0-9a-zA-Z_-]*$') ]; then
		echo "Invalid module name '$NAME'" >&2
		return 1
	fi

	DEFAULT_NAMESPACE=$(echo -n "$NAME" | sed 's/\(\s\|[.+-]\)\+/_/g; s/^_*//g; s/_*$//g' | tr '[:upper:]' '[:lower:]' | grep -E '^[a-z][a-z0-9_]*$')
	echo -n "Module name [$DEFAULT_NAMESPACE]: "
	read NAMESPACE
	NAMESPACE="${NAMESPACE:-$DEFAULT_NAMESPACE}"
	if [ -z "$(echo -n "$NAMESPACE" | grep -E '^[a-z][0-9a-z_]*$')" ]; then
		echo "Invalid namespace '$NAMESPACE'" >&2
		return 1
	fi

	echo "Licence [$DEFAULT_LICENCE]: "
	echo -e "$LICENCES" | cat -n
	read LICENCE
	LICENCE="${LICENCE:-$DEFAULT_LICENCE}"
	LICENCE=$(echo -e "$LICENCES" | cat -n | sed 's/^\s*//g; s/\s.*$//g' | grep "$LICENCE")
	LICENCE="${LICENCE:-$DEFAULT_LICENCE}"
	LICENCE=$(echo -e "$LICENCES" | head -n$LICENCE | tail -n1)


	echo -n "Author's name [$DEFAULT_AUTHOR]: "
	read AUTHOR_NAME
	AUTHOR_NAME="${AUTHOR_NAME:-$DEFAULT_AUTHOR}"

	DEFAULT_MAIL="$(git config user.email)"
	echo -n "Author's mail [$DEFAULT_MAIL]: "
	read AUTHOR_MAIL
	AUTHOR_MAIL="${AUTHOR_MAIL:-$DEFAULT_MAIL}"

	DEFAULT_AUTHOR="$AUTHOR_NAME <$AUTHOR_MAIL>"
	echo -n "Author [$DEFAULT_AUTHOR]: "
	read AUTHOR
	AUTHOR="${AUTHOR:-$DEFAULT_AUTHOR}"
	# TODO: Sanitize AUTHOR ('\' and '"' (amongst others))

	echo -n "Module version [$DEFAULT_VERSION]: "
	read VERSION
	VERSION="${VERSION:-$DEFAULT_VERSION}"

	if [ -z $(echo -n "$VERSION" | grep -E '^([0-9]+:)?[0-9a-zA-Z.]+(-[0-9a-zA-Z.]+)?$') ]; then
		echo "Invalid version '$VERSION'" >&2
		return 1
	fi

	echo "Module description [$DEFAULT_DESCRIPTION]: "
	#DESCRIPTION="$(cat - | sed 's/\\/\\\\/g; s/"/\\"/g; s/^/"/g; s/$/\\n"/g')"
	DESCRIPTION="$(_read_multiline_str)"

	DEFAULT_PARAM_TYPE='int'
	MODULE_PARAMS_ALL=''
	MODULE_PARAMS_VARS=''
	# TODO: Limit to max argument
	while [ 1 -eq 1 ]; do
		echo -n 'Module parameter (Nothing => no more arguments): '
		read PARAM_NAME
		if [ -z "$PARAM_NAME" ]; then
			break;
		fi
		if [ -z "$(echo -n "$PARAM_NAME" | grep -E '^[a-z][0-9a-z_]*$')" ]; then
			echo "Invalid parameter '$PARAM_NAME'" >&2
			return 1
		fi
		echo -n "Parameter type [$DEFAULT_PARAM_TYPE]: "
		read PARAM_TYPE
		PARAM_TYPE=${PARAM_TYPE:-$DEFAULT_PARAM_TYPE}
		#TODO" check for array

		DEFAULT_PARAM_VALUE="0"
		echo -n "Parameter default value [$DEFAULT_PARAM_VALUE]: "
		read PARAM_VALUE
		PARAM_VALUE=${PARAM_VALUE:-$DEFAULT_PARAM_VALUE}
		#TODO: Sanitize

		echo "Parameter description: "
		PARAM_DESCRIPTION="$(_read_multiline_str)"

		MODULE_PARAMS_VARS=$(cat <<-EOM
			$MODULE_PARAMS_VARS
			$PARAM_TYPE $PARAM_NAME;
EOM
)
		MODULE_PARAMS_ALL=$(cat <<-EOM
			$MODULE_PARAMS_ALL
			module_param($PARAM_NAME, $PARAM_VALUE, $PARAM_TYPE);
			MODULE_PARM_DESC($PARAM_NAME, $PARAM_DESCRIPTION);
EOM
)

	done


	mkdir "$NAME"
	if [ $? -ne 0 ]; then
		echo "Couldn't make directory '$NAME'" >&2
		return 1
	fi

(cat <<EOM
#include <linux/kernel.h>
#include <linux/module.h>

$MODULE_PARAMS_ALL

static int __init ${NAMESPACE}_init(void)
{
	return 0;
}

static void __exit ${NAMESPACE}_exit(void)
{
}

module_init(${NAMESPACE}_init);
module_exit(${NAMESPACE}_exit);
$MODULE_PARAMS_ALL

MODULE_AUTHOR("$AUTHOR");
MODULE_DESCRIPTION($DESCRIPTION);
MODULE_LICENSE("$LICENCE");
MODULE_VERSION("$VERSION");
EOM
) >"$NAME/$NAME.c"
	if [ $? -ne 0 ]; then
		echo "Couldn't make file '$NAME/$NAME.c'" >&2
		return 1
	fi

(cat <<EOM
obj-m += $NAME.o
EOM
) >"$NAME/Kbuild"
	if [ $? -ne 0 ]; then
		echo "Couldn't make file '$NAME/Kbuild'" >&2
		return 1
	fi

(cat <<EOM
KDIR ?= "/lib/modules/\$(shell uname -r)/build"

all:
	make -C \$(KDIR) M=\$(PWD) modules

clean:
	make -C \$(KDIR) M=\$(PWD) clean

install:
	make -C \$(KDIR) M=\$(PWD) modules_install
EOM
) >"$NAME/Makefile"
	if [ $? -ne 0 ]; then
		echo "Couldn't make file '$NAME/Makefile'" >&2
		return 1
	fi
}
