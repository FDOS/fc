
all: fc.exe

# Watcom has different flag for output file name at compile vs link
_CFLAGS = $(subst -fe=,-fo=,$(CFLAGS))

kitten.obj: ../kitten/kitten.c
	$(CC) $(_CFLAGS)$@ -c $^

tnyprntf.obj: ../tnyprntf/tnyprntf.c
	$(CC) $(_CFLAGS)$@ -c $^

fc.exe: fc.c fctools.c $(EXTRA_OBJS)
	$(CC) $(CFLAGS)$@ $^ $(LDFLAGS)
	$(UPXARGS) $@

clean:
	$(RM) fc.exe
	$(RM) *.o
	$(RM) *.obj
	$(RM) *.map
