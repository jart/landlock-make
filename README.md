# Landlock Make

Landlock Make is a GNU Make fork that sandboxes command invocations
automatically based on your build rule config. This tool can:

1. Restrict filesystem access to target and prerequisites only
2. Prevent public internet access
3. Enforce resource quotas

This demo repository contains binary releases. It's intended to show how
Landlock Make can be configured. It also includes a comparable Bazel
configuration, in order to demonstrate that our sandboxing solution goes
5x faster. You can get started as follows:

## Table of Contents

- [#getting-started](Getting Started)
- [#reference](Reference)
  - [#theory](Theory)
  - [#cli-flags](CLI Flags)
  - [#functions](Functions)
  - [#variables](Variables)
  - [#implicit-paths](Implicit Paths)

## Getting Started

To get started, run:

```
git clone https://github.com/jart/landlock-make
cd landlock-make
build/bootstrap/make.com -j8
```

If you wish to build this project from source, you may do so as follows:

```
git clone https://github.com/jart/cosmopolitan
cd cosmopolitan
make -j8 o//third_party/make/make.com
```

Release artifacts are also available at <https://justine.lol/make/>.

## Reference

This reference covers features added in our Landlock Make fork. Please
see <https://justine.lol/dox/make.txt> for the GNU Make documentation.

### Theory

Landlock LSM operates on inodes. This means:

1. A file needs to exist to be unveiled
2. A path becomes veiled again if it's unlinked

This makes the output filenames tricky, since Landlock Make needs to
touch your target's output file before it runs the command. 

This makes Make easier to use in many cases. For example, large projects
usually use a separate `build/...` output directory tree, and it's
cumbersome to have to put a `@$(MKDIR) $(@D)` command in every build
rule. Thanks to Landlock Make, that's now automated.

Where Landlock gets tricky is because of (2). Some tools, e.g. GCC, will
do things like `unlink()` an output file if it exists, specifically to
create a new inode. For tools ilke that we suggest a workaround like:

```
o//%.o: %.c
	@/bin/echo $(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $(TMPDIR)/$(subst /,_,$@)
	@/bin/mkdir -p $(@D)
	@/bin/cp -f $(TMPDIR)/$(subst /,_,$@) $@
```

This will ensure the inode isn't destroyed, since the output is being
written to a temporary directory and then copied over the output when
it's done. The above code is designed to be portable. That definition
will work with Landlock Make as well as vanilla GNU Make. Since Landlock
Make automatically sets up and tears down unique `$(TMPDIR)` directories
per build rule, you could actually write the following without
compromising your ability to use the `-j` flag:

```
o//%.o: %.c
	@/bin/echo $(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $(TMPDIR)/o
	@/bin/cp -f $(TMPDIR)/o $@
```

### CLI Flags

Landlock Make introduces the following command line flags:

- `--strace` causes system calls to be logged to standard error.

- `--ftrace` causes function calls to be logged to standard error.

### Variables

Can be used to keep temporary directory names smaller, while preserving
backwards compatibility with GNU Make.

#### `.UNVEIL = [rwcx:]PATH`

Specifies which files and directories are visible.

Commands, targets, and prerequisites are unveiled automatically. This
variable is mostly needed to do things like whitelist your toolchain or
dynamic shared objects, e.g.

```
.STRICT = 1
.UNVEIL =			\
	rx:/lib			\
	rx:/usr/lib		\
	rx:toolchain
```

Permissions precede your path, followed by a colon. Possible permissions
are `r` (read), `w` (write), `c` (create), and `x` (execute). If no
permissions are specified, the default is read-only.

This variable may be specified on a build target, the pattern rule, and
the global scope. If paths are specified in multiple places, they will
aggregate. For example, you might want to allow a unit test to access
certain system files, while still keeping it restricted globally.

```
o//third_party/python/Lib/test/test_wsgiref.py.runs: 			\
		private .UNVEIL +=					\
			/etc/mime.types					\
			/etc/httpd/mime.types				\
			/etc/httpd/conf/mime.types			\
			/etc/apache/mime.types				\
			/etc/apache2/mime.types				\
			/usr/local/etc/httpd/conf/mime.types		\
			/usr/local/lib/netscape/mime.types		\
			/usr/local/etc/httpd/conf/mime.types		\
			/usr/local/etc/mime.types
```

It's important to use the `private` keyword when specifying variables on
targets, since otherwise Make will backpropagate your variable to the
prerequisites of your target.

Paths that don't exist are ignored.

#### `.PLEDGE = PROMISES...`

Specifies which system calls are used by build commands.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

Valid tokens are `stdio`, `rpath`, `wpath`, `cpath`, `dpath`, `flock`,
`tty`, `recvfd`, `sendfd`, `fattr`, `chown`, `inet`, `unix`, `id`,
`dns`, `proc`, `exec`, `prot_exec`, `vminfo`, `tmppath`. See the
documentation at
[cosmopolitan/libc/calls/pledge.c](https://github.com/jart/cosmopolitan/blob/master/libc/calls/pledge.c)
to learn more about which system calls each categories will authorize.

If the `inet` or `dns` groups are enabled, then you'll only be able to
speak with private subnets unless `.INTERNET = 1` is specified too.

#### `.INTERNET = BOOL`

Enables build commands to talk to the Internet.

By default, we only allow socket system calls to use the subnets
127.0.0.0/8, 10.0.0.0/8, 172.16.0.0/12, or 192.168.0.0/16. If any
subprocess tries to speak to the public Internet, then a message will be
logged to stderr and the system call will return `ENOSYS`.

On Linux this is accomplished by installing a SECCOMP ptrace() monitor
process for each command. That's only possible if the process isn't
already being traced by a parent make (or a tool like GDB and strace).
Root access is not required.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

Valid truth values are `1` or `true` case insensitively. Other values
are false.

Please consider using `.PLEDGE`, because if it's specified, and the
specification doesn't include `inet` or `dns`, then Landlock Make won't
need to spawn monitor processes, which is more efficient, since pledge()
will block the socket system calls in pure in-kernel BPF code.

#### `.STRICT = BOOL`

Disables implicit unveiling and $PATH searching.

Using this setting is recommended, but it's disabled by default in order
to offer a gentler path for folks to get accustomed to the Landlock Make
way of doing things.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

Valid truth values are `1` or `true` case insensitively. Other values
are false.

#### `.UNSANDBOXED = BOOL`

Disables pledge() and unveil().

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

Valid truth values are `1` or `true` case insensitively. Other values
are false.

#### `TMPDIR`

Defines temporary file root.

If this variable is defined, then Landlock Make will automatically setup
and teardown a unique temporary subdirectory per build rule invocation.
For example, if you specify:

```
TMPDIR = o//tmp

o//foo.o: foo.c
	@/bin/echo $(CC) -c $< -o $@
	@$(CC) -c $< -o $(TMPDIR)/$(subst /,_,$@)
	@/bin/cp -f $(TMPDIR)/$(subst /,_,$@) $@
```

Then `$(TMPDIR)` will look like `/project/o//tmp/o__foo.huoehg`. The new
`$(TMPDIR)` can be referenced in your shell code. It will also be
exported to subprocesses as the `$TMPDIR` environment variable.

Parent directories are created automatically. The unique subdirectory is
recursively deleted when your build rule commands terminate. If you have
multiple command lines in your build rule, then your temporary directory
will be shared between them. It won't be shared with anything else.

#### `.CPU = SECONDS`

Sets CPU resource limit.

This specifies the amount of CPU time, in seconds, that each individual
command is allowed to take.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

If this limit is violated, then a `SIGXCPU` signal is sent to your
program, after which it has precisely one second to gratefully shutdown
before `SIGKILL` is used.

#### `.MEMORY = SIZE`

Sets virtual memory space limit.

The size is specified in bytes. It may use Si notation, e.g. `64kb` for
64 kibibytes, `1G` for a gibibyte, etc. Units use base 1024. This size
may also be specified as a percent value, e.g. `10%` which will be
computed as ten percent of the amount of physical RAM available on the
host machine.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

When this limit is violated, mmap() will begin returning `ENOMEM` which
will trickle down into functions like malloc() failing.

#### `.RSS = SIZE`

This is the same as `.MEMORY` but takes the resident set size into
consideration, rather than the virtual address space size. This limit is
more useful if you make heavy use of overcommit memory or have sparse
data structures.

#### `.FSIZE = SIZE`

Sets individual file size limit.

This specifies how big files can grow. It applies on a per file basis.

The size is specified in bytes. It may use Si notation, e.g. `64kb` for
64 kilobytes, `1G` for a gigabyte, etc. Units use base 1000.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

If this limit is violated, then a `SIGXFSZ` signal will be delivered to
the process responsible. If the limit is exceeded by 150%, then a
`SIGKILL` signal is used to kill the process.

#### `.NPROC = COUNT`

Specifies maximum number of forked and cloned processes for user.

This variable may be used to reduce the likelihood of a fork() bomb
destroying your system.

Since this value applies across the entire logged-in UNIX user account,
you may already be running a thousand or so processes. In that case, you
can still safely specify a lower limit, becasue the count of preexisting
processes will be implicitly added to whichever count you specify.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

If this limit is violated, functions like fork() will start returning
`EAGAIN`.

#### `.NOFILE = COUNT`

Specifies maximum number of forked and cloned processes for user.

This variable may be used to reduce the likelihood of a fork() bomb
destroying your system.

Since this value applies across the entire logged-in UNIX user account,
you may already be running a thousand or so processes. In that case, you
can still safely specify a lower limit, becasue the count of preexisting
processes will be implicitly added to whichever count you specify.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

If this limit is violated, functions like open() will start returning
`EMFILE`.

#### `.MAXCORE = SIZE`

Specifies maximum size of a core dump file on job processes.

Usually the default is zero, which means to not create core dumps. If
you want core dumps, then setting this to `-1` will allow core dumps of
any size. Since a core dump for an OOM'd process can take a very long
time to write to disk, you may want to choose a more conservative limit.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

#### `LANDLOCKMAKE_VERSION`

Contains semantic version of Landlock Make. This was first introduced in
version `1.4`. For example:

```
ifeq ($(LANDLOCKMAKE_VERSION),)
TMPSAFE = $(TMPDIR)/$(subst /,_,$@)
else
TMPSAFE = $(TMPDIR)/
endif
```

### Functions

Landlock Make offers the following builtin functions.

#### `$(uniq list)`

Removes duplicate words in `list` while preserving ordering. The output
is a list of words separated by single spaces. Thus,

```make
$(call uniq,foo bar foo lose)
```

returns the value:

```
foo bar lose
```

To preserve backwards compatibility with GNU Make, you can test for its
existence and then fall back to defining a quadratic implemention using
functional programming:

```make
ifneq ($(call uniq,c b c a),c b a)
uniq = $(if $1,$(firstword $1) $(call uniq,$(filter-out $(firstword $1),$1)))
endif
```

### Implicit Paths

To provide a smooth migration path, the default mode of operation is
`.STRICT = 0` which is intended to be lenient in permitting well-known
paths. It's a weaker sandbox, but should help ensure things "just work"
for anyone getting started.

#### Always Unveiled

In non-strict mode, the following paths are always unveiled:

- `/tmp` with `rwc` permissions
- `/dev/zero` with `r` permissions
- `/dev/null` with `rw` permissions
- `/dev/full` with `rw` permissions
- `/dev/stdin` with `rw` permissions
- `/dev/stdout` with `rw` permissions
- `/dev/stderr` with `rw` permissions
- `/etc/hosts` with `r` permissions

#### Dynamic Executables

Non-strict mode allows Landlock Make to search your system `$PATH` to
figure out the path of your executable. Landlock Make will check if it's
a dynamic shared object. What we mean by that is an ELF executable that
has `e_type == ET_DYN`, or a `PT_INTERP` or `PT_DYNAMIC` program header.
If any of those is the case, then the following paths are auto-unveiled:

- `/bin` with `rx` permissions
- `/lib` with `rx` permissions
- `/lib64` with `rx` permissions
- `/usr/bin` with `rx` permissions
- `/usr/lib` with `rx` permissions
- `/usr/lib64` with `rx` permissions
- `/usr/local/lib` with `rx` permissions
- `/usr/local/lib64` with `rx` permissions
- `/etc/ld-musl-x86_64.path` with `r` permissions
- `/etc/ld.so.conf` with `r` permissions
- `/etc/ld.so.cache` with `r` permissions
- `/etc/ld.so.conf.d` with `r` permissions
- `/etc/ld.so.preload` with `r` permissions
- `/usr/include` with `r` permissions
- `/usr/share/locale` with `r` permissions
- `/usr/share/locale-langpack` with `r` permissions

Therefore if you run a dynamic executable (e.g. /bin/sh) in non-strict
mode, then all functionality provided by your system may be exposed.
That's not great, but it's not so bad either. For example, a job may be
able to `eject` your cd-rom drive, but it still won't be able to fish
the bitcoin wallet out of your home folder. If you need a stronger
model, then consider vendoring static executable tools. That way past
revisions of your project can be compiled and git bisected without the
assistance of things like Docker.

#### Pledged Paths

If you use the `.PLEDGE` feature then certain paths will be unveiled
automatically, based on your list of promises.

If `tmppath` is pledged:

- `/tmp` with `rwc` permissions

If `rpath` is pledged:

- `/proc/filesystems` with `r` permissions

If `inet` is pledged:

- `/etc/ssl/certs/ca-certificates.crt` with `r` permissions

If `dns` is pledged:

- `/etc/hosts` with `r` permissions
- `/etc/hostname` with `r` permissions
- `/etc/services` with `r` permissions
- `/etc/protocols` with `r` permissions
- `/etc/resolv.conf` with `r` permissions

If `tty` is pledged:

- `tyname(0)`, wit `rw` permissions
- `/dev/tty` with `rw` permissions
- `/dev/console` with `rw` permissions
- `/etc/terminfo` with `r` permissions
- `/usr/lib/terminfo` with `r` permissions
- `/usr/share/terminfo` with `r` permissions

If `vminfo` is pledged:

- `/proc/stat` with `r` permissions
- `/proc/meminfo` with `r` permissions
- `/proc/cpuinfo` with `r` permissions
- `/proc/diskstats` with `r` permissions
- `/proc/self/maps` with `r` permissions
- `/sys/devices/system/cpu` with `r` permissions
