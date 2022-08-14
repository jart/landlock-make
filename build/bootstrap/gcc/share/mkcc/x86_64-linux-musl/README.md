# `x86_64-linux-musl__x86_64-linux-musl__g++-4.8.5`

This toolchain can run on `x86_64-linux-musl` to compile c,c++ for
`x86_64-linux-musl` using:

- [gcc] 4.8.5
- [musl] 1.1.19
- [linux] 4.4.10
- [binutils] 2.28.1
- [gmp] 6.1.2
- [isl] 0.18
- [mpc] 1.0.3
- [mpfr] 3.1.6

This toolchain contains headers and binaries subject to [LICENSE] which
were built using [mkcc.sh]. It is possible to obtain the original source
code and reproduce this build by running the following command:

```sh
./mkcc.sh --c++11 --userspace --target=x86_64-linux-musl
```

That script was made possible thanks to:

- <https://github.com/richfelker/musl-cross-make>
- <https://github.com/just-containers/musl-cross-make>

[LICENSE]: LICENSE
[binutils]: https://sourceware.org/binutils/docs-2.28/
[gcc]: https://gcc.gnu.org/onlinedocs/gcc-4.8.5/gcc/
[gmp]: https://gmplib.org/
[isl]: http://isl.gforge.inria.fr/
[linux]: https://www.kernel.org/doc/html/latest/
[mkcc.sh]: mkcc.sh
[mpc]: http://www.multiprecision.org/downloads/mpc-1.0.3.pdf
[mpfr]: http://www.mpfr.org/
[musl]: https://www.musl-libc.org/
