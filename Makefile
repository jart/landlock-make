MAKEFLAGS += --no-builtin-rules
MKDIR = /bin/mkdir -p
CC = o//third_party/gcc/bin/x86_64-linux-musl-gcc -static
AR = build/bootstrap/ar.com rcsD
CPPFLAGS = -iquote .
TMPDIR = o//tmp
IGNORE := $(shell $(MKDIR) $(TMPDIR) o/pkg)

export TMPDIR

.STRICT = 1
.UNVEIL =			\
	rx:/bin			\
	rx:/lib			\
	rx:/usr/lib		\
	rwcx:o/tmp		\
	rx:build/bootstrap	\
	rx:o/third_party/gcc

.SUFFIXES:
.DELETE_ON_ERROR:
.FEATURES: output-sync

.PHONY: all
all: \
		o//pkg/main_0.exe \
		o//pkg/main_1.exe \
		o//pkg/main_2.exe \
		o//pkg/main_3.exe \
		o//pkg/main_4.exe \
		o//pkg/main_5.exe \
		o//pkg/main_6.exe \
		o//pkg/main_7.exe \
		o//pkg/main_8.exe \
		o//pkg/main_9.exe \
		o//pkg/main_10.exe \
		o//pkg/main_11.exe \
		o//pkg/main_12.exe \
		o//pkg/main_13.exe \
		o//pkg/main_14.exe \
		o//pkg/main_15.exe \
		o//pkg/main_16.exe \
		o//pkg/main_17.exe \
		o//pkg/main_18.exe \
		o//pkg/main_19.exe

.PHONY: clean
clean: o/pkg
	/bin/rm -rf o/pkg

o//%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $(TMPDIR)/$(subst /,_,$@)
	@$(MKDIR) $(@D)
	@/bin/cp -f $(TMPDIR)/$(subst /,_,$@) $@

o//%.exe:
	$(CC) $(LDFLAGS) $(TARGET_ARCH) -o $(TMPDIR)/$(subst /,_,$@) $^
	@$(MKDIR) $(@D)
	@/bin/cp -f $(TMPDIR)/$(subst /,_,$@) $@

o//%.a:
	@$(MKDIR) $(@D)
	$(AR) $@ $^

o//pkg/fun_0_0.o: \
		pkg/fun_0_0.c \
		pkg/fun_0_0.h

o//pkg/fun_0_1.o: \
		pkg/fun_0_1.c \
		pkg/fun_0_1.h

o//pkg/fun_0_2.o: \
		pkg/fun_0_2.c \
		pkg/fun_0_2.h

o//pkg/fun_0_3.o: \
		pkg/fun_0_3.c \
		pkg/fun_0_3.h

o//pkg/fun_0_4.o: \
		pkg/fun_0_4.c \
		pkg/fun_0_4.h

o//pkg/fun_0_5.o: \
		pkg/fun_0_5.c \
		pkg/fun_0_5.h

o//pkg/fun_0_6.o: \
		pkg/fun_0_6.c \
		pkg/fun_0_6.h

o//pkg/fun_0_7.o: \
		pkg/fun_0_7.c \
		pkg/fun_0_7.h

o//pkg/fun_0_8.o: \
		pkg/fun_0_8.c \
		pkg/fun_0_8.h

o//pkg/fun_0_9.o: \
		pkg/fun_0_9.c \
		pkg/fun_0_9.h

o//pkg/fun_0_10.o: \
		pkg/fun_0_10.c \
		pkg/fun_0_10.h

o//pkg/fun_0_11.o: \
		pkg/fun_0_11.c \
		pkg/fun_0_11.h

o//pkg/fun_0_12.o: \
		pkg/fun_0_12.c \
		pkg/fun_0_12.h

o//pkg/fun_0_13.o: \
		pkg/fun_0_13.c \
		pkg/fun_0_13.h

o//pkg/fun_0_14.o: \
		pkg/fun_0_14.c \
		pkg/fun_0_14.h

o//pkg/fun_0_15.o: \
		pkg/fun_0_15.c \
		pkg/fun_0_15.h

o//pkg/fun_0_16.o: \
		pkg/fun_0_16.c \
		pkg/fun_0_16.h

o//pkg/fun_0_17.o: \
		pkg/fun_0_17.c \
		pkg/fun_0_17.h

o//pkg/fun_0_18.o: \
		pkg/fun_0_18.c \
		pkg/fun_0_18.h

o//pkg/fun_0_19.o: \
		pkg/fun_0_19.c \
		pkg/fun_0_19.h

o//pkg/main_0.o: \
		pkg/main_0.c \
		pkg/fun_0_0.h \
		pkg/fun_0_1.h \
		pkg/fun_0_2.h \
		pkg/fun_0_3.h \
		pkg/fun_0_4.h \
		pkg/fun_0_5.h \
		pkg/fun_0_6.h \
		pkg/fun_0_7.h \
		pkg/fun_0_8.h \
		pkg/fun_0_9.h \
		pkg/fun_0_10.h \
		pkg/fun_0_11.h \
		pkg/fun_0_12.h \
		pkg/fun_0_13.h \
		pkg/fun_0_14.h \
		pkg/fun_0_15.h \
		pkg/fun_0_16.h \
		pkg/fun_0_17.h \
		pkg/fun_0_18.h \
		pkg/fun_0_19.h

o//pkg/fun_0.a: \
		o//pkg/fun_0_0.o \
		o//pkg/fun_0_1.o \
		o//pkg/fun_0_2.o \
		o//pkg/fun_0_3.o \
		o//pkg/fun_0_4.o \
		o//pkg/fun_0_5.o \
		o//pkg/fun_0_6.o \
		o//pkg/fun_0_7.o \
		o//pkg/fun_0_8.o \
		o//pkg/fun_0_9.o \
		o//pkg/fun_0_10.o \
		o//pkg/fun_0_11.o \
		o//pkg/fun_0_12.o \
		o//pkg/fun_0_13.o \
		o//pkg/fun_0_14.o \
		o//pkg/fun_0_15.o \
		o//pkg/fun_0_16.o \
		o//pkg/fun_0_17.o \
		o//pkg/fun_0_18.o \
		o//pkg/fun_0_19.o

o//pkg/main_0.exe: \
		o//pkg/main_0.o \
		o//pkg/fun_0.a
o//pkg/fun_1_0.o: \
		pkg/fun_1_0.c \
		pkg/fun_1_0.h

o//pkg/fun_1_1.o: \
		pkg/fun_1_1.c \
		pkg/fun_1_1.h

o//pkg/fun_1_2.o: \
		pkg/fun_1_2.c \
		pkg/fun_1_2.h

o//pkg/fun_1_3.o: \
		pkg/fun_1_3.c \
		pkg/fun_1_3.h

o//pkg/fun_1_4.o: \
		pkg/fun_1_4.c \
		pkg/fun_1_4.h

o//pkg/fun_1_5.o: \
		pkg/fun_1_5.c \
		pkg/fun_1_5.h

o//pkg/fun_1_6.o: \
		pkg/fun_1_6.c \
		pkg/fun_1_6.h

o//pkg/fun_1_7.o: \
		pkg/fun_1_7.c \
		pkg/fun_1_7.h

o//pkg/fun_1_8.o: \
		pkg/fun_1_8.c \
		pkg/fun_1_8.h

o//pkg/fun_1_9.o: \
		pkg/fun_1_9.c \
		pkg/fun_1_9.h

o//pkg/fun_1_10.o: \
		pkg/fun_1_10.c \
		pkg/fun_1_10.h

o//pkg/fun_1_11.o: \
		pkg/fun_1_11.c \
		pkg/fun_1_11.h

o//pkg/fun_1_12.o: \
		pkg/fun_1_12.c \
		pkg/fun_1_12.h

o//pkg/fun_1_13.o: \
		pkg/fun_1_13.c \
		pkg/fun_1_13.h

o//pkg/fun_1_14.o: \
		pkg/fun_1_14.c \
		pkg/fun_1_14.h

o//pkg/fun_1_15.o: \
		pkg/fun_1_15.c \
		pkg/fun_1_15.h

o//pkg/fun_1_16.o: \
		pkg/fun_1_16.c \
		pkg/fun_1_16.h

o//pkg/fun_1_17.o: \
		pkg/fun_1_17.c \
		pkg/fun_1_17.h

o//pkg/fun_1_18.o: \
		pkg/fun_1_18.c \
		pkg/fun_1_18.h

o//pkg/fun_1_19.o: \
		pkg/fun_1_19.c \
		pkg/fun_1_19.h

o//pkg/main_1.o: \
		pkg/main_1.c \
		pkg/fun_1_0.h \
		pkg/fun_1_1.h \
		pkg/fun_1_2.h \
		pkg/fun_1_3.h \
		pkg/fun_1_4.h \
		pkg/fun_1_5.h \
		pkg/fun_1_6.h \
		pkg/fun_1_7.h \
		pkg/fun_1_8.h \
		pkg/fun_1_9.h \
		pkg/fun_1_10.h \
		pkg/fun_1_11.h \
		pkg/fun_1_12.h \
		pkg/fun_1_13.h \
		pkg/fun_1_14.h \
		pkg/fun_1_15.h \
		pkg/fun_1_16.h \
		pkg/fun_1_17.h \
		pkg/fun_1_18.h \
		pkg/fun_1_19.h

o//pkg/fun_1.a: \
		o//pkg/fun_1_0.o \
		o//pkg/fun_1_1.o \
		o//pkg/fun_1_2.o \
		o//pkg/fun_1_3.o \
		o//pkg/fun_1_4.o \
		o//pkg/fun_1_5.o \
		o//pkg/fun_1_6.o \
		o//pkg/fun_1_7.o \
		o//pkg/fun_1_8.o \
		o//pkg/fun_1_9.o \
		o//pkg/fun_1_10.o \
		o//pkg/fun_1_11.o \
		o//pkg/fun_1_12.o \
		o//pkg/fun_1_13.o \
		o//pkg/fun_1_14.o \
		o//pkg/fun_1_15.o \
		o//pkg/fun_1_16.o \
		o//pkg/fun_1_17.o \
		o//pkg/fun_1_18.o \
		o//pkg/fun_1_19.o

o//pkg/main_1.exe: \
		o//pkg/main_1.o \
		o//pkg/fun_1.a
o//pkg/fun_2_0.o: \
		pkg/fun_2_0.c \
		pkg/fun_2_0.h

