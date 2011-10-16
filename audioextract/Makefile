# Nmake macros for building audioextract application
OUTDIR = Debug
TARGET = ae.exe
OBJS = main.obj
SOURCE = main.asm
LINK_FLAG = /subsystem:console
ML_FLAG = /c /coff

all: $(OUTDIR) $(OUTDIR)\$(TARGET)

$(OUTDIR) :
    if not exist "$(OUTDIR)/$(NULL)" mkdir $(OUTDIR)

$(OUTDIR)\$(TARGET) : $(OUTDIR)\$(OBJS)
	link $(LINK_FLAG) /OUT:$(OUTDIR)\$(TARGET) $(OUTDIR)\$(OBJS)

$(OUTDIR)\$(OBJS) :
	ml /Fo $(OUTDIR)\$(OBJS) $(ML_FLAG) $(SOURCE)

clean:
      del $(OUTDIR)\*
