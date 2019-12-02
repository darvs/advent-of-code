all: 
	petcat -w2 -o simple.prg -- simple.bas
	petcat -text -w2 -o simple.seq -- simple.txt
	c1541 -format image,dd d64 image.d64 \
		-attach image.d64 \
		-write simple.prg simple \
		-write simple.seq \
		"simple.seq,s"
	x64 -warp +confirmonexit image.d64
	#x64 -warp +autostart-warp +confirmonexit image.d64
	#x64 +confirmonexit image.d64
