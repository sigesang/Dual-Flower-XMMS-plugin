# Change paths if necessary

CC = gcc
OPT = -m486 -O2
#OPT = -mpentium -O6
#OPT = -mcpu=k6 -march=k6 -O6
CONF= -DNO_WIN_DECORATIONS
CFLAGS = $(OPT) -Wall -fPIC `gtk-config --cflags gthread`
LFLAGS = -shared -fPIC -L/usr/local/lib
OBJ = dflowers.o
INSTALL-DIR=`xmms-config --visualization-plugin-dir`
XMMS_DATADIR=`xmms-config --data-dir`
#INSTALL-DIR=$(HOME)/.xmms/Plugins
#XMMS_DATADIR=$(HOME)/.xmms
THEME_SUBDIR=dflowers_themes
XMMS_DATADIR_FLAGS=-DTHEMEDIR=\"$(XMMS_DATADIR)/$(THEME_SUBDIR)/\"

all: libdflowers.so

libdflowers.so: $(OBJ)
	$(CC) -o libdflowers.so $(OBJ) $(LFLAGS)

.c.o:
	$(CC) $(CFLAGS) $(XMMS_DATADIR_FLAGS) -c $< 

clean:
	rm -f *.o core *.so* 

distclean:
	rm -f *.o core *~

install:
	install libdflowers.so $(INSTALL-DIR)
	mkdir -p $(XMMS_DATADIR)/$(THEME_SUBDIR)
	install bg_*.xpm $(XMMS_DATADIR)/$(THEME_SUBDIR)
