CC=g++

ifeq ($(DEBUG),yes)
	CXXFLAGS=-Wall -g
	LDFLAGS=-Wall -g
else
	CXXFLAGS=-Wall
	LDFLAGS=-Wall
endif

INCPATH=inc
SRCPATH=src
OBJPATH=obj
LIBPATH=lib
BINPATH=bin

OBJS=$(OBJPATH)/simpleclass.o $(OBJPATH)/simplelib_wrap.o
OUT=$(LIBPATH)/libSimpleLib.so

INCLUDES=-I ./$(INCPATH)

#Set this to your go installation directory
EXE=$$HOME/dev/goinstallation/go/bin/
export PATH := bin:$(PATH)

default: $(OUT)

$(OUT): $(OBJS)
	$(CC) $(LDFLAGS) -shared -o $@ $^

obj/simplelib_wrap.o: simplelib_wrap.cxx inc/simpleclass.h
	$(CC) $(CXXFLAGS) $(INCLUDES) -fpic -c $< -o $@

obj/simpleclass.o: src/simpleclass.cpp inc/simpleclass.h
	$(CC) $(CXXFLAGS) $(INCLUDES) -fpic -c $< -o $@


simplelib_wrap.cxx:
	swig -go -c++ -intgosize 64 -soname libSimpleLib.so simplelib.swig

.PHONY: clean cleanall

clean:
	rm -f $(OBJPATH)/*.o

cleanall: clean
	rm -f $(OUT)
	rm -f *.6
	rm -f *.a
	rm -f *.so
	rm -f *.cxx
	rm -f *.c

build:
	@echo "Building bindings..."
	$(EXE)go tool 6c -I $$HOME/dev/goinstallation/go/pkg/linux_amd64/ -D _64BIT simplelib_gc.c
	$(EXE)go tool 6g simplelib.go
	$(EXE)go tool pack grc simplelib.a simplelib.6 simplelib_gc.6
	
	
install:
	@echo "Installing go package..."
	#Rename swig file so go install command does not try to reprocess it
	mv simplelib.swig simplelib.notswig
	export GOPATH=$$HOME/dev/go/; \
	$(EXE)go install
	mv simplelib.notswig simplelib.swig

	@echo "Installing go shared lib..."
	sudo cp -f lib/libSimpleLib.so /usr/local/lib/
	sudo ldconfig