o//pkg/fun_2_1.o: \
		pkg/fun_2_1.c \
		pkg/fun_2_1.h

o//pkg/fun_2_2.o: \
		pkg/fun_2_2.c \
		pkg/fun_2_2.h

o//pkg/fun_2_3.o: \
		pkg/fun_2_3.c \
		pkg/fun_2_3.h

o//pkg/fun_2_4.o: \
		pkg/fun_2_4.c \
		pkg/fun_2_4.h

o//pkg/fun_2_5.o: \
		pkg/fun_2_5.c \
		pkg/fun_2_5.h

o//pkg/fun_2_6.o: \
		pkg/fun_2_6.c \
		pkg/fun_2_6.h

o//pkg/fun_2_7.o: \
		pkg/fun_2_7.c \
		pkg/fun_2_7.h

o//pkg/fun_2_8.o: \
		pkg/fun_2_8.c \
		pkg/fun_2_8.h

o//pkg/fun_2_9.o: \
		pkg/fun_2_9.c \
		pkg/fun_2_9.h

o//pkg/fun_2_10.o: \
		pkg/fun_2_10.c \
		pkg/fun_2_10.h

o//pkg/fun_2_11.o: \
		pkg/fun_2_11.c \
		pkg/fun_2_11.h

o//pkg/fun_2_12.o: \
		pkg/fun_2_12.c \
		pkg/fun_2_12.h

o//pkg/fun_2_13.o: \
		pkg/fun_2_13.c \
		pkg/fun_2_13.h

o//pkg/fun_2_14.o: \
		pkg/fun_2_14.c \
		pkg/fun_2_14.h

o//pkg/fun_2_15.o: \
		pkg/fun_2_15.c \
		pkg/fun_2_15.h

o//pkg/fun_2_16.o: \
		pkg/fun_2_16.c \
		pkg/fun_2_16.h

o//pkg/fun_2_17.o: \
		pkg/fun_2_17.c \
		pkg/fun_2_17.h

o//pkg/fun_2_18.o: \
		pkg/fun_2_18.c \
		pkg/fun_2_18.h

o//pkg/fun_2_19.o: \
		pkg/fun_2_19.c \
		pkg/fun_2_19.h

o//pkg/main_2.o: \
		pkg/main_2.c \
		pkg/fun_2_0.h \
		pkg/fun_2_1.h \
		pkg/fun_2_2.h \
		pkg/fun_2_3.h \
		pkg/fun_2_4.h \
		pkg/fun_2_5.h \
		pkg/fun_2_6.h \
		pkg/fun_2_7.h \
		pkg/fun_2_8.h \
		pkg/fun_2_9.h \
		pkg/fun_2_10.h \
		pkg/fun_2_11.h \
		pkg/fun_2_12.h \
		pkg/fun_2_13.h \
		pkg/fun_2_14.h \
		pkg/fun_2_15.h \
		pkg/fun_2_16.h \
		pkg/fun_2_17.h \
		pkg/fun_2_18.h \
		pkg/fun_2_19.h

o//pkg/fun_2.a: \
		o//pkg/fun_2_0.o \
		o//pkg/fun_2_1.o \
		o//pkg/fun_2_2.o \
		o//pkg/fun_2_3.o \
		o//pkg/fun_2_4.o \
		o//pkg/fun_2_5.o \
		o//pkg/fun_2_6.o \
		o//pkg/fun_2_7.o \
		o//pkg/fun_2_8.o \
		o//pkg/fun_2_9.o \
		o//pkg/fun_2_10.o \
		o//pkg/fun_2_11.o \
		o//pkg/fun_2_12.o \
		o//pkg/fun_2_13.o \
		o//pkg/fun_2_14.o \
		o//pkg/fun_2_15.o \
		o//pkg/fun_2_16.o \
		o//pkg/fun_2_17.o \
		o//pkg/fun_2_18.o \
		o//pkg/fun_2_19.o

o//pkg/main_2.exe: \
		o//pkg/main_2.o \
		o//pkg/fun_2.a
o//pkg/fun_3_0.o: \
		pkg/fun_3_0.c \
		pkg/fun_3_0.h

o//pkg/fun_3_1.o: \
		pkg/fun_3_1.c \
		pkg/fun_3_1.h

o//pkg/fun_3_2.o: \
		pkg/fun_3_2.c \
		pkg/fun_3_2.h

o//pkg/fun_3_3.o: \
		pkg/fun_3_3.c \
		pkg/fun_3_3.h

o//pkg/fun_3_4.o: \
		pkg/fun_3_4.c \
		pkg/fun_3_4.h

o//pkg/fun_3_5.o: \
		pkg/fun_3_5.c \
		pkg/fun_3_5.h

o//pkg/fun_3_6.o: \
		pkg/fun_3_6.c \
		pkg/fun_3_6.h

o//pkg/fun_3_7.o: \
		pkg/fun_3_7.c \
		pkg/fun_3_7.h

o//pkg/fun_3_8.o: \
		pkg/fun_3_8.c \
		pkg/fun_3_8.h

o//pkg/fun_3_9.o: \
		pkg/fun_3_9.c \
		pkg/fun_3_9.h

o//pkg/fun_3_10.o: \
		pkg/fun_3_10.c \
		pkg/fun_3_10.h

o//pkg/fun_3_11.o: \
		pkg/fun_3_11.c \
		pkg/fun_3_11.h

o//pkg/fun_3_12.o: \
		pkg/fun_3_12.c \
		pkg/fun_3_12.h

o//pkg/fun_3_13.o: \
		pkg/fun_3_13.c \
		pkg/fun_3_13.h

o//pkg/fun_3_14.o: \
		pkg/fun_3_14.c \
		pkg/fun_3_14.h

o//pkg/fun_3_15.o: \
		pkg/fun_3_15.c \
		pkg/fun_3_15.h

o//pkg/fun_3_16.o: \
		pkg/fun_3_16.c \
		pkg/fun_3_16.h

o//pkg/fun_3_17.o: \
		pkg/fun_3_17.c \
		pkg/fun_3_17.h

o//pkg/fun_3_18.o: \
		pkg/fun_3_18.c \
		pkg/fun_3_18.h

o//pkg/fun_3_19.o: \
		pkg/fun_3_19.c \
		pkg/fun_3_19.h

o//pkg/main_3.o: \
		pkg/main_3.c \
		pkg/fun_3_0.h \
		pkg/fun_3_1.h \
		pkg/fun_3_2.h \
		pkg/fun_3_3.h \
		pkg/fun_3_4.h \
		pkg/fun_3_5.h \
		pkg/fun_3_6.h \
		pkg/fun_3_7.h \
		pkg/fun_3_8.h \
		pkg/fun_3_9.h \
		pkg/fun_3_10.h \
		pkg/fun_3_11.h \
		pkg/fun_3_12.h \
		pkg/fun_3_13.h \
		pkg/fun_3_14.h \
		pkg/fun_3_15.h \
		pkg/fun_3_16.h \
		pkg/fun_3_17.h \
		pkg/fun_3_18.h \
		pkg/fun_3_19.h

o//pkg/fun_3.a: \
		o//pkg/fun_3_0.o \
		o//pkg/fun_3_1.o \
		o//pkg/fun_3_2.o \
		o//pkg/fun_3_3.o \
		o//pkg/fun_3_4.o \
		o//pkg/fun_3_5.o \
		o//pkg/fun_3_6.o \
		o//pkg/fun_3_7.o \
		o//pkg/fun_3_8.o \
		o//pkg/fun_3_9.o \
		o//pkg/fun_3_10.o \
		o//pkg/fun_3_11.o \
		o//pkg/fun_3_12.o \
		o//pkg/fun_3_13.o \
		o//pkg/fun_3_14.o \
		o//pkg/fun_3_15.o \
		o//pkg/fun_3_16.o \
		o//pkg/fun_3_17.o \
		o//pkg/fun_3_18.o \
		o//pkg/fun_3_19.o

o//pkg/main_3.exe: \
		o//pkg/main_3.o \
		o//pkg/fun_3.a
o//pkg/fun_4_0.o: \
		pkg/fun_4_0.c \
		pkg/fun_4_0.h

o//pkg/fun_4_1.o: \
		pkg/fun_4_1.c \
		pkg/fun_4_1.h

o//pkg/fun_4_2.o: \
		pkg/fun_4_2.c \
		pkg/fun_4_2.h

o//pkg/fun_4_3.o: \
		pkg/fun_4_3.c \
		pkg/fun_4_3.h

o//pkg/fun_4_4.o: \
		pkg/fun_4_4.c \
		pkg/fun_4_4.h

o//pkg/fun_4_5.o: \
		pkg/fun_4_5.c \
		pkg/fun_4_5.h

o//pkg/fun_4_6.o: \
		pkg/fun_4_6.c \
		pkg/fun_4_6.h

o//pkg/fun_4_7.o: \
		pkg/fun_4_7.c \
		pkg/fun_4_7.h

o//pkg/fun_4_8.o: \
		pkg/fun_4_8.c \
		pkg/fun_4_8.h

o//pkg/fun_4_9.o: \
		pkg/fun_4_9.c \
		pkg/fun_4_9.h

o//pkg/fun_4_10.o: \
		pkg/fun_4_10.c \
		pkg/fun_4_10.h

o//pkg/fun_4_11.o: \
		pkg/fun_4_11.c \
		pkg/fun_4_11.h

o//pkg/fun_4_12.o: \
		pkg/fun_4_12.c \
		pkg/fun_4_12.h

o//pkg/fun_4_13.o: \
		pkg/fun_4_13.c \
		pkg/fun_4_13.h

o//pkg/fun_4_14.o: \
		pkg/fun_4_14.c \
		pkg/fun_4_14.h

o//pkg/fun_4_15.o: \
		pkg/fun_4_15.c \
		pkg/fun_4_15.h

o//pkg/fun_4_16.o: \
		pkg/fun_4_16.c \
		pkg/fun_4_16.h

o//pkg/fun_4_17.o: \
		pkg/fun_4_17.c \
		pkg/fun_4_17.h

o//pkg/fun_4_18.o: \
		pkg/fun_4_18.c \
		pkg/fun_4_18.h

o//pkg/fun_4_19.o: \
		pkg/fun_4_19.c \
		pkg/fun_4_19.h

