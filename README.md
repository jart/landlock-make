# Landlock Make

Landlock Make is a GNU Make fork that sandboxes command invocations
automatically based on your build rule config. This tool will

1. Restrict filesystem access to target and prerequisite only
2. Prevent public internet access, using SECCOMP BPF and ptrace()

This demo repository contains binary releases. It's intended to show how
Landlock Make can be configured. It also includes a comparable Bazel
configuration, in order to demonstrate that our sandboxing solution goes
5x faster. You can get started as follows:

```
git clone https://github.com/jart/landlock-make
cd landlock-make
build/bootstrap/make.com -j8
```

Further details are available at <https://justine.lol/make/>.

## Reference

This reference covers features added in our Landlock Make fork. Please
see <https://justine.lol/dox/make.txt> for the GNU Make documentation.

### Variables

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

Permissions precede your path, follow by a colon. Possible permissions
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
`tty`, `recvfd`, `sendfd`, `fattr`, `inet`, `unix`, `id`, `dns`, `proc`,
`exec`, `prot_exec`, `vminfo`, and `tmppath`. See the documentation at
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
command is allowed to take. When the specified number of seconds elapse,
a `SIGXCPU` signal is sent to the process. By default this signal will
kill the process. If the signal is handled by the process, then it has
exactly one second to gracefully terminate before a `SIGKILL` is issued.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

#### `.MEMORY = SIZE`

Sets virtual memory space limit.

When this limit is violated, mmap() will begin returning `ENOMEM` which
will trickle down into functions like malloc() failing.

The size is specified in bytes. It may use Si notation, e.g. `64kb` for
64 kibibytes, `1G` for a gibibyte, etc. Units use base 1024. This size
may also be specified as a percent value, e.g. `10%` which will be
computed as ten percent of the amount of physical RAM available on the
host machine.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

#### `.FSIZE = SIZE`

Sets individual file size limit.

This specifies how big any given file can grow. If it's exceeded, then a
`SIGXFSZ` signal will be delivered to the process responsible.

The size is specified in bytes. It may use Si notation, e.g. `64kb` for
64 kilobytes, `1G` for a gigabyte, etc. Units use base 1000.

This variable may be specified on a build target, a pattern rule, or the
global scope (by order of precedence).

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
