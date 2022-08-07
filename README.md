# Using Landlock to Sandbox GNU Make

*Author: Justine Alexandra Roberts Tunney <jtunney@gmail.com>*

I've modified GNU Make to support strict dependency checking. This is
all thanks to the [Landlock LSM](https://landlock.io/) system calls
which were introduced in Linux Kernel 5.13 twelve months ago. What it
means is that Make can now solve the cache invalidation problem similar
to [Bazel](https://bazel.build/) except with 5x better performance.

## Background

I blogged last month about my work porting OpenBSD pledge() and unveil()
to Linux <https://justine.lol/pledge/> as part of the Cosmopolitan Libc
project <https://github.com/jart/cosmopolitan>. The thought occurred to
me that sandboxes aren't just good for security: they have applications
in build systems too. So I used unveil() to patch GNU Make and made my
work available to the broader Linux and OpenBSD communities using the
[Actually Portable Executable](https://justine.lol/ape.html) format.

## How It Works

The basic idea is when Make runs a command, that command should only
have access to a limited number of files:

1. The resolved command executable (read/execute permission)
2. The "prerequisite" or dependent files (read-only permission)
3. The "target" output file (read/write/create permission)

That way, if some rogue unit test accidentally tries to `rm -rf /`, the
kernel will simply reject it using an `EACCES` error, because your root
directory wasn't declared as a dependency in your Makefile config.

For convenience, I've also chosen to implicitly whitelist a few other
hard-coded paths. The following files are always unveiled by Make:

- `o/tmp` (`rwcx` permission) for temporary files
- `o/third_party/gcc` (`rx` permission) for static toolchain binaries
- `build/bootstrap` (`rx` permission) for chicken-and-egg build tools
- `/dev/stdout`, `/dev/stderr`, and other harmless well-known paths

Landlocked Make can be customized using special variables per-target:

- `TARGET: .UNVEIL = [rwcx:]PATH...` to unveil without prerequisites
- `TARGET: .UNSANDBOXED = 1` to disable sandboxing on a build target

## Performance

Landlocked Make can build code five times faster than Google's Bazel
build system, while offering the same advantages in terms of safety.

To demonstrate this, I've configured this repository to compile 448 `.c`
files which are linked into 40 executables. Building 448 files in 448
different sandboxes takes:

- 3.0 seconds with Make
- 11.6 seconds with Bazel

So Landlocked Make is the clear winner. This benchmark was performed on
a 2 core Ubuntu 22.04 VM with 4gb of RAM running Linux 5.15. Also note
that Landlock requires Linux 5.13+. If you don't have Landlock in your
kernel, then GNU Make will silently continue along without sandboxing.

## Try It Out

Here's a patched prebuilt binary of Landlocked Make:

```
git clone https://github.com/jart/landlock-make
cd landlock-make
build/bootstrap/make.com
```

You can build Landlocked Make from scratch here:

```
git clone https://github.com/jart/cosmopolitan
cd cosmopolitan
make -j8 o//third_party/make/make.com
```

## Why It Matters

GNU Make already has a file dependency graph. It's a rich data structure
you define when you write your Makefile. It's a no-brainer to leverage
that data to implement a zero-configuration sandbox. That's the only way
to automatically prove a build configuration is correct. This technique
is commonly known as strict dependency checking. What it means is that
each target must declare all its dependencies. This must happen, since
otherwise GNU Make can't solve the second hardest problem in computer
science, which is cache invalidation.

Without strict dependency checking, your Makefile is going to behave in
strange and mysterious ways. You'll be constantly frustrated and running
`make clean` whenever something goes wrong, which slows things down by
forcing everything to start over. In the traditional world of Make, even
if you take great care in writing your makefile, there's simply no way
prove it's correct without sandboxing. It's the missing link we've been
wanting for decades. It's a surprise no one's done it sooner.

Google came to a similar conclusion back in the 2000's. They solved this
by ditching GNU Make and inventing a new build system called Blaze. A
blog post was published back in 2011 announcing their work. Google said
strict dependency checking was the key motivator for reinventing things.
See <http://google-engtools.blogspot.com/2011/08/build-in-cloud-how-build-system-works.html>.
Blaze was then later open sourced to the public as Bazel in 2015, but it
wasn't until 2021 that it was able to do strict dependency checking.

Because Bazel was written a long time ago, it implements sandboxing in a
clumsy way. Bazel creates a giant hierarchy of symbolic links. Then it
mounts and unmounts a ton of folders to create a fake filesystem which
is how they limit access. Worst of all, it's all written in Java, which
is a great way to be unpopular in the open source community. Bazel does
however deserve credit for all the work they put into making Java as
tiny as possible. Bazel is shipped as a 40mb single-file binary that
extracts itself on the fly. That's pretty impressive by Java standards,
but it's still a skulking monster compared to my slim and sexy 391kb
make.com binary which runs on six operating systems and doesn't require
extraction, so it's only got a few microseconds of startup latency.

Mega-corporations love Bazel because its safety benefits enable them to
scale their eng efforts into monolithic repositories with petabytes of
code. So naturally they don't care that much if Bazel is fifty megs. I
however refuse to believe that safety and professionalism go hand in
hand with bloat. Not at any scale. I believe we can have our cake and
eat it too. That's why I view Landlock as being such a game changer. It
lets us have 85% the benefits of Blaze, in a tiny lightweight package.
Since all complexity of sandboxing is now being abstracted by the Linux
Kernel, all I needed to do was add about 200 lines of code to the GNU
Make codebase. No root, mounts, chroot, or Docker required!

So looking back, I can't help but, would Google have invented Blaze had
Landlock been available back in the 2000's?

## Caveats

If you try Landlocked Make, then there's a few things worth taking into
consideration. I recommend you vendor your dependencies. I'd also
encourage you to use favor static binaries. That's how you're going to
get the most value out of this tool.

I've made some effort to support dynamic executables for Glibc and Musl
users. Just note that my primary interest is supporting the Cosmopolitan
Libc project. Our work has been battle tested there. Cosmo has about 1.5
million lines of code, and all of that can now be built with Landlocked
Make, including tests. Note that we do vendor all our tools, we link all
our programs statically, we never run distro-installed commands, and we
certainly don't use Docker.

That's basically how *BSD and Google already do things. But our approach
is going to seem alien to GNU/Linux developers. Please calibrate your
expectations accordingly. This is absolutely not a drop-in replacement
for GNU Make on existing codebases. Most GNU/Linux codebases have been
ported to so many platforms that their file relationship graphs are big
hairy messes. If you try Landlocked Make, then please start out using
this template for a new hobby project in a greenfield.

Yes, our Makefile config is very verbose. Cosmopolitan Libc has tools
for solving that. MKDEPS.COM is able to crawl 1.5 million lines of code
in 100ms on my PC to generate a 175,712 line `o/depend` file. It is so
much faster than using `gcc -M` and it totally automates the arduous
task of explicitly declaring header file dependencies. Give it a try!

Another thing to take into consideration, is it's best to refrain from
using shell script syntax in your build commands. If you don't use any
special characters, then GNU Make has an optimization where it'll pass
your command and arguments directly to execve(). That way Landlock will
know exactly which executable should be whitelisted. If you use special
shell syntax, then /bin/sh won't be whitelisted automatically, and we
won't be able to see which commands are being run inside your script.

## Future Roadmap

Since my GNU Make fork is an Actually Portable Executable that runs on
six operating systems, it'd be great to polyfill unveil() on other
operating systems too. The next fun project on my list will probably be
looking into FreeBSD jails, since I've heard so many good things about
them on online forums.

## Special Thanks

I'd like to thank [Mickaël Salaün](https://twitter.com/l0kod) for his
work on bringing Landlock to the Linux Kernel, as well as being a big
help on Twitter. I'd also thank [Günther
Noack](https://www.unix-ag.uni-kl.de/~guenther/) for offering a lot of
valuable feedback, that's helped this project be successful.
