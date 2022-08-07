# $ time build/bootstrap/make.com -j4
# real    0m3.056s
# user    0m4.255s
# sys     0m1.671s

with open('Makefile', 'w') as b:

  b.write('SHELL = /bin/false\n')
  b.write('MKDIR = /bin/mkdir -p\n')
  b.write('MAKEFLAGS += --no-builtin-rules\n')
  b.write('CC = o//third_party/gcc/bin/x86_64-linux-musl-gcc -static\n')
  b.write('CFLAGS = -fno-pie\n')
  b.write('CPPFLAGS = -iquote .\n')
  b.write('TMPDIR = o//tmp\n')
  b.write('export TMPDIR\n')
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
  b.write('clean:\n')
  b.write('\trm -rf o/pkg\n\n')

  b.write('o//%.o: %.c\n')
  b.write('\t@$(MKDIR) $(@D)\n')
  b.write('\t$(CC) $(CFLAGS) $(CPPFLAGS) -c $< $(OUTPUT_OPTION)\n\n')

  b.write('o//%.exe:\n')
  b.write('\t@$(MKDIR) $(@D)\n')
  b.write('\t$(CC) $(LDFLAGS) $(TARGET_ARCH) $(OUTPUT_OPTION) $^\n\n')

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

    for j in range(20):
      b.write('o//pkg/fun_%d_%d.o: \\\n' % (i, j))
      b.write('\t\tpkg/fun_%d_%d.c \\\n' % (i, j))
      b.write('\t\tpkg/fun_%d_%d.h\n\n' % (i, j))

    b.write('o//pkg/main_%d.o: \\\n' % (i))
    b.write('\t\tpkg/main_%d.c' % (i))
    for j in range(20):
      b.write(' \\\n\t\tpkg/fun_%d_%d.h' % (i, j))
    b.write('\n\n')

    with open('pkg/main_%d.c' % (i), 'w') as f:
      for j in range(20):
        f.write('#include "pkg/fun_%d_%d.h"\n' % (i, j))
      f.write('\n')
      f.write('int main() {\n')
      for j in range(20):
        f.write('  fun_%d_%d();\n' % (i, j))
      f.write('}\n')

    b.write('o//pkg/main_%d.exe:' % (i))
    b.write(' \\\n\t\to//pkg/main_%d.o' % (i))
    for j in range(20):
      b.write(' \\\n\t\to//pkg/fun_%d_%d.o' % (i, j))
    b.write('\n\n')
