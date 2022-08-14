# $ time build/bootstrap/make.com -j4
# real    0m3.056s
# user    0m4.255s
# sys     0m1.671s

with open('Makefile', 'w') as b:

  b.write('# Landlock Make\n')
  b.write('# Example Repository\n')
  b.write('#\n')
  b.write('# This repository contains an idiomatic configuration for Landlock Make\n')
  b.write('# that builds a nontrivial amount of stuff. To get started, please run:\n')
  b.write('#\n')
  b.write('#     build/bootstrap/make.com -j8\n')
  b.write('#\n')
  b.write('# In this makefile we assume certain Landlock Make behaviors, such as\n')
  b.write('# automatic setup/teardown of $TMPDIR folders on a per-rule basis. We\n')
  b.write('# need to work around weird GNU tooling behaviors, like how they call\n')
  b.write('# unlink() on the output file before writing to it (which must be\n')
  b.write("# created, because Landlock LSM can't whitelist a path unless there's an\n")
  b.write("# existent inode). There's also a few fast helpful tools here from the\n")
  b.write('# Cosmopolitan Libc project, such as ar.com and mkdeps.com.\n')
  b.write('\n')

  b.write('MAKEFLAGS += --no-builtin-rules\n')
  b.write('CC = build/bootstrap/gcc/bin/x86_64-linux-musl-gcc -static\n')
  b.write('AR = build/bootstrap/ar.com rcsD\n')
  b.write('CPPFLAGS = -iquote .\n')
  b.write('TMPDIR = o//tmp\n')
  b.write('FILES := $(wildcard pkg/*)\n')
  b.write('SRCS = $(filter %.c,$(FILES))\n')
  b.write('HDRS = $(filter %.h,$(FILES))\n')
  b.write('INCS = $(filter %.inc,$(FILES))\n')
  b.write('\n')

  b.write('.STRICT = 1\n')
  b.write('.UNVEIL =			\\\n')
  b.write('	rx:/lib			\\\n')
  b.write('	rx:/usr/lib		\\\n')
  b.write('	rx:build/bootstrap\n')
  b.write('\n')

  b.write('.SUFFIXES:\n')
  b.write('.DELETE_ON_ERROR:\n')
  b.write('.FEATURES: output-sync\n')
  b.write('\n')

  b.write('.PHONY: all\n')
  b.write('all:')
  for i in range(20):
    b.write(' \\\n\t\to//pkg/main_%d.exe' % (i))
  b.write('\n\n')

  b.write('.PHONY: clean\n')
  b.write('clean: .UNSANDBOXED = 1\n')
  b.write('clean:\n')
  b.write('\trm -rf o\n\n')

  b.write('o//%.a:\n')
  b.write('\tbuild/bootstrap/ar.com rcsD $@ $^\n')
  b.write('\n')

  b.write('o//%.o: %.c\n')
  b.write('\t@/bin/echo $(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@\n')
  b.write('\t@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $(TMPDIR)/$(subst /,_,$@)\n')
  b.write('\t@/bin/cp -f $(TMPDIR)/$(subst /,_,$@) $@\n')
  b.write('\n')

  b.write('o//%.exe:\n')
  b.write('\t@/bin/echo $(CC) $(LDFLAGS) $(TARGET_ARCH) -o $@ $^\n')
  b.write('\t@$(CC) $(LDFLAGS) $(TARGET_ARCH) -o $(TMPDIR)/$(subst /,_,$@) $^\n')
  b.write('\t@/bin/cp -f $(TMPDIR)/$(subst /,_,$@) $@\n')
  b.write('\n')

  b.write('o//depend: $(SRCS) $(HDRS) $(INCS)\n')
  b.write('\t$(file >$(TMPDIR)/args,$(SRCS) $(HDRS) $(INCS))\n')
  b.write('\tbuild/bootstrap/mkdeps.com -o $@ -r o// @$(TMPDIR)/args\n')
  b.write('\n')

  b.write('.DEFAULT:\n')
  b.write('\t@/bin/echo\n')
  b.write('\t@/bin/echo NOTE: deleting o//depend because of an unspecified prerequisite: $@\n')
  b.write('\t@/bin/echo\n')
  b.write('\t/bin/rm o//depend\n')
  b.write('\n')

  b.write('-include o//depend\n')
  b.write('\n')

  for i in range(20):

    for j in range(20):
      with open('pkg/fun_%d_%d.h' % (i, j), 'w') as f:
        f.write('void fun_%d_%d(void);\n' % (i, j))

    for j in range(20):
      with open('pkg/fun_%d_%d.c' % (i, j), 'w') as f:
        f.write('#include "pkg/fun_%d_%d.h"\n' % (i, j))
        f.write('\n')
        f.write('void fun_%d_%d(void) {\n' % (i, j))
        f.write('}\n')

    with open('pkg/main_%d.c' % (i), 'w') as f:
      for j in range(20):
        f.write('#include "pkg/fun_%d_%d.h"\n' % (i, j))
      f.write('\n')
      f.write('int main() {\n')
      for j in range(20):
        f.write('  fun_%d_%d();\n' % (i, j))
      f.write('}\n')

    b.write('o//pkg/fun_%d.a:' % (i))
    for j in range(20):
      b.write(' \\\n\t\to//pkg/fun_%d_%d.o' % (i, j))
    b.write('\n')
    b.write('\n')

    b.write('o//pkg/main_%d.exe:' % (i))
    b.write(' \\\n\t\to//pkg/main_%d.o' % (i))
    b.write(' \\\n\t\to//pkg/fun_%d.a' % (i))
    b.write('\n')
    b.write('\n')
