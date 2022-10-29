# Kfile: Determine file type

This repository is built from the Linux file(1) source with customized build environment for easy understanding.

$ ./file ./file
./file: data

$ ./file ./file -m magic/magic.mgc 
./file: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=cd88ce65f17d677a166eb4955a23785b24213f12, with debug_info, not stripped

[INSTALLED MAGIC FILES]
/usr/local/share/file/magic.mgc
/usr/lib/file/magic.mgc

# MAGIC PATHS:
/usr/share/misc/magic.mgc
/usr/share/file/magic.mgc
/usr/local/share/file/magic.mgc
/usr/lib/file/magic.mgc

