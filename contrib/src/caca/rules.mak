# CACA
CACA_VERSION := 0.99.beta20
CACA_URL := $(GITHUB)/cacalabs/libcaca/releases/download/v$(CACA_VERSION)/libcaca-$(CACA_VERSION).tar.gz

ifndef HAVE_DARWIN_OS
ifndef HAVE_LINUX # see VLC Trac 17251
PKGS += caca
endif
endif

ifeq ($(call need_pkg,"caca >= 0.99.beta19"),)
PKGS_FOUND += caca
endif

$(TARBALLS)/libcaca-$(CACA_VERSION).tar.gz:
	$(call download_pkg,$(CACA_URL),caca)

.sum-caca: libcaca-$(CACA_VERSION).tar.gz

caca: libcaca-$(CACA_VERSION).tar.gz .sum-caca
	$(UNPACK)
	$(call update_autoconfig,.auto)
	$(APPLY) $(SRC)/caca/caca-fix-compilation-llvmgcc.patch
	$(APPLY) $(SRC)/caca/caca-fix-pkgconfig.patch
	$(APPLY) $(SRC)/caca/0001-win32-don-t-for-_WIN32_WINNT-to-Win2K.patch
	$(APPLY) $(SRC)/caca/0002-win32-don-t-redefine-GetCurrentConsoleFont-with-ming.patch
	$(APPLY) $(SRC)/caca/0003-win32-use-ANSI-calls-explicitly.patch
	$(APPLY) $(SRC)/caca/0004-win32-use-CreateFile2-when-compiling-for-Win8.patch
	$(APPLY) $(SRC)/caca/0005-canvas-use-GetCurrentProcessId-on-Windows.patch
	$(APPLY) $(SRC)/caca/0006-stubs-include-winsock2.h-to-get-htons-htonl-declarat.patch
	$(call pkg_static,"caca/caca.pc.in")
	$(MOVE)

CACA_CONF := \
	--disable-gl \
	--disable-imlib2 \
	--disable-doc \
	--disable-cppunit \
	--disable-zzuf \
	--disable-ruby \
	--disable-csharp \
	--disable-cxx \
	--disable-java \
	--disable-python \
	--disable-cocoa \
	--disable-network \
	--disable-vga \
	--disable-imlib2
ifdef HAVE_MACOSX
CACA_CONF += --disable-x11
endif
ifndef WITH_OPTIMIZATION
CACA_CONF += --enable-debug
endif
ifdef HAVE_WIN32
CACA_CONF += --disable-ncurses \
    ac_cv_func_vsnprintf_s=yes \
    ac_cv_func_sprintf_s=yes
endif
ifdef HAVE_LINUX
CACA_CONF += --disable-ncurses
endif

CACA_CONF += \
	MACOSX_SDK=$(MACOSX_SDK) \
	MACOSX_SDK_CFLAGS=" " \
	MACOSX_SDK_CXXFLAGS=" " \
	CPPFLAGS="$(CPPFLAGS) -DCACA_STATIC"

.caca: caca
	$(MAKEBUILDDIR)
	$(MAKECONFIGURE) $(CACA_CONF)
	+$(MAKEBUILD) -C $<
	+$(MAKEBUILD) -C $< install
	touch $@
