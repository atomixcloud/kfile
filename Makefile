
# GNU Makefile: file(1)

APPNAME   = "File"
VERSION   =  $(shell grep PACKAGE_VERSION src/config.h | cut -d '"' -f 2)

bold      =  $(shell tput bold)
nc        =  $(shell tput sgr0)

TARGET    =  kfile
BINDIR    =  $(HOME)/bin
DATADIR   =  $(HOME)/.magic
MAGIC     =  $(DATADIR)/magic.mgc
#MAGIC     =  $(DATADIR)/$(TARGET).mgc

CC       :=  clang
DEBUG    := -g3
WARN     := -Wall -Werror

CPPFLAGS := -DHAVE_CONFIG_H
CPPFLAGS += -DMAGIC='"$(MAGIC)"'

SRCDIR   :=  src
CTAGDIR  := .ktags
INCLUDE  := -I$(SRCDIR)

CCFLAGS  :=  $(DEBUG) $(WARN) $(CPPFLAGS) $(INCLUDE)

LDFLAGS  := -lz -lbz2

SRCS     :=  $(SRCDIR)/file.c $(SRCDIR)/magic.c $(SRCDIR)/apprentice.c $(SRCDIR)/funcs.c           \
             $(SRCDIR)/buffer.c $(SRCDIR)/compress.c $(SRCDIR)/encoding.c $(SRCDIR)/print.c        \
             $(SRCDIR)/is_tar.c $(SRCDIR)/is_json.c $(SRCDIR)/is_csv.c $(SRCDIR)/fsmagic.c         \
             $(SRCDIR)/readcdf.c $(SRCDIR)/cdf.c $(SRCDIR)/strlcpy.c $(SRCDIR)/readelf.c           \
             $(SRCDIR)/softmagic.c $(SRCDIR)/ascmagic.c $(SRCDIR)/cdf_time.c $(SRCDIR)/fmtcheck.c  \
             $(SRCDIR)/der.c 

OBJS     :=  $(SRCS:.c=.o)

.c.o:
	@echo  "Compiling ... $<"
	@$(CC) $(CCFLAGS) -c $< -o $@

all: info ktags $(TARGET) magic

info:
	@printf "\n$(bold)Compiling $(APPNAME)-$(VERSION):$(nc)\n\n"
	@echo "TARGET     =  $(TARGET)"
	@echo "COMPILER   =  $(CC)"
	@echo "DEBUG      = $(DEBUG)"
	@echo "WARNINGS   = $(WARN)"
	@echo "CPPFLAGS   = $(CPPFLAGS)"
	@echo "INCLUDES   = $(INCLUDE)"

$(TARGET): $(OBJS)
	@printf   "\nLinking   ... object-files\n"
	@$(CC)  -o $(TARGET) $(OBJS) $(LDFLAGS)
	@printf "\nBuild completed: [$(bold)$(TARGET)$(nc)]\n\n"

magic:
	@cd magic && make

install_magic:
	@cd magic && make install

clean_magic:
	@cd magic && make clean

uninstall_magic:
	@cd magic && make uninstall

install: all
	@printf  "\n$(bold)Installing $(APPNAME)-$(VERSION) $(PLATFORM) version:$(nc)\n"
	@echo    "Installing binaries..."
	@install -d $(BINDIR)
	@install -D $(TARGET) $(BINDIR)/$(TARGET)
	@install -d $(DATADIR)
	@make install_magic
	@echo "Done."

uninstall:
	@printf  "\n$(bold)Uninstalling $(APPNAME)-$(VERSION):$(nc)\n"
	@rm  -f  $(BINDIR)/$(TARGET)
	@make uninstall_magic
	@echo    "Done."

clean:
	@printf "\n$(bold)Cleaning Binary files ...$(nc)\n"
	@rm -f $(SRCDIR)/*.o
	@rm -f $(TARGET) core -r $(CTAGDIR)
	@make clean_magic

build:
	@sudo apt-get update
	@sudo apt-get install -y libz-dev libbz2-dev

ktags:
ifneq (,$(wildcard $(HOME)/bin/ktags))
	@ktags
else
	@echo "Ktags not installed";
endif

help:
	@echo "make [OPTIONS: all | magic | clean | install | uninstall | ktags | help ]"

.PHONY: all clean install uninstall ktags magic help
### EOF ###

