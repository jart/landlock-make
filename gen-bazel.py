# $ time bazel build //pkg:*
# INFO: Analyzed 901 targets (36 packages loaded, 1060 targets configured).
# INFO: Found 901 targets...
# INFO: Deleting stale sandbox base /home/jart/.cache/bazel/_bazel_jart/2507aa711ca766e29e961caa002e2810/sandbox
# INFO: Elapsed time: 11.588s, Critical Path: 0.58s
# INFO: 621 processes: 121 internal, 500 linux-sandbox.
# INFO: Build completed successfully, 621 total actions
# real    0m11.638s
# user    0m0.007s
# sys     0m0.011s

with open('pkg/BUILD', 'w') as b:
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

    b.write('cc_library(\n')
    b.write('  name = "fun_%d",\n' % (i))
    b.write('  hdrs = [\n')
    for j in range(20):
      b.write('    "fun_%d_%d.h",\n' % (i, j))
    b.write('  ],\n')
    b.write('  srcs = [\n')
    for j in range(20):
      b.write('    "fun_%d_%d.c",\n' % (i, j))
    b.write('  ],\n')
    b.write(')\n\n')

  for i in range(20):
    with open('pkg/main_%d.c' % (i), 'w') as f:
      for j in range(20):
        f.write('#include "pkg/fun_%d_%d.h"\n' % (i, j))
      f.write('\n')
      f.write('int main() {\n')
      for j in range(20):
        f.write('  fun_%d_%d();\n' % (i, j))
      f.write('}\n')

    b.write('cc_binary(\n')
    b.write('  name = "main_%d",\n' % (i))
    b.write('  srcs = ["main_%d.c"],\n' % (i))
    b.write('  deps = [":fun_%d"]\n' % (i))
    b.write(')\n\n')
