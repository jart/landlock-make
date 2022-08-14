# Landlock Make
# Example Repository
#
# This repository contains an idiomatic configuration for Landlock Make
# that builds a nontrivial amount of stuff. To get started, please run:
#
#     build/bootstrap/make.com -j8
#
# In this makefile we assume certain Landlock Make behaviors, such as
# automatic setup/teardown of $TMPDIR folders on a per-rule basis. We
# need to work around weird GNU tooling behaviors, like how they call
# unlink() on the output file before writing to it (which must be
# created, because Landlock LSM can't whitelist a path unless there's an
# existent inode). There's also a few fast helpful tools here from the
# Cosmopolitan Libc project, such as ar.com and mkdeps.com.

MAKEFLAGS += --no-builtin-rules
CC = build/bootstrap/gcc/bin/x86_64-linux-musl-gcc -static
CPPFLAGS = -iquote .
TMPDIR = o//tmp
FILES := $(wildcard pkg/*)
SRCS = $(filter %.c,$(FILES))
HDRS = $(filter %.h,$(FILES))
INCS = $(filter %.inc,$(FILES))

.STRICT = 1
.UNVEIL =			\
	rx:/lib			\
	rx:/usr/lib		\
	rx:build/bootstrap

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
clean: .UNSANDBOXED = 1
clean:
	rm -rf o

o//%.a:
	build/bootstrap/ar.com rcsD $@ $^

o//%.o: %.c
	@/bin/echo $(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $(TMPDIR)/$(subst /,_,$@)
	@/bin/cp -f $(TMPDIR)/$(subst /,_,$@) $@

o//%.exe:
	@/bin/echo $(CC) $(LDFLAGS) $(TARGET_ARCH) -o $@ $^
	@$(CC) $(LDFLAGS) $(TARGET_ARCH) -o $(TMPDIR)/$(subst /,_,$@) $^
	@/bin/cp -f $(TMPDIR)/$(subst /,_,$@) $@

o//depend: $(SRCS) $(HDRS) $(INCS)
	$(file >$(TMPDIR)/args,$(SRCS) $(HDRS) $(INCS))
	build/bootstrap/mkdeps.com -o $@ -r o// @$(TMPDIR)/args

.DEFAULT:
	@/bin/echo
	@/bin/echo NOTE: deleting o//depend because of an unspecified prerequisite: $@
	@/bin/echo
	/bin/rm o//depend

-include o//depend

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

