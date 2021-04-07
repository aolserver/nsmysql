#
# $Id: Makefile,v 1.4 2003/07/09 20:50:37 elizthom Exp $
#

AOLSERVER =  ../aolserver
NSHOME    =  $(AOLSERVER)

#
# Module name
#
MOD       =  nsmysql.so

#
# Objects to build.
#
OBJS      =  mysql.o

#
# Set this to be the installation prefix of your MySQL installation,
# or you may supply the path on the make command line.
#
ifndef MYSQL_PREFIX
MYSQL_PREFIX = /usr/local
endif

MYSQL_LIBDIR = $(MYSQL_PREFIX)/lib
MYSQL_INCDIR = $(MYSQL_PREFIX)/include

#
# Header files in THIS directory
#
HDRS     =

#
# Extra libraries
#
ifndef NO_ROPT
MODLIBS  += -R$(MYSQL_LIBDIR)
else
MODLIBS  +=  -L$(MYSQL_LIBDIR) -lmysqlclient_r
endif

# Specify NEED_ZLIB=1 if you have problems relating to
# "compress" ...
# This will find the libz.so in the standard place, unless you
# explicitly specify how to get to it via MOD_ZLIBS

ifdef NEED_ZLIB
ifdef MOD_ZLIBS
MODLIBS  += $(MOD_ZLIBS)
else
MODLIBS  +=  -lz
endif
endif

#
# Compiler flags
#
CFLAGS   = -I$(MYSQL_INCDIR)


include  $(AOLSERVER)/include/Makefile.module

ifndef NO_LDOVERRIDE
# Override linker to use ld(1), if your gcc doesn't understand -R ...
LDSO     = ld -shared
endif

