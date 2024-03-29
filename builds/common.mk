uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
OPTIMIZATION ?= -O2

STD = -std=c99
WARN = -Wall -Wextra -pedantic #-Werror
OPT = $(OPTIMIZATION)
DEBUG = -g -ggdb

BUILD_TMP_FILES = *.o *.gcda *.gcno *.gcov

DYLIB_SUFFIX = so
STLIB_SUFFIX = a

ifeq ($(uname_S), Darwin)
DYLIB_SUFFIX = dylib
endif

INSTALL = install

ifdef HOST
CROSS_COMPILE = $(HOST)-
endif

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
STRIP = $(CROSS_COMPILE)strip

FINAL_CFLAGS = $(STD) $(WARN) $(OPT) $(DEBUG) $(CFLAGS) $(EXT_CFLAGS)
FINAL_LDFLAGS = $(DEBUG) $(LDFLAGS) $(EXT_LDFLAGS)
FINAL_LIBS = $(EXT_LIBS)
FINAL_ARFLAGS = $(ARFLAGS) $(EXT_ARFLAGS)

COMMON_CC = $(QUIET_CC) $(CC) $(FINAL_CFLAGS)
COMMON_LD = $(QUIET_LINK) $(CC) $(FINAL_LDFLAGS)
COMMON_AR = $(QUIET_AR) $(AR) $(FINAL_ARFLAGS)
COMMON_INSTALL = $(QUIET_INSTALL) $(INSTALL)

COLOR_INFO = "\033[1;36m"
COLOR_WARN = "\033[0;91m"
CCCOLOR = "\033[34m"
LINKCOLOR = "\033[34;1m"
ARCOLOR = "\033[34;1m"
SRCCOLOR = "\033[33m"
BINCOLOR = "\033[37;1m"
MAKECOLOR = "\033[32;1m"
ENDCOLOR = "\033[0m"

ifndef V
QUIET_MAKE = @printf '    %b %b\n' $(MAKECOLOR)MAKE$(ENDCOLOR) $(BINCOLOR)$@$(ENDCOLOR) 1>&2;
QUIET_CC = @printf '    %b %b\n' $(CCCOLOR)CC$(ENDCOLOR) $(SRCCOLOR)$@$(ENDCOLOR) 1>&2;
QUIET_LINK = @printf '    %b %b\n' $(LINKCOLOR)LINK$(ENDCOLOR) $(BINCOLOR)$@$(ENDCOLOR) 1>&2;
QUIET_AR = @printf '    %b %b\n' $(ARCOLOR)AR$(ENDCOLOR) $(BINCOLOR)$@$(ENDCOLOR) 1>&2;
QUIET_INSTALL = @printf '    %b %b\n' $(LINKCOLOR)INSTALL$(ENDCOLOR) $(BINCOLOR)$@$(ENDCOLOR) 1>&2;
endif
