#! /bin/sh

function rfc_search {
	rfc_list=$(cat ./rfc/rfc.tsv | cut -f1-2)
	for word in $@;
	do
		rfc_list=$(echo $rfc_list | grep -i $word)
	done
	echo $rfc_list
	
}

function rfc_read {
if [ ! -f ~/Data/rfc/rfc$(printf $1).txt ]; then
    echo "File not found!"
	return 1
else
	vim -S ~/Data/rfc/rfc_syntax.vim -R ~/Data/rfc/rfc$(printf $1).txt
fi
}