o//pkg/main_4.o: \
		pkg/main_4.c \
		pkg/fun_4_0.h \
		pkg/fun_4_1.h \
		pkg/fun_4_2.h \
		pkg/fun_4_3.h \
		pkg/fun_4_4.h \
		pkg/fun_4_5.h \
		pkg/fun_4_6.h \
		pkg/fun_4_7.h \
		pkg/fun_4_8.h \
		pkg/fun_4_9.h \
		pkg/fun_4_10.h \
		pkg/fun_4_11.h \
		pkg/fun_4_12.h \
		pkg/fun_4_13.h \
		pkg/fun_4_14.h \
		pkg/fun_4_15.h \
		pkg/fun_4_16.h \
		pkg/fun_4_17.h \
		pkg/fun_4_18.h \
		pkg/fun_4_19.h

o//pkg/fun_4.a: \
		o//pkg/fun_4_0.o \
		o//pkg/fun_4_1.o \
		o//pkg/fun_4_2.o \
		o//pkg/fun_4_3.o \
		o//pkg/fun_4_4.o \
		o//pkg/fun_4_5.o \
		o//pkg/fun_4_6.o \
		o//pkg/fun_4_7.o \
		o//pkg/fun_4_8.o \
		o//pkg/fun_4_9.o \
		o//pkg/fun_4_10.o \
		o//pkg/fun_4_11.o \
		o//pkg/fun_4_12.o \
		o//pkg/fun_4_13.o \
		o//pkg/fun_4_14.o \
		o//pkg/fun_4_15.o \
		o//pkg/fun_4_16.o \
		o//pkg/fun_4_17.o \
		o//pkg/fun_4_18.o \
		o//pkg/fun_4_19.o

o//pkg/main_4.exe: \
		o//pkg/main_4.o \
		o//pkg/fun_4.a
o//pkg/fun_5_0.o: \
		pkg/fun_5_0.c \
		pkg/fun_5_0.h

o//pkg/fun_5_1.o: \
		pkg/fun_5_1.c \
		pkg/fun_5_1.h

o//pkg/fun_5_2.o: \
		pkg/fun_5_2.c \
		pkg/fun_5_2.h

o//pkg/fun_5_3.o: \
		pkg/fun_5_3.c \
		pkg/fun_5_3.h

o//pkg/fun_5_4.o: \
		pkg/fun_5_4.c \
		pkg/fun_5_4.h

o//pkg/fun_5_5.o: \
		pkg/fun_5_5.c \
		pkg/fun_5_5.h

o//pkg/fun_5_6.o: \
		pkg/fun_5_6.c \
		pkg/fun_5_6.h

o//pkg/fun_5_7.o: \
		pkg/fun_5_7.c \
		pkg/fun_5_7.h

o//pkg/fun_5_8.o: \
		pkg/fun_5_8.c \
		pkg/fun_5_8.h

o//pkg/fun_5_9.o: \
		pkg/fun_5_9.c \
		pkg/fun_5_9.h

o//pkg/fun_5_10.o: \
		pkg/fun_5_10.c \
		pkg/fun_5_10.h

o//pkg/fun_5_11.o: \
		pkg/fun_5_11.c \
		pkg/fun_5_11.h

o//pkg/fun_5_12.o: \
		pkg/fun_5_12.c \
		pkg/fun_5_12.h

o//pkg/fun_5_13.o: \
		pkg/fun_5_13.c \
		pkg/fun_5_13.h

o//pkg/fun_5_14.o: \
		pkg/fun_5_14.c \
		pkg/fun_5_14.h

o//pkg/fun_5_15.o: \
		pkg/fun_5_15.c \
		pkg/fun_5_15.h

o//pkg/fun_5_16.o: \
		pkg/fun_5_16.c \
		pkg/fun_5_16.h

o//pkg/fun_5_17.o: \
		pkg/fun_5_17.c \
		pkg/fun_5_17.h

o//pkg/fun_5_18.o: \
		pkg/fun_5_18.c \
		pkg/fun_5_18.h

o//pkg/fun_5_19.o: \
		pkg/fun_5_19.c \
		pkg/fun_5_19.h

o//pkg/main_5.o: \
		pkg/main_5.c \
		pkg/fun_5_0.h \
		pkg/fun_5_1.h \
		pkg/fun_5_2.h \
		pkg/fun_5_3.h \
		pkg/fun_5_4.h \
		pkg/fun_5_5.h \
		pkg/fun_5_6.h \
		pkg/fun_5_7.h \
		pkg/fun_5_8.h \
		pkg/fun_5_9.h \
		pkg/fun_5_10.h \
		pkg/fun_5_11.h \
		pkg/fun_5_12.h \
		pkg/fun_5_13.h \
		pkg/fun_5_14.h \
		pkg/fun_5_15.h \
		pkg/fun_5_16.h \
		pkg/fun_5_17.h \
		pkg/fun_5_18.h \
		pkg/fun_5_19.h

o//pkg/fun_5.a: \
		o//pkg/fun_5_0.o \
		o//pkg/fun_5_1.o \
		o//pkg/fun_5_2.o \
		o//pkg/fun_5_3.o \
		o//pkg/fun_5_4.o \
		o//pkg/fun_5_5.o \
		o//pkg/fun_5_6.o \
		o//pkg/fun_5_7.o \
		o//pkg/fun_5_8.o \
		o//pkg/fun_5_9.o \
		o//pkg/fun_5_10.o \
		o//pkg/fun_5_11.o \
		o//pkg/fun_5_12.o \
		o//pkg/fun_5_13.o \
		o//pkg/fun_5_14.o \
		o//pkg/fun_5_15.o \
		o//pkg/fun_5_16.o \
		o//pkg/fun_5_17.o \
		o//pkg/fun_5_18.o \
		o//pkg/fun_5_19.o

o//pkg/main_5.exe: \
		o//pkg/main_5.o \
		o//pkg/fun_5.a
o//pkg/fun_6_0.o: \
		pkg/fun_6_0.c \
		pkg/fun_6_0.h

o//pkg/fun_6_1.o: \
		pkg/fun_6_1.c \
		pkg/fun_6_1.h

o//pkg/fun_6_2.o: \
		pkg/fun_6_2.c \
		pkg/fun_6_2.h

o//pkg/fun_6_3.o: \
		pkg/fun_6_3.c \
		pkg/fun_6_3.h

o//pkg/fun_6_4.o: \
		pkg/fun_6_4.c \
		pkg/fun_6_4.h

o//pkg/fun_6_5.o: \
		pkg/fun_6_5.c \
		pkg/fun_6_5.h

o//pkg/fun_6_6.o: \
		pkg/fun_6_6.c \
		pkg/fun_6_6.h

o//pkg/fun_6_7.o: \
		pkg/fun_6_7.c \
		pkg/fun_6_7.h

o//pkg/fun_6_8.o: \
		pkg/fun_6_8.c \
		pkg/fun_6_8.h

o//pkg/fun_6_9.o: \
		pkg/fun_6_9.c \
		pkg/fun_6_9.h

o//pkg/fun_6_10.o: \
		pkg/fun_6_10.c \
		pkg/fun_6_10.h

o//pkg/fun_6_11.o: \
		pkg/fun_6_11.c \
		pkg/fun_6_11.h

o//pkg/fun_6_12.o: \
		pkg/fun_6_12.c \
		pkg/fun_6_12.h

o//pkg/fun_6_13.o: \
		pkg/fun_6_13.c \
		pkg/fun_6_13.h

o//pkg/fun_6_14.o: \
		pkg/fun_6_14.c \
		pkg/fun_6_14.h

o//pkg/fun_6_15.o: \
		pkg/fun_6_15.c \
		pkg/fun_6_15.h

o//pkg/fun_6_16.o: \
		pkg/fun_6_16.c \
		pkg/fun_6_16.h

o//pkg/fun_6_17.o: \
		pkg/fun_6_17.c \
		pkg/fun_6_17.h

o//pkg/fun_6_18.o: \
		pkg/fun_6_18.c \
		pkg/fun_6_18.h

o//pkg/fun_6_19.o: \
		pkg/fun_6_19.c \
		pkg/fun_6_19.h

o//pkg/main_6.o: \
		pkg/main_6.c \
		pkg/fun_6_0.h \
		pkg/fun_6_1.h \
		pkg/fun_6_2.h \
		pkg/fun_6_3.h \
		pkg/fun_6_4.h \
		pkg/fun_6_5.h \
		pkg/fun_6_6.h \
		pkg/fun_6_7.h \
		pkg/fun_6_8.h \
		pkg/fun_6_9.h \
		pkg/fun_6_10.h \
		pkg/fun_6_11.h \
		pkg/fun_6_12.h \
		pkg/fun_6_13.h \
		pkg/fun_6_14.h \
		pkg/fun_6_15.h \
		pkg/fun_6_16.h \
		pkg/fun_6_17.h \
		pkg/fun_6_18.h \
		pkg/fun_6_19.h

o//pkg/fun_6.a: \
		o//pkg/fun_6_0.o \
		o//pkg/fun_6_1.o \
		o//pkg/fun_6_2.o \
		o//pkg/fun_6_3.o \
		o//pkg/fun_6_4.o \
		o//pkg/fun_6_5.o \
		o//pkg/fun_6_6.o \
		o//pkg/fun_6_7.o \
		o//pkg/fun_6_8.o \
		o//pkg/fun_6_9.o \
		o//pkg/fun_6_10.o \
		o//pkg/fun_6_11.o \
		o//pkg/fun_6_12.o \
		o//pkg/fun_6_13.o \
		o//pkg/fun_6_14.o \
		o//pkg/fun_6_15.o \
		o//pkg/fun_6_16.o \
		o//pkg/fun_6_17.o \
		o//pkg/fun_6_18.o \
		o//pkg/fun_6_19.o

o//pkg/main_6.exe: \
		o//pkg/main_6.o \
		o//pkg/fun_6.a
o//pkg/fun_7_0.o: \
		pkg/fun_7_0.c \
		pkg/fun_7_0.h

o//pkg/fun_7_1.o: \
		pkg/fun_7_1.c \
		pkg/fun_7_1.h

o//pkg/fun_7_2.o: \
		pkg/fun_7_2.c \
		pkg/fun_7_2.h

o//pkg/fun_7_3.o: \
		pkg/fun_7_3.c \
		pkg/fun_7_3.h

o//pkg/fun_7_4.o: \
		pkg/fun_7_4.c \
		pkg/fun_7_4.h

o//pkg/fun_7_5.o: \
		pkg/fun_7_5.c \
		pkg/fun_7_5.h

