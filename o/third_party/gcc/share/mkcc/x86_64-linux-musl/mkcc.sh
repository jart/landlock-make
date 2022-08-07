#!/bin/sh
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

host=x86_64-linux-musl
target=
gcc=7.2.0
musl=1.1.19
linux=4.4.10
binutils=2.28.1
gmp=6.1.2
isl=0.18
mpc=1.0.3
mpfr=3.1.6
toolchain=https://github.com/just-containers/musl-cross-make/releases/download/v9/gcc-7.2.0-x86_64-linux-musl.tar.xz
toolchainsha=8fae4098cc230e61f542895d4ceddd4fbeed394a
repo=https://github.com/just-containers/musl-cross-make/archive/818070e84211135dc7dde7212875f22faab5da3b.tar.gz
reposha=a963e9a8772940dfeb6ea5f18d7e8b5182b04941
copts="-g0 -Os"
cpus=$(expr $(grep ^processor /proc/cpuinfo | wc -l) + 1)
i18n="--disable-nls"
tiny=
unhard=
stash="$HOME/.cache/mkcc"
vtv=
ldflags="-s"
type=g++
langs=c,c++
march=
userspace=

# Mandatory dependencies.
NL=$(command -v nl) || { echo need nl >&2; exit 1; }
command -v xz >/dev/null || { echo need xz >&2; exit 1; }
export XZ_OPT=--threads=0

# POSIX doesn't define mktemp.
TMPCTR=0
mktmp() { TMPCTR=$(expr $TMPCTR + 1); echo "${TMPDIR:-/tmp}/$1.$$.$TMPCTR"; }
mktmpdir() { r=$(mktmp $1); mkdir -p "$r" || return; echo "$r"; }

# Guarantee cleanup of `CMD... &track` children and recursive $TMPDIR.
export TMPDIR="$(mktmpdir mkcc)"
mkdir -p "$TMPDIR" || exit
track() { PIDS="$! $PIDS"; }
clean() {
  rc=$?
  trap '' INT
  trap - EXIT HUP TERM QUIT
  kill $PIDS 2>/dev/null ||:
  rm -rf "$TMPDIR" ||:
  exit $rc
}
trap clean EXIT HUP INT TERM QUIT

sha1() {
  sum="sha1sum"
  command -v sha1sum >/dev/null || sum="shasum -a 1"
  expr -- "$($sum "$@")" : '\([0-9a-f]*\)'
}

# Downloads, extracts, and verifies sha1 simultaneously.
curltarx() {
  url="$1"
  sha="$2"
  shift 2
  test "$url" || return
  if [ -f "$url" ]; then
    tar -x "$@" <"$url"
    return
  fi
  test "$sha" || return
  get="wget -O-"
  command -v wget >/dev/null || get="curl -fL"
  t=$(mktmpdir curltarx) || return
  mkfifo "$t/.pipe"
  sha1 <"$t/.pipe" >"$t/.digest" &
  $get "$url" | tee "$t/.pipe" | tar -x "$@"
  wait $!
  rc=$?
  [ $(expr -- "$(cat "$t/.digest")" : '\([0-9a-f]*\)') = "$sha" ] || rc=1
  rm -rf "$t"
  return $rc
}

