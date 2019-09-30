alias stos-qemu='qemu-system-x86_64 -nographic -monitor pty -serial stdio -serial pty'
alias stos-build='rm -rf build; mkdir build; cd build; ../configure --with-debug --with-klog-serial; make; make bootable'
alias stos-checkpatch='checkpatch.pl -no-tree -strict -show-types -ignore=FILE_PATH_CHANGES,BIT_MACRO'
function stos-gdb() {
	gdb build/kernel/stos -ex 'source tools/gdb-stos.py' -ex 'target remote :1234' -ex 'b panic.c:48' -ex 'c' $(ls build/kernel/modules/*/*.ko | while read p; do echo -n "-ex \"stos load-module $p\""; done)
}