o//pkg/fun_7_6.o: \
		pkg/fun_7_6.c \
		pkg/fun_7_6.h

o//pkg/fun_7_7.o: \
		pkg/fun_7_7.c \
		pkg/fun_7_7.h

o//pkg/fun_7_8.o: \
		pkg/fun_7_8.c \
		pkg/fun_7_8.h

o//pkg/fun_7_9.o: \
		pkg/fun_7_9.c \
		pkg/fun_7_9.h

o//pkg/fun_7_10.o: \
		pkg/fun_7_10.c \
		pkg/fun_7_10.h

o//pkg/fun_7_11.o: \
		pkg/fun_7_11.c \
		pkg/fun_7_11.h

o//pkg/fun_7_12.o: \
		pkg/fun_7_12.c \
		pkg/fun_7_12.h

o//pkg/fun_7_13.o: \
		pkg/fun_7_13.c \
		pkg/fun_7_13.h

o//pkg/fun_7_14.o: \
		pkg/fun_7_14.c \
		pkg/fun_7_14.h

o//pkg/fun_7_15.o: \
		pkg/fun_7_15.c \
		pkg/fun_7_15.h

o//pkg/fun_7_16.o: \
		pkg/fun_7_16.c \
		pkg/fun_7_16.h

o//pkg/fun_7_17.o: \
		pkg/fun_7_17.c \
		pkg/fun_7_17.h

o//pkg/fun_7_18.o: \
		pkg/fun_7_18.c \
		pkg/fun_7_18.h

o//pkg/fun_7_19.o: \
		pkg/fun_7_19.c \
		pkg/fun_7_19.h

o//pkg/main_7.o: \
		pkg/main_7.c \
		pkg/fun_7_0.h \
		pkg/fun_7_1.h \
		pkg/fun_7_2.h \
		pkg/fun_7_3.h \
		pkg/fun_7_4.h \
		pkg/fun_7_5.h \
		pkg/fun_7_6.h \
		pkg/fun_7_7.h \
		pkg/fun_7_8.h \
		pkg/fun_7_9.h \
		pkg/fun_7_10.h \
		pkg/fun_7_11.h \
		pkg/fun_7_12.h \
		pkg/fun_7_13.h \
		pkg/fun_7_14.h \
		pkg/fun_7_15.h \
		pkg/fun_7_16.h \
		pkg/fun_7_17.h \
		pkg/fun_7_18.h \
		pkg/fun_7_19.h

o//pkg/fun_7.a: \
		o//pkg/fun_7_0.o \
		o//pkg/fun_7_1.o \
		o//pkg/fun_7_2.o \
		o//pkg/fun_7_3.o \
		o//pkg/fun_7_4.o \
		o//pkg/fun_7_5.o \
		o//pkg/fun_7_6.o \
		o//pkg/fun_7_7.o \
		o//pkg/fun_7_8.o \
		o//pkg/fun_7_9.o \
		o//pkg/fun_7_10.o \
		o//pkg/fun_7_11.o \
		o//pkg/fun_7_12.o \
		o//pkg/fun_7_13.o \
		o//pkg/fun_7_14.o \
		o//pkg/fun_7_15.o \
		o//pkg/fun_7_16.o \
		o//pkg/fun_7_17.o \
		o//pkg/fun_7_18.o \
		o//pkg/fun_7_19.o

o//pkg/main_7.exe: \
		o//pkg/main_7.o \
		o//pkg/fun_7.a
o//pkg/fun_8_0.o: \
		pkg/fun_8_0.c \
		pkg/fun_8_0.h

o//pkg/fun_8_1.o: \
		pkg/fun_8_1.c \
		pkg/fun_8_1.h

o//pkg/fun_8_2.o: \
		pkg/fun_8_2.c \
		pkg/fun_8_2.h

o//pkg/fun_8_3.o: \
		pkg/fun_8_3.c \
		pkg/fun_8_3.h

o//pkg/fun_8_4.o: \
		pkg/fun_8_4.c \
		pkg/fun_8_4.h

o//pkg/fun_8_5.o: \
		pkg/fun_8_5.c \
		pkg/fun_8_5.h

o//pkg/fun_8_6.o: \
		pkg/fun_8_6.c \
		pkg/fun_8_6.h

o//pkg/fun_8_7.o: \
		pkg/fun_8_7.c \
		pkg/fun_8_7.h

o//pkg/fun_8_8.o: \
		pkg/fun_8_8.c \
		pkg/fun_8_8.h

o//pkg/fun_8_9.o: \
		pkg/fun_8_9.c \
		pkg/fun_8_9.h

o//pkg/fun_8_10.o: \
		pkg/fun_8_10.c \
		pkg/fun_8_10.h

o//pkg/fun_8_11.o: \
		pkg/fun_8_11.c \
		pkg/fun_8_11.h

o//pkg/fun_8_12.o: \
		pkg/fun_8_12.c \
		pkg/fun_8_12.h

o//pkg/fun_8_13.o: \
		pkg/fun_8_13.c \
		pkg/fun_8_13.h

o//pkg/fun_8_14.o: \
		pkg/fun_8_14.c \
		pkg/fun_8_14.h

o//pkg/fun_8_15.o: \
		pkg/fun_8_15.c \
		pkg/fun_8_15.h

o//pkg/fun_8_16.o: \
		pkg/fun_8_16.c \
		pkg/fun_8_16.h

o//pkg/fun_8_17.o: \
		pkg/fun_8_17.c \
		pkg/fun_8_17.h

o//pkg/fun_8_18.o: \
		pkg/fun_8_18.c \
		pkg/fun_8_18.h

o//pkg/fun_8_19.o: \
		pkg/fun_8_19.c \
		pkg/fun_8_19.h

o//pkg/main_8.o: \
		pkg/main_8.c \
		pkg/fun_8_0.h \
		pkg/fun_8_1.h \
		pkg/fun_8_2.h \
		pkg/fun_8_3.h \
		pkg/fun_8_4.h \
		pkg/fun_8_5.h \
		pkg/fun_8_6.h \
		pkg/fun_8_7.h \
		pkg/fun_8_8.h \
		pkg/fun_8_9.h \
		pkg/fun_8_10.h \
		pkg/fun_8_11.h \
		pkg/fun_8_12.h \
		pkg/fun_8_13.h \
		pkg/fun_8_14.h \
		pkg/fun_8_15.h \
		pkg/fun_8_16.h \
		pkg/fun_8_17.h \
		pkg/fun_8_18.h \
		pkg/fun_8_19.h

o//pkg/fun_8.a: \
		o//pkg/fun_8_0.o \
		o//pkg/fun_8_1.o \
		o//pkg/fun_8_2.o \
		o//pkg/fun_8_3.o \
		o//pkg/fun_8_4.o \
		o//pkg/fun_8_5.o \
		o//pkg/fun_8_6.o \
		o//pkg/fun_8_7.o \
		o//pkg/fun_8_8.o \
		o//pkg/fun_8_9.o \
		o//pkg/fun_8_10.o \
		o//pkg/fun_8_11.o \
		o//pkg/fun_8_12.o \
		o//pkg/fun_8_13.o \
		o//pkg/fun_8_14.o \
		o//pkg/fun_8_15.o \
		o//pkg/fun_8_16.o \
		o//pkg/fun_8_17.o \
		o//pkg/fun_8_18.o \
		o//pkg/fun_8_19.o

o//pkg/main_8.exe: \
		o//pkg/main_8.o \
		o//pkg/fun_8.a
o//pkg/fun_9_0.o: \
		pkg/fun_9_0.c \
		pkg/fun_9_0.h

o//pkg/fun_9_1.o: \
		pkg/fun_9_1.c \
		pkg/fun_9_1.h

o//pkg/fun_9_2.o: \
		pkg/fun_9_2.c \
		pkg/fun_9_2.h

o//pkg/fun_9_3.o: \
		pkg/fun_9_3.c \
		pkg/fun_9_3.h

o//pkg/fun_9_4.o: \
		pkg/fun_9_4.c \
		pkg/fun_9_4.h

o//pkg/fun_9_5.o: \
		pkg/fun_9_5.c \
		pkg/fun_9_5.h

o//pkg/fun_9_6.o: \
		pkg/fun_9_6.c \
		pkg/fun_9_6.h

o//pkg/fun_9_7.o: \
		pkg/fun_9_7.c \
		pkg/fun_9_7.h

o//pkg/fun_9_8.o: \
		pkg/fun_9_8.c \
		pkg/fun_9_8.h

o//pkg/fun_9_9.o: \
		pkg/fun_9_9.c \
		pkg/fun_9_9.h

o//pkg/fun_9_10.o: \
		pkg/fun_9_10.c \
		pkg/fun_9_10.h

o//pkg/fun_9_11.o: \
		pkg/fun_9_11.c \
		pkg/fun_9_11.h

o//pkg/fun_9_12.o: \
		pkg/fun_9_12.c \
		pkg/fun_9_12.h

o//pkg/fun_9_13.o: \
		pkg/fun_9_13.c \
		pkg/fun_9_13.h

o//pkg/fun_9_14.o: \
		pkg/fun_9_14.c \
		pkg/fun_9_14.h

o//pkg/fun_9_15.o: \
		pkg/fun_9_15.c \
		pkg/fun_9_15.h

o//pkg/fun_9_16.o: \
		pkg/fun_9_16.c \
		pkg/fun_9_16.h

o//pkg/fun_9_17.o: \
		pkg/fun_9_17.c \
		pkg/fun_9_17.h

o//pkg/fun_9_18.o: \
		pkg/fun_9_18.c \
		pkg/fun_9_18.h

o//pkg/fun_9_19.o: \
		pkg/fun_9_19.c \
		pkg/fun_9_19.h

o//pkg/main_9.o: \
		pkg/main_9.c \
		pkg/fun_9_0.h \
		pkg/fun_9_1.h \
		pkg/fun_9_2.h \
		pkg/fun_9_3.h \
		pkg/fun_9_4.h \
		pkg/fun_9_5.h \
		pkg/fun_9_6.h \
		pkg/fun_9_7.h \
		pkg/fun_9_8.h \
		pkg/fun_9_9.h \
		pkg/fun_9_10.h \
		pkg/fun_9_11.h \
		pkg/fun_9_12.h \
		pkg/fun_9_13.h \
		pkg/fun_9_14.h \
		pkg/fun_9_15.h \
		pkg/fun_9_16.h \
		pkg/fun_9_17.h \
		pkg/fun_9_18.h \
		pkg/fun_9_19.h