# We can't verify unversioned downloads with a hard-coded sha1.
unreproducible_curl() {
  (
    url="$1"
    [ $(expr -- "$url" : https://) -gt 0 ] || return
    cache=
    if [ "$stash" ]; then
      cache="$stash/${url#https://}"
      if [ -e "$cache" ]; then
        cat "$cache"
        return $?
      fi
    fi
    export http_proxy=
    get="wget -O-"
    command -v wget >/dev/null || get="curl -fL"
    t=$(mktmp stash) || return
    if $get "$1" >"$t"; then
      if [ "$cache" ]; then
        if mkdir -p "${cache%/*}"; then
          if mv "$t" "$cache"; then
            cat "$cache"
            return
          fi
        fi
      else
        cat "$t" &
        rm "$t"
        wait $!
        return
      fi
    fi
    rm "$t"
    return 1
  )
}

# ToyBox is hard to build but has bountiful unversioned release binaries.
toy() {
  unreproducible_curl \
    https://landley.net/toybox/bin/toybox-$1 \
    >bin/toybox || return
  chmod +x bin/toybox || return
  for i in $(bin/toybox --long); do
    ln bin/toybox $i
  done
}

cleared=
for x; do
  test "$cleared" || set -- ; cleared=1
  case "$x" in
    --c)              type=gcc langs=c ;;
    --c++)            type=g++ langs=c,c++ ;;
    --c++98)          type=g++ langs=c,c++ gcc=4.2.1 ;;
    --c++0x)          type=g++ langs=c,c++ gcc=4.4.7 ;;
    --c++11)          type=g++ langs=c,c++ gcc=4.8.5
                      toolchain=https://github.com/just-containers/musl-cross-make/releases/download/v9/gcc-4.9.4-x86_64-linux-musl.tar.xz
                      toolchainsha=505dfe064b286a32ea4687913770523cbb8f362d
                      ;;
    --c++14)          type=g++ langs=c,c++ gcc=6.4.0 ;;
    --userspace)      userspace=1 ;;
    --i18n)           i18n="--enable-nls" ;;
    --tiny)           tiny="--disable-lto --disable-gomp --disable-shared --disable-tls --disable-libvtv" ;;
    --unhard)         unhard="--disable-libsanitizer --disable-default-pie --disable-libssp" ;;
    --host=*)         host="${x#*=}" ;;
    --target=*)       target="${x#*=}" ;;
    --gcc=*)          gcc="${x#*=}" ;;
    --musl=*)         musl="${x#*=}" ;;
    --linux=*)        linux="${x#*=}" ;;
    --binutils=*)     binutils="${x#*=}" ;;
    --gmp=*)          gmp="${x#*=}" ;;
    --isl=*)          isl="${x#*=}" ;;
    --mpc=*)          mpc="${x#*=}" ;;
    --mpfr=*)         mpfr="${x#*=}" ;;
    --toolchain=*)    toolchain="${x#*=}" ;;
    --toolchainsha=*) toolchainsha="${x#*=}" ;;
    --repo=*)         repo="${x#*=}" ;;
    --reposha=*)      reposha="${x#*=}" ;;
    --copts=*)        copts="${x#*=}" ;;
    --ldflags=*)      ldflags="${x#*=}" ;;
    --stash=*)        stash="${x#*=}" ;;

    -h|--help)
      cat <<EOF
mkcc.sh builds static toolchains, as modern as you want them to be.

Flags:
  -h, --help           show this
  --host=TRIPLET       toolchain runs on TRIPLET [default: $host]
  --target=TRIPLET     toolchain makes code for TRIPLET [default: noop]
  --bootstrap=HOST     build pure --host=HOST toolchain and clear flags
  --all                build toolchains targeting all known triplets
  --userspace          include posix utilities (and make build faster)
  --proxy              mitm download caching ~/.cache/mkcc
  --c                  suppport modern c only
  --c++                suppport modern c/c++ [default]
  --c++98              [WIP] use libstdc++ c. 4.2
  --c++0x              [WIP] use libstdc++ c. 4.4
  --c++11              use libstdc++ c. 4.8
  --c++14              use libstdc++ c. 6.x
  --i18n               enable GCC Native Language Support
  --tiny               remove LTO, OpenMP, shared libraries, etc.
  --unhard             have less concern about security hardening
  --copts=FLAGS        set C/CXXFLAGS for toolchain build [$copts]
  --ldflags=FLAGS      set LDFLAGS for toolchain build [$ldflags]
  --stash=PATH         set local file cache path [$stash]
  --gcc=VERSION        [$gcc]
  --musl=VERSION       [$musl]
  --linux=VERSION      [$linux]
  --binutils=VERSION   [$binutils]
  --gmp=VERSION        [$gmp]
  --isl=VERSION        [$isl]
  --mpc=VERSION        [$mpc]
  --mpfr=VERSION       [$mpfr]
  --toolchain=URL|FILE [$toolchain]
  --toolchainsha=SHA1  [$toolchainsha]
  --repo=URL           [$repo]
  --reposha=SHA1       [$reposha]

Static binaries should run on any Linux2.6+ system. Toolchain modernity
mostly concerns C++ binary size. Dynamic linking isn't recommended.

Examples:
  # Create modern C/C++ toolchain on x86_64 for x86_64.
  nice -n19 ./mkcc.sh --proxy --target=x86_64-linux-musl
  tool/bin/x86_64-linux-musl-c++ -static -s -g0 -O2 -fno-exceptions -ftree-vectorize -ffunction-sections -fdata-sections -Wl,--gc-sections -omatmul matmul.cc

  # Create C99/C++11 toolchain that can cross-compile.
  nice -n19 ./mkcc.sh --proxy --c++11 --all

  # Create POSIX system that can cross-compile.
  nice -n19 ./mkcc.sh --proxy --userspace --c --all
