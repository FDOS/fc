# Minimal Makefile for FC

all: fc.exe

UPX=upx --8086
# if you don't want to use UPX set
#     UPX=-rem (DOS)
#   or
#     UPX=true (Unix)
# if you use UPX: then options are
#     --8086 for 8086 compatibility
#   or
#     --best for smallest

fc.exe: fc.c fctools.c ../kitten/kitten.c
	$(CC) $(CFLAGS)$@ $^ $(LDFLAGS)
	$(UPX) $@

_fc.exe: fc.c fctools.c
	$(CC) $(CFLAGS)$@ $^ $(LDFLAGS)
	$(UPX) $@

clean:
	$(RM) fc.exe
	$(RM) _fc.exe
	$(RM) *.o
	$(RM) *.obj