o//pkg/fun_9.a: \
		o//pkg/fun_9_0.o \
		o//pkg/fun_9_1.o \
		o//pkg/fun_9_2.o \
		o//pkg/fun_9_3.o \
		o//pkg/fun_9_4.o \
		o//pkg/fun_9_5.o \
		o//pkg/fun_9_6.o \
		o//pkg/fun_9_7.o \
		o//pkg/fun_9_8.o \
		o//pkg/fun_9_9.o \
		o//pkg/fun_9_10.o \
		o//pkg/fun_9_11.o \
		o//pkg/fun_9_12.o \
		o//pkg/fun_9_13.o \
		o//pkg/fun_9_14.o \
		o//pkg/fun_9_15.o \
		o//pkg/fun_9_16.o \
		o//pkg/fun_9_17.o \
		o//pkg/fun_9_18.o \
		o//pkg/fun_9_19.o

o//pkg/main_9.exe: \
		o//pkg/main_9.o \
		o//pkg/fun_9.a
o//pkg/fun_10_0.o: \
		pkg/fun_10_0.c \
		pkg/fun_10_0.h

o//pkg/fun_10_1.o: \
		pkg/fun_10_1.c \
		pkg/fun_10_1.h

o//pkg/fun_10_2.o: \
		pkg/fun_10_2.c \
		pkg/fun_10_2.h

o//pkg/fun_10_3.o: \
		pkg/fun_10_3.c \
		pkg/fun_10_3.h

o//pkg/fun_10_4.o: \
		pkg/fun_10_4.c \
		pkg/fun_10_4.h

o//pkg/fun_10_5.o: \
		pkg/fun_10_5.c \
		pkg/fun_10_5.h

o//pkg/fun_10_6.o: \
		pkg/fun_10_6.c \
		pkg/fun_10_6.h

o//pkg/fun_10_7.o: \
		pkg/fun_10_7.c \
		pkg/fun_10_7.h

o//pkg/fun_10_8.o: \
		pkg/fun_10_8.c \
		pkg/fun_10_8.h

o//pkg/fun_10_9.o: \
		pkg/fun_10_9.c \
		pkg/fun_10_9.h

o//pkg/fun_10_10.o: \
		pkg/fun_10_10.c \
		pkg/fun_10_10.h

o//pkg/fun_10_11.o: \
		pkg/fun_10_11.c \
		pkg/fun_10_11.h

o//pkg/fun_10_12.o: \
		pkg/fun_10_12.c \
		pkg/fun_10_12.h

o//pkg/fun_10_13.o: \
		pkg/fun_10_13.c \
		pkg/fun_10_13.h

o//pkg/fun_10_14.o: \
		pkg/fun_10_14.c \
		pkg/fun_10_14.h

o//pkg/fun_10_15.o: \
		pkg/fun_10_15.c \
		pkg/fun_10_15.h

o//pkg/fun_10_16.o: \
		pkg/fun_10_16.c \
		pkg/fun_10_16.h

o//pkg/fun_10_17.o: \
		pkg/fun_10_17.c \
		pkg/fun_10_17.h

o//pkg/fun_10_18.o: \
		pkg/fun_10_18.c \
		pkg/fun_10_18.h

o//pkg/fun_10_19.o: \
		pkg/fun_10_19.c \
		pkg/fun_10_19.h

o//pkg/main_10.o: \
		pkg/main_10.c \
		pkg/fun_10_0.h \
		pkg/fun_10_1.h \
		pkg/fun_10_2.h \
		pkg/fun_10_3.h \
		pkg/fun_10_4.h \
		pkg/fun_10_5.h \
		pkg/fun_10_6.h \
		pkg/fun_10_7.h \
		pkg/fun_10_8.h \
		pkg/fun_10_9.h \
		pkg/fun_10_10.h \
		pkg/fun_10_11.h \
		pkg/fun_10_12.h \
		pkg/fun_10_13.h \
		pkg/fun_10_14.h \
		pkg/fun_10_15.h \
		pkg/fun_10_16.h \
		pkg/fun_10_17.h \
		pkg/fun_10_18.h \
		pkg/fun_10_19.h

o//pkg/fun_10.a: \
		o//pkg/fun_10_0.o \
		o//pkg/fun_10_1.o \
		o//pkg/fun_10_2.o \
		o//pkg/fun_10_3.o \
		o//pkg/fun_10_4.o \
		o//pkg/fun_10_5.o \
		o//pkg/fun_10_6.o \
		o//pkg/fun_10_7.o \
		o//pkg/fun_10_8.o \
		o//pkg/fun_10_9.o \
		o//pkg/fun_10_10.o \
		o//pkg/fun_10_11.o \
		o//pkg/fun_10_12.o \
		o//pkg/fun_10_13.o \
		o//pkg/fun_10_14.o \
		o//pkg/fun_10_15.o \
		o//pkg/fun_10_16.o \
		o//pkg/fun_10_17.o \
		o//pkg/fun_10_18.o \
		o//pkg/fun_10_19.o

o//pkg/main_10.exe: \
		o//pkg/main_10.o \
		o//pkg/fun_10.a
o//pkg/fun_11_0.o: \
		pkg/fun_11_0.c \
		pkg/fun_11_0.h

o//pkg/fun_11_1.o: \
		pkg/fun_11_1.c \
		pkg/fun_11_1.h

o//pkg/fun_11_2.o: \
		pkg/fun_11_2.c \
		pkg/fun_11_2.h

o//pkg/fun_11_3.o: \
		pkg/fun_11_3.c \
		pkg/fun_11_3.h

o//pkg/fun_11_4.o: \
		pkg/fun_11_4.c \
		pkg/fun_11_4.h

o//pkg/fun_11_5.o: \
		pkg/fun_11_5.c \
		pkg/fun_11_5.h

o//pkg/fun_11_6.o: \
		pkg/fun_11_6.c \
		pkg/fun_11_6.h

o//pkg/fun_11_7.o: \
		pkg/fun_11_7.c \
		pkg/fun_11_7.h

o//pkg/fun_11_8.o: \
		pkg/fun_11_8.c \
		pkg/fun_11_8.h

o//pkg/fun_11_9.o: \
		pkg/fun_11_9.c \
		pkg/fun_11_9.h

o//pkg/fun_11_10.o: \
		pkg/fun_11_10.c \
		pkg/fun_11_10.h

o//pkg/fun_11_11.o: \
		pkg/fun_11_11.c \
		pkg/fun_11_11.h

o//pkg/fun_11_12.o: \
		pkg/fun_11_12.c \
		pkg/fun_11_12.h

o//pkg/fun_11_13.o: \
		pkg/fun_11_13.c \
		pkg/fun_11_13.h

o//pkg/fun_11_14.o: \
		pkg/fun_11_14.c \
		pkg/fun_11_14.h

o//pkg/fun_11_15.o: \
		pkg/fun_11_15.c \
		pkg/fun_11_15.h

o//pkg/fun_11_16.o: \
		pkg/fun_11_16.c \
		pkg/fun_11_16.h

o//pkg/fun_11_17.o: \
		pkg/fun_11_17.c \
		pkg/fun_11_17.h

o//pkg/fun_11_18.o: \
		pkg/fun_11_18.c \
		pkg/fun_11_18.h

o//pkg/fun_11_19.o: \
		pkg/fun_11_19.c \
		pkg/fun_11_19.h

o//pkg/main_11.o: \
		pkg/main_11.c \
		pkg/fun_11_0.h \
		pkg/fun_11_1.h \
		pkg/fun_11_2.h \
		pkg/fun_11_3.h \
		pkg/fun_11_4.h \
		pkg/fun_11_5.h \
		pkg/fun_11_6.h \
		pkg/fun_11_7.h \
		pkg/fun_11_8.h \
		pkg/fun_11_9.h \
		pkg/fun_11_10.h \
		pkg/fun_11_11.h \
		pkg/fun_11_12.h \
		pkg/fun_11_13.h \
		pkg/fun_11_14.h \
		pkg/fun_11_15.h \
		pkg/fun_11_16.h \
		pkg/fun_11_17.h \
		pkg/fun_11_18.h \
		pkg/fun_11_19.h

o//pkg/fun_11.a: \
		o//pkg/fun_11_0.o \
		o//pkg/fun_11_1.o \
		o//pkg/fun_11_2.o \
		o//pkg/fun_11_3.o \
		o//pkg/fun_11_4.o \
		o//pkg/fun_11_5.o \
		o//pkg/fun_11_6.o \
		o//pkg/fun_11_7.o \
		o//pkg/fun_11_8.o \
		o//pkg/fun_11_9.o \
		o//pkg/fun_11_10.o \
		o//pkg/fun_11_11.o \
		o//pkg/fun_11_12.o \
		o//pkg/fun_11_13.o \
		o//pkg/fun_11_14.o \
		o//pkg/fun_11_15.o \
		o//pkg/fun_11_16.o \
		o//pkg/fun_11_17.o \
		o//pkg/fun_11_18.o \
		o//pkg/fun_11_19.o

o//pkg/main_11.exe: \
		o//pkg/main_11.o \
		o//pkg/fun_11.a
o//pkg/fun_12_0.o: \
		pkg/fun_12_0.c \
		pkg/fun_12_0.h

o//pkg/fun_12_1.o: \
		pkg/fun_12_1.c \
		pkg/fun_12_1.h

o//pkg/fun_12_2.o: \
		pkg/fun_12_2.c \
		pkg/fun_12_2.h

o//pkg/fun_12_3.o: \
		pkg/fun_12_3.c \
		pkg/fun_12_3.h

o//pkg/fun_12_4.o: \
		pkg/fun_12_4.c \
		pkg/fun_12_4.h

o//pkg/fun_12_5.o: \
		pkg/fun_12_5.c \
		pkg/fun_12_5.h

o//pkg/fun_12_6.o: \
		pkg/fun_12_6.c \
		pkg/fun_12_6.h

o//pkg/fun_12_7.o: \
		pkg/fun_12_7.c \
		pkg/fun_12_7.h

o//pkg/fun_12_8.o: \
		pkg/fun_12_8.c \
		pkg/fun_12_8.h

o//pkg/fun_12_9.o: \
		pkg/fun_12_9.c \
		pkg/fun_12_9.h

o//pkg/fun_12_10.o: \
		pkg/fun_12_10.c \
		pkg/fun_12_10.h

