SHELL = /bin/sh
CC    = gcc

BINDIR := bin
LIBDIR := lib
OBJDIR := .objs

libsailboat_TARGET  = lib/lib⛵.so
libsailboat_SOURCES = src/lib⛵.c
libsailboat_HEADERS = include/lib⛵.h
libsailboat_OBJECTS = $(OBJDIR)/lib⛵.o

libgun_TARGET  = lib/lib🔫.so
libgun_SOURCES = src/lib🔫.c
libgun_HEADERS = include/lib🔫.h
libgun_OBJECTS = $(OBJDIR)/lib🔫.o

TARGET  = bin/⛵🔫
SOURCES = src/⛵🔫.c
OBJECTS = $(OBJDIR)/⛵🔫.o

all: $(TARGET)

$(OBJECTS): $(OBJDIR)
	$(CC) -Wall -g -Iinclude -c $(SOURCES) -o $(OBJECTS)

$(TARGET): $(libsailboat_TARGET) $(libgun_TARGET) $(OBJECTS) $(BINDIR)
	$(CC) -g -l⛵ -l🔫 -L$(LIBDIR) -o $(TARGET) $(OBJECTS)

$(libsailboat_OBJECTS): $(LIBDIR) $(OBJDIR)
	$(CC) -fPIC -Wall -g -c $(libsailboat_SOURCES) -o $(libsailboat_OBJECTS)

$(libsailboat_TARGET): $(libsailboat_OBJECTS)
	$(CC) -g -shared -lc -o $(libsailboat_TARGET) $(libsailboat_OBJECTS)

$(libgun_OBJECTS): $(LIBDIR) $(OBJDIR)
	$(CC) -fPIC -Wall -g -c $(libgun_SOURCES) -o $(libgun_OBJECTS)

$(libgun_TARGET): $(libgun_OBJECTS)
	$(CC) -g -shared -lc -o $(libgun_TARGET) $(libgun_OBJECTS)

$(BINDIR):
	mkdir -p $(BINDIR)

$(LIBDIR):
	mkdir -p $(LIBDIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)

clean:
	rm -rf $(BINDIR)
	rm -rf $(LIBDIR)
	rm -rf $(OBJDIR)