EOF
      exit
      ;;

    --all)
      "$0" --target=x86_64-linux-musl "$@" &track
      "$0" --target=x86_64-linux-muslx32 "$@" &track
      "$0" --target=i486-linux-musl "$@" &track
      "$0" --target=i686-linux-musl "$@" &track
      "$0" --target=arm-linux-musleabi "$@" &track
      "$0" --target=armeb-linux-musleabi "$@" &track  # big endian
      "$0" --target=aarch64-linux-musl "$@" &track
      "$0" --target=s390x-linux-musl "$@" &track  # big endian
      "$0" --target=powerpc-linux-musl "$@" &track  # big endian
      "$0" --target=powerpc64-linux-musl "$@" &track  # big endian
      "$0" --target=powerpc64le-linux-musl "$@" &track
      "$0" --target=microblaze-linux-musl "$@" &track  # big endian
      "$0" --target=sh2eb-linux-musl "$@" &track  # big endian
      "$0" --target=sh4-linux-musl "$@" &track
      "$0" --target=mips-linux-musl "$@" &track  # big endian
      "$0" --target=mipsel-linux-musl "$@" &track
      "$0" --target=mips64-linux-musl "$@" &track  # big endian
      "$0" --target=mips64el-linux-musl "$@" &track
      wait
      continue
      ;;

    --bootstrap=*)
      "$0" --c++ --gcc=$gcc --target=${x#*=} --host=$host --musl=$musl --linux=$linux --gmp=$gmp --isl=$isl --mpc=$mpc --mpfr=$mpfr --toolchain="$toolchain" --toolchainsha=$toolchainsha --repo="$repo" --reposha=$reposha || exit
      "$0" --c++ --gcc=$gcc --target=${x#*=} --host=${x#*=} --musl=$musl --linux=$linux --gmp=$gmp --isl=$isl --mpc=$mpc --mpfr=$mpfr --toolchain=${host}__${x#*=}__g++-${gcc}.tar.xz --repo="$repo" --reposha=$reposha || exit
      set -- --host=${x#*=} --toolchain=${x#*=}__${x#*=}__g++-${gcc}.tar.xz
      continue
      ;;

    --proxy)
      # Setup caching HTTP proxy so we don't slam GitHub and GNU web servers.
      # This requires $PATH middleware so wget/curl prefer http:// URLs.
      command -v python2 >/dev/null || { echo proxy needs python2 >&2; exit 1; }
      ptmp=$(mktmpdir proxy) || exit
      cat >"$ptmp/proxy.py" <<EOF
#!/usr/bin/env python2
import BaseHTTPServer
import SocketServer
import base64
import httplib
import mimetypes
import os
import shutil
import ssl
import sys
import tempfile
import urlparse
CACHE = sys.argv[1]
CACHEWORTHY = ('.zip', '.gz', '.bz2', '.xz')
CONTEXT = ssl.SSLContext(ssl.PROTOCOL_TLS)
CONTEXT.verify_mode = ssl.CERT_REQUIRED
CONTEXT.check_hostname = True
CONTEXT.load_default_certs(ssl.Purpose.CLIENT_AUTH)
def mkdir(path):
  """Makes directory with same behavior as mkdir -p."""
  try:
    os.makedirs(path)
  except OSError as e:
    if e.errno != 17:  # File exists
      raise
def connect(url, lasturl=None):
  scheme = url.scheme or lasturl.scheme
  netloc = (url.netloc or lasturl.netloc).split(':')
  if len(netloc) > 1:
    netloc[1] = int(netloc[1])
  if scheme == 'https':
    c = httplib.HTTPSConnection(*netloc, context=CONTEXT)
  else:
    c = httplib.HTTPConnection(*netloc)
  try:
    pu = urlparse.ParseResult('', '', url.path, url.params, url.query,
                              url.fragment)
    c.putrequest('GET', pu.geturl())
    c.endheaders()
    return c, c.getresponse()
  except:
    c.close()
    raise
class Handler(BaseHTTPServer.BaseHTTPRequestHandler):
  def go(self):
    if self.command != 'GET':
      self.send_error(405, 'Proxy only supports GET')
      return
    ru = urlparse.urlparse(self.path)
    if not ru.netloc or ru.scheme not in ('http', 'https'):
      self.send_error(400, 'Proxy needs http[s]://netloc')
      return
    stash = ''
    ntemp = None
    if ru.path.endswith(CACHEWORTHY):
      stash = '%s/%s%s' % (CACHE, ru.netloc, ru.path)
      if not os.path.realpath(stash).startswith(CACHE):
        self.send_error(400, 'Evil path')
        return
      if os.path.exists(stash):
        self.send_response(200)
        self.send_header('Content-Type', (mimetypes.guess_type(stash)[0] or
                                          'application/binary'))
        self.send_header('Content-Length', os.path.getsize(stash))
        self.end_headers()
        with open(stash) as r:
          shutil.copyfileobj(r, self.wfile)
          self.wfile.flush()
        return
      mkdir(os.path.dirname(stash))
      ntemp = tempfile.NamedTemporaryFile()
    try:
      c, r = connect(ru)
      try:
        hops = 1
        path = self.path
        while r.status in (301, 302):
          hops += 1
          if hops > 10:
            self.send_error(408, 'Loop detected')
            return
          location = r.getheader('location')
          ru2 = urlparse.urlparse(location)
          c.close()
          c = None
          c, r = connect(ru2, ru)
          ru = ru2
          path = location
        if r.status != 200:
          ntemp.close()
          ntemp = None
        self.send_response(r.status)
        for h in ('Content-Type', 'Content-Length', 'Content-Disposition'):
          v = r.getheader(h)
          if v:
            self.send_header(h, v)
        self.end_headers()
        while True:
          buf = r.read()
          if not buf:
            break
          if ntemp is not None:
            ntemp.write(buf)
          self.wfile.write(buf)
        self.wfile.flush()
        if ntemp is not None:
          ntemp.flush()
          os.rename(ntemp.name, stash)
      finally:
        c.close()
    except OSError as e:
      if e.errno != 32:  # Broken pipe
        raise
    finally:
      if ntemp is not None:
        try:
          ntemp.close()
        except OSError as e:
          if e.errno != 2:  # No such file or directory
            raise
  do_GET = go
  do_HEAD = go
class ThreadedHTTPServer(SocketServer.ThreadingMixIn,
                         BaseHTTPServer.HTTPServer):
  daemon_threads = True
server = ThreadedHTTPServer(('127.0.0.1', 0), Handler)
sys.stdout.write('%d\n' % server.server_port)
sys.stdout.flush()
server.serve_forever()
EOF
      mkfifo "$ptmp/stdout" || exit
      python2 "$ptmp/proxy.py" "$stash" >"$ptmp/stdout" &track
      read port <"$ptmp/stdout"
      [ "$port" -gt 0 ] || { echo failed to start http proxy >&2; exit 1; }
      cat "$ptmp/stdout" &
      proxy="$proxy $!"
      export http_proxy=http://127.0.0.1:$port
      mkdir "$ptmp/bin"
      for c in wget curl; do
        if command -v $c >/dev/null; then
          lol=  # the tools try so hard to stop us from doing this
          $c --no-hsts --version >/dev/null 2>&1 && lol=--no-hsts
          cat >"$ptmp/bin/$c" <<EOF
#!/bin/sh
cleared=
for x; do
  test "\$cleared" || set -- $lol ; cleared=1
  if [ \$(expr -- "\$x" : https://) -gt 0 ]; then
    x="http\${x#https}"
  fi
  set -- "\$@" "\$x"
done
exec `command -v $c` "\$@"
EOF
          chmod +x "$ptmp/bin/$c"
        fi
      done
      export PATH="$ptmp/bin:$PATH"
      continue
      ;;

    *)
      printf "%s: bad flag: %s\n" "$0" "$x" >&2
      exit 1
      ;;
  esac
  set -- "$@" "$x"
done
test "$target" || exit

flags="$*"
name="${host}__${target}__${type}-${gcc}"
[ -e "$name.tar.xz" ] && exit  # already done

# This will hopefully improve toolchain performance. The only x86_64 CPU
# this breaks is the very first AMD K8 model from 2003.
if [ $(expr $host : x86_64) -gt 0 ] && [ $(expr $target : x86_64) -gt 0 ]; then
  copts="-msse3 $copts"
fi

# Perform an invocation sanity check to be extra confident our
# instructions for reproducing the build are correct.
script="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)/mkcc.sh"
if [ ! -x "$script" ] || [ x"${0##*/}" != x"mkcc.sh" ]; then
  echo 'please invoke as ./mkcc.sh' >&2
  exit 1
fi

if [ "$toolchain" ]; then
  # Extracted toolchain binaries can be shared between processes.
  if [ -f "$toolchain" ]; then
    toolchainsha=$(sha1 "$toolchain") || exit
  fi
  tc="$stash/${toolchain##*/}.$toolchainsha"
  if [ ! -d "$tc" ]; then
    tctmp=$(mktmpdir toolchain)
    curltarx "$toolchain" "$toolchainsha" -JC "$tctmp"
    if [ ! -d "$tc" ]; then
      mkdir -p "$stash" || exit
      mv "$tctmp" "$tc" || exit
    else
      rm -rf "$tctmp"
    fi
  fi
  # Toolchains must be publicly reproducible.
  if [ $(expr -- "$toolchain" : http) -eq 0 ]; then
    if ! cmp -s "$script" "$tc/share/mkcc/$host/mkcc.sh"; then
      echo "--toolchain=$toolchain is not reproducible" >&2
      exit 1
    fi
  fi
  export PATH="$tc/bin:$PATH"
  [ -d "$tc/usr/bin" ] && export PATH="$tc/usr/bin:$PATH"
fi

set -ex
command -v "$host-cc" >/dev/null
command -v "$host-c++" >/dev/null
command -v make >/dev/null
command -v patch >/dev/null

# Set up musl-cross-make in the current directory.
dir="$PWD"
build="$PWD/$name.tmp"
[ -d "$build" ] && rm -rf "$build"
mkdir -p "$build"
curltarx "$repo" "$reposha" --strip-components=1 -zC "$build"
cd "$build"

export CC="$host-cc -static --static"
export CXX="$host-c++ -static --static"
export CFLAGS="$copts"
export CXXFLAGS="$copts"
export LDFLAGS="$ldflags"

# Configure musl-cross-make.
cat <<EOF | tee config.mak
TARGET = $target
BINUTILS_VER = $binutils
GCC_VER = $gcc
MUSL_VER = $musl
GMP_VER = $gmp
MPC_VER = $mpc
MPFR_VER = $mpfr
ISL_VER = $isl
LINUX_VER = $linux
MUSL_CONFIG += --enable-optimize=yes
COMMON_CONFIG += CC="$CC" CXX="$CXX"
COMMON_CONFIG += CFLAGS="$CFLAGS" CXXFLAGS="$CXXFLAGS"
COMMON_CONFIG += LDFLAGS="$LDFLAGS"
COMMON_CONFIG += $i18n $tiny $unhard
COMMON_CONFIG += --with-debug-prefix-map=\$(CURDIR)=
COMMON_CONFIG += --disable-multilib
GCC_CONFIG += --enable-languages=$langs
GCC_CONFIG += --disable-decimal-float
GCC_CONFIG += --disable-libquadmath
EOF

if [ "$userspace" ]; then
  # Add POSIX-2008 utilities to toolchain.
  mkdir -p output/bin output/sbin output/usr/bin output/usr/sbin
  prefix="$PWD/output"

  # Debian Almquist Shell (mkbuiltins doesn't work with ToyBox nl)
  mkdir pog
  ln -sf "$NL" pog/nl
  oldpath="$PATH"
  export PATH="$PWD/pog:$PATH"
  curltarx 'http://gondor.apana.org.au/~herbert/dash/files/dash-0.5.9.1.tar.gz' 7b9cb47fc2a007c26fedc99d22a7fc1dc2f5f914 -z
  cd dash-0.5.9.1
  ./configure --exec-prefix=''
  make -j$cpus
  mv src/dash ../output/bin/sh
  cd ..
  export PATH="$oldpath"

  # GNU Make
  curltarx 'https://ftp.gnu.org/gnu/make/make-4.2.tar.gz' 0ae8f44ad73e66d8f7b91e7e2e39ed8a8f2c7428 -z
  cd make-4.2
  ./configure --prefix="$prefix/usr"
  make -j$cpus
  make install
  cd ..

  # ToyBox
  cd output
  if   [ $(expr $host : x86_64) -gt 0 ]; then toy x86_64
  elif [ $(expr $host : i[45]86) -gt 0 ]; then toy i486
  elif [ $(expr $host : i[67]86) -gt 0 ]; then toy i686
  elif [ $(expr $host : aarch64-) -gt 0 ]; then toy aarch64
  elif [ $(expr $host : arm-) -gt 0 ]; then toy arm5l
  elif [ $(expr $host : microblaze-) -gt 0 ]; then toy microblaze
  elif [ $(expr $host : mips-) -gt 0 ]; then toy mips
  elif [ $(expr $host : mips64-) -gt 0 ]; then toy mips64
  elif [ $(expr $host : mipsel-) -gt 0 ]; then toy mipsel
  elif [ $(expr $host : powerpc-) -gt 0 ]; then toy powerpc
  elif [ $(expr $host : powerpc64-) -gt 0 ]; then toy powerpc64
  elif [ $(expr $host : s390x) -gt 0 ]; then toy s390x
  elif [ $(expr $host : sh2eb-) -gt 0 ]; then toy sh2eb
  elif [ $(expr $host : sh4-) -gt 0 ]; then toy sh4
  fi
  cd ..

  # GNU Patch
  curltarx 'https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz' 6f64fa75993bdb285ac4ed6eca6c9212725bff91 -J
  cd patch-2.7.6
  ./configure --prefix="$prefix/usr" --disable-silent-rules
  make -j$cpus
  make install
  cd ..
fi

# Cleanup stuff that could theoretically influence the build.
unset AS
unset CC
unset CFLAGS
unset CPP
unset CPPFLAGS
unset CXX
unset CXXFLAGS
unset LD
unset LDFLAGS
unset TARGET_ARCH
if [ "$nls" = "--disable-nls" ]; then
  export LANG=en_US.UTF-8
  export LC_CTYPE=en_US.UTF-8
fi

# Build the toolchain.
mkfifo .logfifo
gzip --fast <.logfifo >log.gz &
#make -j -l ${cpus}.0 2>&1 | tee .logfifo
make -j${cpus} 2>&1 | tee .logfifo
wait $!
make install

# This is helpful. Please note -no-pie might be necessary when
# dynamically linking musl with newer versions of GCC.
ln -sf ../lib/libc.so output/$target/bin/ldd

# Output documentation for this toolchain.
docs=output/share/mkcc/$target
mkdir -p $docs

# Static binaries built with the toolchain should be distributed with
# the following notice file.
cp musl-*/COPYRIGHT $docs/LICENSE.libc

# This file documents the licenses for the toolchain itself, so the
# tarball can be distributed.
{
  printf %s\\n "$name"
  echo
  echo Table of Contents
  echo -----------------
  for p in */COPY*; do
    printf -- "- %s\n" $p
  done
  for p in */COPY*; do
    echo
    printf %s\\n $p
    echo -----------------
    cat $p
  done
} >$docs/LICENSE

# When distributing Free Software binaries, the GPL asks that we respect
# others' freedom to obtain sources, make modifications, etc.
cp "$script" $docs/mkcc.sh
echo '#!/bin/sh' >$docs/reproduce.sh
sed 1d $tc/share/mkcc/$host/reproduce.sh >>$docs/reproduce.sh ||:
printf "./mkcc.sh %s\n" "$flags" >>$docs/reproduce.sh
chmod +x $docs/mkcc.sh $docs/reproduce.sh
cat >$docs/README.md <<EOF
# \`$name\`

This toolchain can run on \`$host\` to compile $langs for
\`$target\` using:

- [gcc] $gcc
- [musl] $musl
- [linux] $linux
- [binutils] $binutils
- [gmp] $gmp
- [isl] $isl
- [mpc] $mpc
- [mpfr] $mpfr

This toolchain contains headers and binaries subject to [LICENSE] which
were built using [mkcc.sh]. It is possible to obtain the original source
code and reproduce this build by running the following command:

\`\`\`sh
`sed 1d $docs/reproduce.sh`
\`\`\`

That script was made possible thanks to:

- <https://github.com/richfelker/musl-cross-make>
- <https://github.com/just-containers/musl-cross-make>

[LICENSE]: LICENSE
[binutils]: https://sourceware.org/binutils/docs-2.28/
[gcc]: https://gcc.gnu.org/onlinedocs/gcc-$gcc/gcc/
[gmp]: https://gmplib.org/
[isl]: http://isl.gforge.inria.fr/
[linux]: https://www.kernel.org/doc/html/latest/
[mkcc.sh]: mkcc.sh
[mpc]: http://www.multiprecision.org/downloads/mpc-$mpc.pdf
[mpfr]: http://www.mpfr.org/
[musl]: https://www.musl-libc.org/
EOF

tar -cJf "$dir/$name.tar.xz" --owner 0 --group 0 -C output .
rm -rf "$build"
