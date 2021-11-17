all:
	nasm -f macho64 ${source}.asm
	ld -macosx_version_min 10.12 -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o ${source} ${source}.o -no_pie
	rm ${source}.o