o//pkg/fun_12_11.o: \
		pkg/fun_12_11.c \
		pkg/fun_12_11.h

o//pkg/fun_12_12.o: \
		pkg/fun_12_12.c \
		pkg/fun_12_12.h

o//pkg/fun_12_13.o: \
		pkg/fun_12_13.c \
		pkg/fun_12_13.h

o//pkg/fun_12_14.o: \
		pkg/fun_12_14.c \
		pkg/fun_12_14.h

o//pkg/fun_12_15.o: \
		pkg/fun_12_15.c \
		pkg/fun_12_15.h

o//pkg/fun_12_16.o: \
		pkg/fun_12_16.c \
		pkg/fun_12_16.h

o//pkg/fun_12_17.o: \
		pkg/fun_12_17.c \
		pkg/fun_12_17.h

o//pkg/fun_12_18.o: \
		pkg/fun_12_18.c \
		pkg/fun_12_18.h

o//pkg/fun_12_19.o: \
		pkg/fun_12_19.c \
		pkg/fun_12_19.h

o//pkg/main_12.o: \
		pkg/main_12.c \
		pkg/fun_12_0.h \
		pkg/fun_12_1.h \
		pkg/fun_12_2.h \
		pkg/fun_12_3.h \
		pkg/fun_12_4.h \
		pkg/fun_12_5.h \
		pkg/fun_12_6.h \
		pkg/fun_12_7.h \
		pkg/fun_12_8.h \
		pkg/fun_12_9.h \
		pkg/fun_12_10.h \
		pkg/fun_12_11.h \
		pkg/fun_12_12.h \
		pkg/fun_12_13.h \
		pkg/fun_12_14.h \
		pkg/fun_12_15.h \
		pkg/fun_12_16.h \
		pkg/fun_12_17.h \
		pkg/fun_12_18.h \
		pkg/fun_12_19.h

o//pkg/fun_12.a: \
		o//pkg/fun_12_0.o \
		o//pkg/fun_12_1.o \
		o//pkg/fun_12_2.o \
		o//pkg/fun_12_3.o \
		o//pkg/fun_12_4.o \
		o//pkg/fun_12_5.o \
		o//pkg/fun_12_6.o \
		o//pkg/fun_12_7.o \
		o//pkg/fun_12_8.o \
		o//pkg/fun_12_9.o \
		o//pkg/fun_12_10.o \
		o//pkg/fun_12_11.o \
		o//pkg/fun_12_12.o \
		o//pkg/fun_12_13.o \
		o//pkg/fun_12_14.o \
		o//pkg/fun_12_15.o \
		o//pkg/fun_12_16.o \
		o//pkg/fun_12_17.o \
		o//pkg/fun_12_18.o \
		o//pkg/fun_12_19.o

o//pkg/main_12.exe: \
		o//pkg/main_12.o \
		o//pkg/fun_12.a
o//pkg/fun_13_0.o: \
		pkg/fun_13_0.c \
		pkg/fun_13_0.h

o//pkg/fun_13_1.o: \
		pkg/fun_13_1.c \
		pkg/fun_13_1.h

o//pkg/fun_13_2.o: \
		pkg/fun_13_2.c \
		pkg/fun_13_2.h

o//pkg/fun_13_3.o: \
		pkg/fun_13_3.c \
		pkg/fun_13_3.h

o//pkg/fun_13_4.o: \
		pkg/fun_13_4.c \
		pkg/fun_13_4.h

o//pkg/fun_13_5.o: \
		pkg/fun_13_5.c \
		pkg/fun_13_5.h

o//pkg/fun_13_6.o: \
		pkg/fun_13_6.c \
		pkg/fun_13_6.h

o//pkg/fun_13_7.o: \
		pkg/fun_13_7.c \
		pkg/fun_13_7.h

o//pkg/fun_13_8.o: \
		pkg/fun_13_8.c \
		pkg/fun_13_8.h

o//pkg/fun_13_9.o: \
		pkg/fun_13_9.c \
		pkg/fun_13_9.h

o//pkg/fun_13_10.o: \
		pkg/fun_13_10.c \
		pkg/fun_13_10.h

o//pkg/fun_13_11.o: \
		pkg/fun_13_11.c \
		pkg/fun_13_11.h

o//pkg/fun_13_12.o: \
		pkg/fun_13_12.c \
		pkg/fun_13_12.h

o//pkg/fun_13_13.o: \
		pkg/fun_13_13.c \
		pkg/fun_13_13.h

o//pkg/fun_13_14.o: \
		pkg/fun_13_14.c \
		pkg/fun_13_14.h

o//pkg/fun_13_15.o: \
		pkg/fun_13_15.c \
		pkg/fun_13_15.h

o//pkg/fun_13_16.o: \
		pkg/fun_13_16.c \
		pkg/fun_13_16.h

o//pkg/fun_13_17.o: \
		pkg/fun_13_17.c \
		pkg/fun_13_17.h

o//pkg/fun_13_18.o: \
		pkg/fun_13_18.c \
		pkg/fun_13_18.h

o//pkg/fun_13_19.o: \
		pkg/fun_13_19.c \
		pkg/fun_13_19.h

o//pkg/main_13.o: \
		pkg/main_13.c \
		pkg/fun_13_0.h \
		pkg/fun_13_1.h \
		pkg/fun_13_2.h \
		pkg/fun_13_3.h \
		pkg/fun_13_4.h \
		pkg/fun_13_5.h \
		pkg/fun_13_6.h \
		pkg/fun_13_7.h \
		pkg/fun_13_8.h \
		pkg/fun_13_9.h \
		pkg/fun_13_10.h \
		pkg/fun_13_11.h \
		pkg/fun_13_12.h \
		pkg/fun_13_13.h \
		pkg/fun_13_14.h \
		pkg/fun_13_15.h \
		pkg/fun_13_16.h \
		pkg/fun_13_17.h \
		pkg/fun_13_18.h \
		pkg/fun_13_19.h

o//pkg/fun_13.a: \
		o//pkg/fun_13_0.o \
		o//pkg/fun_13_1.o \
		o//pkg/fun_13_2.o \
		o//pkg/fun_13_3.o \
		o//pkg/fun_13_4.o \
		o//pkg/fun_13_5.o \
		o//pkg/fun_13_6.o \
		o//pkg/fun_13_7.o \
		o//pkg/fun_13_8.o \
		o//pkg/fun_13_9.o \
		o//pkg/fun_13_10.o \
		o//pkg/fun_13_11.o \
		o//pkg/fun_13_12.o \
		o//pkg/fun_13_13.o \
		o//pkg/fun_13_14.o \
		o//pkg/fun_13_15.o \
		o//pkg/fun_13_16.o \
		o//pkg/fun_13_17.o \
		o//pkg/fun_13_18.o \
		o//pkg/fun_13_19.o

o//pkg/main_13.exe: \
		o//pkg/main_13.o \
		o//pkg/fun_13.a
o//pkg/fun_14_0.o: \
		pkg/fun_14_0.c \
		pkg/fun_14_0.h

o//pkg/fun_14_1.o: \
		pkg/fun_14_1.c \
		pkg/fun_14_1.h

o//pkg/fun_14_2.o: \
		pkg/fun_14_2.c \
		pkg/fun_14_2.h

o//pkg/fun_14_3.o: \
		pkg/fun_14_3.c \
		pkg/fun_14_3.h

o//pkg/fun_14_4.o: \
		pkg/fun_14_4.c \
		pkg/fun_14_4.h

o//pkg/fun_14_5.o: \
		pkg/fun_14_5.c \
		pkg/fun_14_5.h

o//pkg/fun_14_6.o: \
		pkg/fun_14_6.c \
		pkg/fun_14_6.h

o//pkg/fun_14_7.o: \
		pkg/fun_14_7.c \
		pkg/fun_14_7.h

o//pkg/fun_14_8.o: \
		pkg/fun_14_8.c \
		pkg/fun_14_8.h

o//pkg/fun_14_9.o: \
		pkg/fun_14_9.c \
		pkg/fun_14_9.h

o//pkg/fun_14_10.o: \
		pkg/fun_14_10.c \
		pkg/fun_14_10.h

o//pkg/fun_14_11.o: \
		pkg/fun_14_11.c \
		pkg/fun_14_11.h

o//pkg/fun_14_12.o: \
		pkg/fun_14_12.c \
		pkg/fun_14_12.h

o//pkg/fun_14_13.o: \
		pkg/fun_14_13.c \
		pkg/fun_14_13.h

o//pkg/fun_14_14.o: \
		pkg/fun_14_14.c \
		pkg/fun_14_14.h

o//pkg/fun_14_15.o: \
		pkg/fun_14_15.c \
		pkg/fun_14_15.h

o//pkg/fun_14_16.o: \
		pkg/fun_14_16.c \
		pkg/fun_14_16.h

o//pkg/fun_14_17.o: \
		pkg/fun_14_17.c \
		pkg/fun_14_17.h

o//pkg/fun_14_18.o: \
		pkg/fun_14_18.c \
		pkg/fun_14_18.h

o//pkg/fun_14_19.o: \
		pkg/fun_14_19.c \
		pkg/fun_14_19.h

o//pkg/main_14.o: \
		pkg/main_14.c \
		pkg/fun_14_0.h \
		pkg/fun_14_1.h \
		pkg/fun_14_2.h \
		pkg/fun_14_3.h \
		pkg/fun_14_4.h \
		pkg/fun_14_5.h \
		pkg/fun_14_6.h \
		pkg/fun_14_7.h \
		pkg/fun_14_8.h \
		pkg/fun_14_9.h \
		pkg/fun_14_10.h \
		pkg/fun_14_11.h \
		pkg/fun_14_12.h \
		pkg/fun_14_13.h \
		pkg/fun_14_14.h \
		pkg/fun_14_15.h \
		pkg/fun_14_16.h \
		pkg/fun_14_17.h \
		pkg/fun_14_18.h \
		pkg/fun_14_19.h

o//pkg/fun_14.a: \
		o//pkg/fun_14_0.o \
		o//pkg/fun_14_1.o \
		o//pkg/fun_14_2.o \
		o//pkg/fun_14_3.o \
		o//pkg/fun_14_4.o \
		o//pkg/fun_14_5.o \
		o//pkg/fun_14_6.o \
		o//pkg/fun_14_7.o \
		o//pkg/fun_14_8.o \
		o//pkg/fun_14_9.o \
		o//pkg/fun_14_10.o \
		o//pkg/fun_14_11.o \
		o//pkg/fun_14_12.o \
		o//pkg/fun_14_13.o \
		o//pkg/fun_14_14.o \
		o//pkg/fun_14_15.o \
		o//pkg/fun_14_16.o \
		o//pkg/fun_14_17.o \
		o//pkg/fun_14_18.o \
		o//pkg/fun_14_19.o

