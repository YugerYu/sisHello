################################################################
# compiler setting
################################################################
C        = gcc
CXX      = g++

# PREDEFINE
CFLAGS   = $(addprefix -D, $(DEFINES))

CFLAGS   += -g -Wall #-m32

# 32/64bits
CFLAGS += $(BITS)

CXXFLAGS = $(CFLAGS) #-Weffc++

# libs
# LIBS     = -lxml2 -L../thirdparty/libxml_linux/lib32
##############################################################LIBS     = -lHello -L../libHello/lib/Linux

# include 
############################################################INCPATH  = -I../libHello/include

# subdir
SUB_DIRS = ../src

###############################################################################
# source files setting
###############################################################################
# find *.cpp
CXX_OBJS := $(patsubst %.cpp, %.o, $(wildcard *.cpp))
EXE = $(CXX_OBJS:.o=)

###########################################################SOURCE_OBJS = $(shell find $(SUB_DIRS) -name "*.o")

.PHONY: $(SUB_DIRS) all clean CLEAN_SUB CLEAN_THIS LINK_DATA
################################################################
# compile target
################################################################
all: $(CXX_OBJS) $(EXE)

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) $< -o $@

$(SUB_DIRS):
	$(MAKE) -C $@

$(EXE):$(CXX_OBJS)
	$(CXX) $< $(SOURCE_OBJS) $(CXXFLAGS) $(INCPATH) $(LIBS) -o $@

LINK_DATA:
	@ln -s ../../titanium/Document/usb817.xml usb817.xml

clean: CLEAN_THIS

CLEAN_THIS:
	@rm -f $(wildcard *.o)

CLEAN_SUB: 
	for dir in $(SUB_DIRS); do\
		$(MAKE) -C $$dir clean;\
	done