o//pkg/main_14.exe: \
		o//pkg/main_14.o \
		o//pkg/fun_14.a
o//pkg/fun_15_0.o: \
		pkg/fun_15_0.c \
		pkg/fun_15_0.h

o//pkg/fun_15_1.o: \
		pkg/fun_15_1.c \
		pkg/fun_15_1.h

o//pkg/fun_15_2.o: \
		pkg/fun_15_2.c \
		pkg/fun_15_2.h

o//pkg/fun_15_3.o: \
		pkg/fun_15_3.c \
		pkg/fun_15_3.h

o//pkg/fun_15_4.o: \
		pkg/fun_15_4.c \
		pkg/fun_15_4.h

o//pkg/fun_15_5.o: \
		pkg/fun_15_5.c \
		pkg/fun_15_5.h

o//pkg/fun_15_6.o: \
		pkg/fun_15_6.c \
		pkg/fun_15_6.h

o//pkg/fun_15_7.o: \
		pkg/fun_15_7.c \
		pkg/fun_15_7.h

o//pkg/fun_15_8.o: \
		pkg/fun_15_8.c \
		pkg/fun_15_8.h

o//pkg/fun_15_9.o: \
		pkg/fun_15_9.c \
		pkg/fun_15_9.h

o//pkg/fun_15_10.o: \
		pkg/fun_15_10.c \
		pkg/fun_15_10.h

o//pkg/fun_15_11.o: \
		pkg/fun_15_11.c \
		pkg/fun_15_11.h

o//pkg/fun_15_12.o: \
		pkg/fun_15_12.c \
		pkg/fun_15_12.h

o//pkg/fun_15_13.o: \
		pkg/fun_15_13.c \
		pkg/fun_15_13.h

o//pkg/fun_15_14.o: \
		pkg/fun_15_14.c \
		pkg/fun_15_14.h

o//pkg/fun_15_15.o: \
		pkg/fun_15_15.c \
		pkg/fun_15_15.h

o//pkg/fun_15_16.o: \
		pkg/fun_15_16.c \
		pkg/fun_15_16.h

o//pkg/fun_15_17.o: \
		pkg/fun_15_17.c \
		pkg/fun_15_17.h

o//pkg/fun_15_18.o: \
		pkg/fun_15_18.c \
		pkg/fun_15_18.h

o//pkg/fun_15_19.o: \
		pkg/fun_15_19.c \
		pkg/fun_15_19.h

o//pkg/main_15.o: \
		pkg/main_15.c \
		pkg/fun_15_0.h \
		pkg/fun_15_1.h \
		pkg/fun_15_2.h \
		pkg/fun_15_3.h \
		pkg/fun_15_4.h \
		pkg/fun_15_5.h \
		pkg/fun_15_6.h \
		pkg/fun_15_7.h \
		pkg/fun_15_8.h \
		pkg/fun_15_9.h \
		pkg/fun_15_10.h \
		pkg/fun_15_11.h \
		pkg/fun_15_12.h \
		pkg/fun_15_13.h \
		pkg/fun_15_14.h \
		pkg/fun_15_15.h \
		pkg/fun_15_16.h \
		pkg/fun_15_17.h \
		pkg/fun_15_18.h \
		pkg/fun_15_19.h

o//pkg/fun_15.a: \
		o//pkg/fun_15_0.o \
		o//pkg/fun_15_1.o \
		o//pkg/fun_15_2.o \
		o//pkg/fun_15_3.o \
		o//pkg/fun_15_4.o \
		o//pkg/fun_15_5.o \
		o//pkg/fun_15_6.o \
		o//pkg/fun_15_7.o \
		o//pkg/fun_15_8.o \
		o//pkg/fun_15_9.o \
		o//pkg/fun_15_10.o \
		o//pkg/fun_15_11.o \
		o//pkg/fun_15_12.o \
		o//pkg/fun_15_13.o \
		o//pkg/fun_15_14.o \
		o//pkg/fun_15_15.o \
		o//pkg/fun_15_16.o \
		o//pkg/fun_15_17.o \
		o//pkg/fun_15_18.o \
		o//pkg/fun_15_19.o

o//pkg/main_15.exe: \
		o//pkg/main_15.o \
		o//pkg/fun_15.a
o//pkg/fun_16_0.o: \
		pkg/fun_16_0.c \
		pkg/fun_16_0.h

o//pkg/fun_16_1.o: \
		pkg/fun_16_1.c \
		pkg/fun_16_1.h

o//pkg/fun_16_2.o: \
		pkg/fun_16_2.c \
		pkg/fun_16_2.h

o//pkg/fun_16_3.o: \
		pkg/fun_16_3.c \
		pkg/fun_16_3.h

o//pkg/fun_16_4.o: \
		pkg/fun_16_4.c \
		pkg/fun_16_4.h

o//pkg/fun_16_5.o: \
		pkg/fun_16_5.c \
		pkg/fun_16_5.h

o//pkg/fun_16_6.o: \
		pkg/fun_16_6.c \
		pkg/fun_16_6.h

o//pkg/fun_16_7.o: \
		pkg/fun_16_7.c \
		pkg/fun_16_7.h

o//pkg/fun_16_8.o: \
		pkg/fun_16_8.c \
		pkg/fun_16_8.h

o//pkg/fun_16_9.o: \
		pkg/fun_16_9.c \
		pkg/fun_16_9.h

o//pkg/fun_16_10.o: \
		pkg/fun_16_10.c \
		pkg/fun_16_10.h

o//pkg/fun_16_11.o: \
		pkg/fun_16_11.c \
		pkg/fun_16_11.h

o//pkg/fun_16_12.o: \
		pkg/fun_16_12.c \
		pkg/fun_16_12.h

o//pkg/fun_16_13.o: \
		pkg/fun_16_13.c \
		pkg/fun_16_13.h

o//pkg/fun_16_14.o: \
		pkg/fun_16_14.c \
		pkg/fun_16_14.h

o//pkg/fun_16_15.o: \
		pkg/fun_16_15.c \
		pkg/fun_16_15.h

o//pkg/fun_16_16.o: \
		pkg/fun_16_16.c \
		pkg/fun_16_16.h

o//pkg/fun_16_17.o: \
		pkg/fun_16_17.c \
		pkg/fun_16_17.h

o//pkg/fun_16_18.o: \
		pkg/fun_16_18.c \
		pkg/fun_16_18.h

o//pkg/fun_16_19.o: \
		pkg/fun_16_19.c \
		pkg/fun_16_19.h

o//pkg/main_16.o: \
		pkg/main_16.c \
		pkg/fun_16_0.h \
		pkg/fun_16_1.h \
		pkg/fun_16_2.h \
		pkg/fun_16_3.h \
		pkg/fun_16_4.h \
		pkg/fun_16_5.h \
		pkg/fun_16_6.h \
		pkg/fun_16_7.h \
		pkg/fun_16_8.h \
		pkg/fun_16_9.h \
		pkg/fun_16_10.h \
		pkg/fun_16_11.h \
		pkg/fun_16_12.h \
		pkg/fun_16_13.h \
		pkg/fun_16_14.h \
		pkg/fun_16_15.h \
		pkg/fun_16_16.h \
		pkg/fun_16_17.h \
		pkg/fun_16_18.h \
		pkg/fun_16_19.h

o//pkg/fun_16.a: \
		o//pkg/fun_16_0.o \
		o//pkg/fun_16_1.o \
		o//pkg/fun_16_2.o \
		o//pkg/fun_16_3.o \
		o//pkg/fun_16_4.o \
		o//pkg/fun_16_5.o \
		o//pkg/fun_16_6.o \
		o//pkg/fun_16_7.o \
		o//pkg/fun_16_8.o \
		o//pkg/fun_16_9.o \
		o//pkg/fun_16_10.o \
		o//pkg/fun_16_11.o \
		o//pkg/fun_16_12.o \
		o//pkg/fun_16_13.o \
		o//pkg/fun_16_14.o \
		o//pkg/fun_16_15.o \
		o//pkg/fun_16_16.o \
		o//pkg/fun_16_17.o \
		o//pkg/fun_16_18.o \
		o//pkg/fun_16_19.o

o//pkg/main_16.exe: \
		o//pkg/main_16.o \
		o//pkg/fun_16.a
o//pkg/fun_17_0.o: \
		pkg/fun_17_0.c \
		pkg/fun_17_0.h

o//pkg/fun_17_1.o: \
		pkg/fun_17_1.c \
		pkg/fun_17_1.h

o//pkg/fun_17_2.o: \
		pkg/fun_17_2.c \
		pkg/fun_17_2.h

o//pkg/fun_17_3.o: \
		pkg/fun_17_3.c \
		pkg/fun_17_3.h

o//pkg/fun_17_4.o: \
		pkg/fun_17_4.c \
		pkg/fun_17_4.h

o//pkg/fun_17_5.o: \
		pkg/fun_17_5.c \
		pkg/fun_17_5.h

o//pkg/fun_17_6.o: \
		pkg/fun_17_6.c \
		pkg/fun_17_6.h

o//pkg/fun_17_7.o: \
		pkg/fun_17_7.c \
		pkg/fun_17_7.h

o//pkg/fun_17_8.o: \
		pkg/fun_17_8.c \
		pkg/fun_17_8.h

o//pkg/fun_17_9.o: \
		pkg/fun_17_9.c \
		pkg/fun_17_9.h

o//pkg/fun_17_10.o: \
		pkg/fun_17_10.c \
		pkg/fun_17_10.h

o//pkg/fun_17_11.o: \
		pkg/fun_17_11.c \
		pkg/fun_17_11.h

o//pkg/fun_17_12.o: \
		pkg/fun_17_12.c \
		pkg/fun_17_12.h

o//pkg/fun_17_13.o: \
		pkg/fun_17_13.c \
		pkg/fun_17_13.h

o//pkg/fun_17_14.o: \
		pkg/fun_17_14.c \
		pkg/fun_17_14.h

o//pkg/fun_17_15.o: \
		pkg/fun_17_15.c \
		pkg/fun_17_15.h

o//pkg/fun_17_16.o: \
		pkg/fun_17_16.c \
		pkg/fun_17_16.h

o//pkg/fun_17_17.o: \
		pkg/fun_17_17.c \
		pkg/fun_17_17.h

o//pkg/fun_17_18.o: \
		pkg/fun_17_18.c \
		pkg/fun_17_18.h

o//pkg/fun_17_19.o: \
		pkg/fun_17_19.c \
		pkg/fun_17_19.h

o//pkg/main_17.o: \
		pkg/main_17.c \
		pkg/fun_17_0.h \
		pkg/fun_17_1.h \
		pkg/fun_17_2.h \
		pkg/fun_17_3.h \
		pkg/fun_17_4.h \
		pkg/fun_17_5.h \
		pkg/fun_17_6.h \
		pkg/fun_17_7.h \
		pkg/fun_17_8.h \
		pkg/fun_17_9.h \
		pkg/fun_17_10.h \
		pkg/fun_17_11.h \
		pkg/fun_17_12.h \
		pkg/fun_17_13.h \
		pkg/fun_17_14.h \
		pkg/fun_17_15.h \
		pkg/fun_17_16.h \
		pkg/fun_17_17.h \
		pkg/fun_17_18.h \
		pkg/fun_17_19.h

o//pkg/fun_17.a: \
		o//pkg/fun_17_0.o \
		o//pkg/fun_17_1.o \
		o//pkg/fun_17_2.o \
		o//pkg/fun_17_3.o \
		o//pkg/fun_17_4.o \
		o//pkg/fun_17_5.o \
		o//pkg/fun_17_6.o \
		o//pkg/fun_17_7.o \
		o//pkg/fun_17_8.o \
		o//pkg/fun_17_9.o \
		o//pkg/fun_17_10.o \
		o//pkg/fun_17_11.o \
		o//pkg/fun_17_12.o \
		o//pkg/fun_17_13.o \
		o//pkg/fun_17_14.o \
		o//pkg/fun_17_15.o \
		o//pkg/fun_17_16.o \
		o//pkg/fun_17_17.o \
		o//pkg/fun_17_18.o \
		o//pkg/fun_17_19.o

o//pkg/main_17.exe: \
		o//pkg/main_17.o \
		o//pkg/fun_17.a
o//pkg/fun_18_0.o: \
		pkg/fun_18_0.c \
		pkg/fun_18_0.h

o//pkg/fun_18_1.o: \
		pkg/fun_18_1.c \
		pkg/fun_18_1.h

o//pkg/fun_18_2.o: \
		pkg/fun_18_2.c \
		pkg/fun_18_2.h

o//pkg/fun_18_3.o: \
		pkg/fun_18_3.c \
		pkg/fun_18_3.h

o//pkg/fun_18_4.o: \
		pkg/fun_18_4.c \
		pkg/fun_18_4.h

o//pkg/fun_18_5.o: \
		pkg/fun_18_5.c \
		pkg/fun_18_5.h

o//pkg/fun_18_6.o: \
		pkg/fun_18_6.c \
		pkg/fun_18_6.h

o//pkg/fun_18_7.o: \
		pkg/fun_18_7.c \
		pkg/fun_18_7.h

o//pkg/fun_18_8.o: \
		pkg/fun_18_8.c \
		pkg/fun_18_8.h

o//pkg/fun_18_9.o: \
		pkg/fun_18_9.c \
		pkg/fun_18_9.h

o//pkg/fun_18_10.o: \
		pkg/fun_18_10.c \
		pkg/fun_18_10.h

o//pkg/fun_18_11.o: \
		pkg/fun_18_11.c \
		pkg/fun_18_11.h

o//pkg/fun_18_12.o: \
		pkg/fun_18_12.c \
		pkg/fun_18_12.h

o//pkg/fun_18_13.o: \
		pkg/fun_18_13.c \
		pkg/fun_18_13.h

o//pkg/fun_18_14.o: \
		pkg/fun_18_14.c \
		pkg/fun_18_14.h

o//pkg/fun_18_15.o: \
		pkg/fun_18_15.c \
		pkg/fun_18_15.h

o//pkg/fun_18_16.o: \
		pkg/fun_18_16.c \
		pkg/fun_18_16.h

o//pkg/fun_18_17.o: \
		pkg/fun_18_17.c \
		pkg/fun_18_17.h

o//pkg/fun_18_18.o: \
		pkg/fun_18_18.c \
		pkg/fun_18_18.h

o//pkg/fun_18_19.o: \
		pkg/fun_18_19.c \
		pkg/fun_18_19.h

o//pkg/main_18.o: \
		pkg/main_18.c \
		pkg/fun_18_0.h \
		pkg/fun_18_1.h \
		pkg/fun_18_2.h \
		pkg/fun_18_3.h \
		pkg/fun_18_4.h \
		pkg/fun_18_5.h \
		pkg/fun_18_6.h \
		pkg/fun_18_7.h \
		pkg/fun_18_8.h \
		pkg/fun_18_9.h \
		pkg/fun_18_10.h \
		pkg/fun_18_11.h \
		pkg/fun_18_12.h \
		pkg/fun_18_13.h \
		pkg/fun_18_14.h \
		pkg/fun_18_15.h \
		pkg/fun_18_16.h \
		pkg/fun_18_17.h \
		pkg/fun_18_18.h \
		pkg/fun_18_19.h

o//pkg/fun_18.a: \
		o//pkg/fun_18_0.o \
		o//pkg/fun_18_1.o \
		o//pkg/fun_18_2.o \
		o//pkg/fun_18_3.o \
		o//pkg/fun_18_4.o \
		o//pkg/fun_18_5.o \
		o//pkg/fun_18_6.o \
		o//pkg/fun_18_7.o \
		o//pkg/fun_18_8.o \
		o//pkg/fun_18_9.o \
		o//pkg/fun_18_10.o \
		o//pkg/fun_18_11.o \
		o//pkg/fun_18_12.o \
		o//pkg/fun_18_13.o \
		o//pkg/fun_18_14.o \
		o//pkg/fun_18_15.o \
		o//pkg/fun_18_16.o \
		o//pkg/fun_18_17.o \
		o//pkg/fun_18_18.o \
		o//pkg/fun_18_19.o

o//pkg/main_18.exe: \
		o//pkg/main_18.o \
		o//pkg/fun_18.a
o//pkg/fun_19_0.o: \
		pkg/fun_19_0.c \
		pkg/fun_19_0.h

o//pkg/fun_19_1.o: \
		pkg/fun_19_1.c \
		pkg/fun_19_1.h

o//pkg/fun_19_2.o: \
		pkg/fun_19_2.c \
		pkg/fun_19_2.h

o//pkg/fun_19_3.o: \
		pkg/fun_19_3.c \
		pkg/fun_19_3.h

o//pkg/fun_19_4.o: \
		pkg/fun_19_4.c \
		pkg/fun_19_4.h

o//pkg/fun_19_5.o: \
		pkg/fun_19_5.c \
		pkg/fun_19_5.h

o//pkg/fun_19_6.o: \
		pkg/fun_19_6.c \
		pkg/fun_19_6.h

o//pkg/fun_19_7.o: \
		pkg/fun_19_7.c \
		pkg/fun_19_7.h

o//pkg/fun_19_8.o: \
		pkg/fun_19_8.c \
		pkg/fun_19_8.h

o//pkg/fun_19_9.o: \
		pkg/fun_19_9.c \
		pkg/fun_19_9.h

o//pkg/fun_19_10.o: \
		pkg/fun_19_10.c \
		pkg/fun_19_10.h

o//pkg/fun_19_11.o: \
		pkg/fun_19_11.c \
		pkg/fun_19_11.h

o//pkg/fun_19_12.o: \
		pkg/fun_19_12.c \
		pkg/fun_19_12.h

o//pkg/fun_19_13.o: \
		pkg/fun_19_13.c \
		pkg/fun_19_13.h

o//pkg/fun_19_14.o: \
		pkg/fun_19_14.c \
		pkg/fun_19_14.h

o//pkg/fun_19_15.o: \
		pkg/fun_19_15.c \
		pkg/fun_19_15.h

o//pkg/fun_19_16.o: \
		pkg/fun_19_16.c \
		pkg/fun_19_16.h

o//pkg/fun_19_17.o: \
		pkg/fun_19_17.c \
		pkg/fun_19_17.h

o//pkg/fun_19_18.o: \
		pkg/fun_19_18.c \
		pkg/fun_19_18.h

o//pkg/fun_19_19.o: \
		pkg/fun_19_19.c \
		pkg/fun_19_19.h

o//pkg/main_19.o: \
		pkg/main_19.c \
		pkg/fun_19_0.h \
		pkg/fun_19_1.h \
		pkg/fun_19_2.h \
		pkg/fun_19_3.h \
		pkg/fun_19_4.h \
		pkg/fun_19_5.h \
		pkg/fun_19_6.h \
		pkg/fun_19_7.h \
		pkg/fun_19_8.h \
		pkg/fun_19_9.h \
		pkg/fun_19_10.h \
		pkg/fun_19_11.h \
		pkg/fun_19_12.h \
		pkg/fun_19_13.h \
		pkg/fun_19_14.h \
		pkg/fun_19_15.h \
		pkg/fun_19_16.h \
		pkg/fun_19_17.h \
		pkg/fun_19_18.h \
		pkg/fun_19_19.h

o//pkg/fun_19.a: \
		o//pkg/fun_19_0.o \
		o//pkg/fun_19_1.o \
		o//pkg/fun_19_2.o \
		o//pkg/fun_19_3.o \
		o//pkg/fun_19_4.o \
		o//pkg/fun_19_5.o \
		o//pkg/fun_19_6.o \
		o//pkg/fun_19_7.o \
		o//pkg/fun_19_8.o \
		o//pkg/fun_19_9.o \
		o//pkg/fun_19_10.o \
		o//pkg/fun_19_11.o \
		o//pkg/fun_19_12.o \
		o//pkg/fun_19_13.o \
		o//pkg/fun_19_14.o \
		o//pkg/fun_19_15.o \
		o//pkg/fun_19_16.o \
		o//pkg/fun_19_17.o \
		o//pkg/fun_19_18.o \
		o//pkg/fun_19_19.o

o//pkg/main_19.exe: \
		o//pkg/main_19.o \
		o//pkg/fun_19.a
