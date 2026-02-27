#!/bin/bash

## Updating and Upgrading System ... 
echo -e '\n >> Updating and Upgrading System ...\n'
sudo apt update
sudo apt upgrade -y

## Setting Password for root ... 
echo -e '\n >> Setting Password for root ...'
echo -e ' >> Create Password for "Root" ...\n'

sudo passwd root

## Executing Version Check for System ... 
echo -e '\n >> Starting Version Check for the system (2.1) ...\n'
# echo -e "\033[0;32mHello in Green\033[0m"

# A script to list version numbers of critical development tools

# If you have tools installed in other directories, adjust PATH here AND
# in ~lfs/.bashrc (section 4.4) as well.

LC_ALL=C 
PATH=/usr/bin:/bin

bail() { echo "FATAL: $1"; exit 1; }
grep --version > /dev/null 2> /dev/null || bail "grep does not work"
sed '' /dev/null || bail "sed does not work"
sort   /dev/null || bail "sort does not work"

ver_check()
{
   if ! type -p $2 &>/dev/null
   then 
     echo "ERROR: Cannot find $2 ($1)"; return 1; 
   fi
   v=$($2 --version 2>&1 | grep -E -o '[0-9]+\.[0-9\.]+[a-z]*' | head -n1)
   if printf '%s\n' $3 $v | sort --version-sort --check &>/dev/null
   then 
     printf "OK:    %-9s %-6s >= $3\n" "$1" "$v"; return 0;
   else 
     printf "ERROR: %-9s is TOO OLD ($3 or later required)\n" "$1"; 
     return 1; 
   fi
}

ver_kernel()
{
   kver=$(uname -r | grep -E -o '^[0-9\.]+')
   if printf '%s\n' $1 $kver | sort --version-sort --check &>/dev/null
   then 
     printf "OK:    Linux Kernel $kver >= $1\n"; return 0;
   else 
     printf "ERROR: Linux Kernel ($kver) is TOO OLD ($1 or later required)\n" "$kver"; 
     return 1; 
   fi
}

# Coreutils first because --version-sort needs Coreutils >= 7.0
ver_check Coreutils      sort     8.1 || bail "Coreutils too old, stop"
ver_check Bash           bash     3.2
ver_check Binutils       ld       2.13.1
ver_check Bison          bison    2.7
ver_check Diffutils      diff     2.8.1
ver_check Findutils      find     4.2.31
ver_check Gawk           gawk     4.0.1
ver_check GCC            gcc      5.4
ver_check "GCC (C++)"    g++      5.4
ver_check Grep           grep     2.5.1a
ver_check Gzip           gzip     1.3.12
ver_check M4             m4       1.4.10
ver_check Make           make     4.0
ver_check Patch          patch    2.5.4
ver_check Perl           perl     5.8.8
ver_check Python         python3  3.4
ver_check Sed            sed      4.1.5
ver_check Tar            tar      1.22
ver_check Texinfo        texi2any 5.0
ver_check Xz             xz       5.0.0
ver_kernel 5.4

if mount | grep -q 'devpts on /dev/pts' && [ -e /dev/ptmx ]
then echo "OK:    Linux Kernel supports UNIX 98 PTY";
else echo "ERROR: Linux Kernel does NOT support UNIX 98 PTY"; fi

alias_check() {
   if $1 --version 2>&1 | grep -qi $2
   then printf "OK:    %-4s is $2\n" "$1";
   else printf "ERROR: %-4s is NOT $2\n" "$1"; fi
}
echo "Aliases:"
alias_check awk GNU
alias_check yacc Bison
alias_check sh Bash

echo "Compiler check:"
if printf "int main(){}" | g++ -x c++ -
then echo "OK:    g++ works";
else echo "ERROR: g++ does NOT work"; fi
rm -f a.out

if [ "$(nproc)" = "" ]; then
   echo "ERROR: nproc is not available or it produces empty output"
else
   echo "OK: nproc reports $(nproc) logical cores are available"
fi

## Fulfilling Dependencies ...
echo -e "\n >> Fulfilling Requirements ...\n"
sudo apt install coreutils bash binutils bison diffutils findutils gawk gcc g++ grep gzip m4 make patch perl python3 sed tar texinfo xz-utils -y
sudo rm -rf /bin/sh
sudo ln /bin/bash /bin/sh

## Executing Version Check for System ... 
echo -e "\n >> Verifying Version Check Changes for the system ...\n"

# A script to list version numbers of critical development tools

# If you have tools installed in other directories, adjust PATH here AND
# in ~lfs/.bashrc (section 4.4) as well.

LC_ALL=C 
PATH=/usr/bin:/bin

bail() { echo "FATAL: $1"; exit 1; }
grep --version > /dev/null 2> /dev/null || bail "grep does not work"
sed '' /dev/null || bail "sed does not work"
sort   /dev/null || bail "sort does not work"

ver_check()
{
   if ! type -p $2 &>/dev/null
   then 
     echo "ERROR: Cannot find $2 ($1)"; return 1; 
   fi
   v=$($2 --version 2>&1 | grep -E -o '[0-9]+\.[0-9\.]+[a-z]*' | head -n1)
   if printf '%s\n' $3 $v | sort --version-sort --check &>/dev/null
   then 
     printf "OK:    %-9s %-6s >= $3\n" "$1" "$v"; return 0;
   else 
     printf "ERROR: %-9s is TOO OLD ($3 or later required)\n" "$1"; 
     return 1; 
   fi
}

ver_kernel()
{
   kver=$(uname -r | grep -E -o '^[0-9\.]+')
   if printf '%s\n' $1 $kver | sort --version-sort --check &>/dev/null
   then 
     printf "OK:    Linux Kernel $kver >= $1\n"; return 0;
   else 
     printf "ERROR: Linux Kernel ($kver) is TOO OLD ($1 or later required)\n" "$kver"; 
     return 1; 
   fi
}

# Coreutils first because --version-sort needs Coreutils >= 7.0
ver_check Coreutils      sort     8.1 || bail "Coreutils too old, stop"
ver_check Bash           bash     3.2
ver_check Binutils       ld       2.13.1
ver_check Bison          bison    2.7
ver_check Diffutils      diff     2.8.1
ver_check Findutils      find     4.2.31
ver_check Gawk           gawk     4.0.1
ver_check GCC            gcc      5.4
ver_check "GCC (C++)"    g++      5.4
ver_check Grep           grep     2.5.1a
ver_check Gzip           gzip     1.3.12
ver_check M4             m4       1.4.10
ver_check Make           make     4.0
ver_check Patch          patch    2.5.4
ver_check Perl           perl     5.8.8
ver_check Python         python3  3.4
ver_check Sed            sed      4.1.5
ver_check Tar            tar      1.22
ver_check Texinfo        texi2any 5.0
ver_check Xz             xz       5.0.0
ver_kernel 5.4

if mount | grep -q 'devpts on /dev/pts' && [ -e /dev/ptmx ]
then echo "OK:    Linux Kernel supports UNIX 98 PTY";
else echo "ERROR: Linux Kernel does NOT support UNIX 98 PTY"; fi

alias_check() {
   if $1 --version 2>&1 | grep -qi $2
   then printf "OK:    %-4s is $2\n" "$1";
   else printf "ERROR: %-4s is NOT $2\n" "$1"; fi
}
echo "Aliases:"
alias_check awk GNU
alias_check yacc Bison
alias_check sh Bash

echo "Compiler check:"
if printf "int main(){}" | g++ -x c++ -
then echo "OK:    g++ works";
else echo "ERROR: g++ does NOT work"; fi
rm -f a.out

if [ "$(nproc)" = "" ]; then
   echo "ERROR: nproc is not available or it produces empty output"
else
   echo "OK: nproc reports $(nproc) logical cores are available"
fi

## Verifying Version Check for System 
echo -e "\n >> System Verified & Granted for Execution ...\n"

## 2.6. Setting the $LFS Variable and the Umask
echo -e "\n >> 2.6. Setting the $LFS Variable, Umask and Permissions ...\n"
# sudo su
export LFS=/mnt/lfs
umask 022
sudo chown root:root $LFS
sudo chmod 755 $LFS

## 3. Installing Packages and Patches
echo -e "\n >> 3. Installing Packages and Patches ...\n"
sudo mkdir -v $LFS/sources
sudo chmod -v a+wt $LFS/sources

# cd $LFS/sources ## DO LATER
# wget --input-file=https://www.linuxfromscratch.org/lfs/downloads/stable-systemd/wget-list-systemd --continue --directory-prefix=$LFS/sources
# wget --input-file=wget-list-systemd --continue --directory-prefix=$LFS/sources
# wget --input-file=https://www.linuxfromscratch.org/lfs/downloads/stable-systemd/md5sums --continue --directory-prefix=$LFS/sources
# sudo chown root:root $LFS/sources/*

## 4. Final Preparations
echo -e "\n >> 4. Final Preparations ...\n"
sudo mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

whoami

# su root <<EOSU
for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools
# EOSU

whoami
## 4.3 Adding the LFS User
echo -e "\n >> 4.3 Adding the LFS User ...\n"
sudo groupadd lfs
sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs

echo -e '\n >> Create Password for "LFS" user ...\n'
sudo passwd lfs

sudo chown -v lfs $LFS/{usr{,/*},var,etc,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

whoami

echo -e '\n >> Enter Password for "LFS" user (if prompted) ...\n'
# su - lfs
# su lfs <<EOSU
su lfs -c '
## 4.4 Setting Up the Environment
echo -e "\n >> 4.4 Setting Up the Environment ...\n"

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1="\u:\w\$ " /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF
# EOSU
'
# exit

whoami

echo -e '\n >> Enter Password for "Root" (if prompted) ...\n'
# su - root -c "[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE"
[ ! -e /etc/bash.bashrc ] || sudo mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
echo -e '\n >> Enter Password for "LFS" user (if prompted) ...\n'

whoami
# su - lfs 
# su lfs <<EOSU
# make -j32
# su lfs <<EOSU
su lfs -c '
export MAKEFLAGS=-j32
cat >> ~/.bashrc << "EOF"
export MAKEFLAGS=-j$(nproc)
EOF
source ~/.bash_profile
# EOSU

whoami

## 5. Compiling a Cross-Toolchain
echo -e "\n >> 5. Compiling a Cross-Toolchain ...\n"

cd /mnt/lfs/sources
# 5.2 Binutls-2.46.0 - Pass 1
# https://sourceware.org/pub/binutils/releases/binutils-2.46.0.tar.xz
wget https://sourceware.org/pub/binutils/releases/binutils-2.46.0.tar.xz
tar -xvf binutils-2.46.0.tar.xz
cd binutils-2.46.0
mkdir -v build
cd build
time { ../configure --prefix="$LFS/tools" \
             --with-sysroot="$LFS" \
             --target="$LFS_TGT"   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror    \
             --enable-new-dtags  \
             --enable-default-hash-style=gnu \
             && make && make install; }
cd ../..
# rm binutils-2.46.0.tar.xz

# 5.3 GCC-15.2.0 - Pass 1
wget https://ftpmirror.gnu.org/gcc/gcc-15.2.0/gcc-15.2.0.tar.xz
tar -xvf gcc-15.2.0.tar.xz
cd gcc-15.2.0

wget https://ftpmirror.gnu.org/gmp/gmp-6.3.0.tar.xz
tar -xvf gmp-6.3.0.tar.xz
mv gmp-6.3.0 gmp
rm gmp-6.3.0.tar.xz

wget https://ftpmirror.gnu.org/mpfr/mpfr-4.2.2.tar.xz
tar -xvf mpfr-4.2.2.tar.xz
mv mpfr-4.2.2 mpfr
rm mpfr-4.2.2.tar.xz

wget https://ftpmirror.gnu.org/mpc/mpc-1.3.1.tar.gz
tar -xvf mpc-1.3.1.tar.gz
mv mpc-1.3.1 mpc
rm mpc-1.3.1.tar.gz

case $(uname -m) in
  x86_64)
    sed -e "/m64=/s/lib64/lib/" \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac

mkdir -v build
cd build

../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.42 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++

time { make && make install; }
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h

cd ..
# rm gcc-15.2.0.tar.xz

# 5.4. Linux-6.16.1 API Headers
wget https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.18.10.tar.xz
tar -xvf linux-6.18.10.tar.xz
cd linux-6.18.10
make mrproper
make headers
find usr/include -type f ! -name "*.h" -delete
cp -rv usr/include $LFS/usr

## NOT NEEDED mkdir -v build
# NOT NEEDED cd build

cd ..
# rm linux-6.18.10.tar.xz

# 5.5. Glibc-2.42
wget https://ftpmirror.gnu.org/glibc/glibc-2.42.tar.xz
wget https://www.linuxfromscratch.org/patches/lfs/development/glibc-fhs-1.patch
tar -xvf glibc-2.42.tar.xz
cd glibc-2.42
case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac

patch -Np1 -i ../glibc-2.42-fhs-1.patch
mkdir -v build
cd build
echo "rootsbindir=/usr/sbin" > configparms
../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --disable-nscd                     \
      libc_cv_slibdir=/usr/lib           \
      --enable-kernel=5.4

time { make && make DESTDIR=$LFS install; }
sed "/RTLDLIST=/s@/usr@@g" -i $LFS/usr/bin/ldd
echo "int main(){}" | $LFS_TGT-gcc -x c - -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ": /lib"
grep -E -o "$LFS/lib.*/S?crt[1in].*succeeded" dummy.log
grep -B3 "^ $LFS/usr/include" dummy.log
grep "SEARCH.*/usr/lib" dummy.log |sed "s|; |\n|g"
grep "/lib.*/libc.so.6 " dummy.log
grep found dummy.log
rm -v a.out dummy.log

cd ../..
# rm glibc-2.42.tar.xz
# rm glibc-fhs-1.patch

# EOSU
'
exit 0
# 5.6. Libstdc++ from GCC-15.2.0
## -------- PART OF GCC -----------

## 6. Cross Compiling Temporary Tools

# 6.2. M4-1.4.20

# 6.3. Ncurses-6.5-20250809

# 6.4. Bash-5.3

# 6.5. Coreutils-9.7

# 6.6. Diffutils-3.12

# 6.7. File-5.46

# 6.8. Findutils-4.10.0

# 6.9. Gawk-5.3.2

# 6.10. Grep-3.12

# 6.11. Gzip-1.14

# 6.12. Make-4.4.1

# 6.13. Patch-2.8

# 6.14. Sed-4.9

# 6.15. Tar-1.35

# 6.16. Xz-5.8.1

# 6.17. Binutils-2.45 - Pass 2

# 6.18. GCC-15.2.0 - Pass 2

## 7. Entering Chroot and Building Additional Temporary Tools
echo -e '\n >> 7. Entering Chroot and Building Additional Temporary Tools ...\n'
EOSU

echo -e '\n >> Enter Password for "Root" (if prompted) ...\n'
# su -
su root <<EOSU
chown --from lfs -R root:root $LFS/{usr,var,etc,tools}
case $(uname -m) in
  x86_64) chown --from lfs -R root:root $LFS/lib64 ;;
esac
EOSU
# exit

su lfs <<EOSU
mkdir -pv $LFS/{dev,proc,sys,run}
mount -v --bind /dev $LFS/dev
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
  mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi
EOSU

echo -e '\n >> Enter Password for "Root" (if prompted) ...\n'
# su -
su root <<EOSU
chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login
EOSU
# exit

su lfs <<EOSU
mkdir -pv /{boot,home,mnt,opt,srv}
mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}
mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/lib/locale
mkdir -pv /usr/local/{bin,lib,sbin}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}

ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp

## 7.6. Creating Essential Files and Symlinks
echo -e '\n >> 7.6. Creating Essential Files and Symlinks ...\n'

ln -sv /proc/self/mounts /etc/mtab
cat > /etc/hosts << EOF
127.0.0.1  localhost $(hostname)
::1        localhost
EOF

## Creating /etc/passwd file ...
echo -e '\n >> Creating /etc/passwd file ...\n'
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
systemd-journal-gateway:x:73:73:systemd Journal Gateway:/:/usr/bin/false
systemd-journal-remote:x:74:74:systemd Journal Remote:/:/usr/bin/false
systemd-journal-upload:x:75:75:systemd Journal Upload:/:/usr/bin/false
systemd-network:x:76:76:systemd Network Management:/:/usr/bin/false
systemd-resolve:x:77:77:systemd Resolver:/:/usr/bin/false
systemd-timesync:x:78:78:systemd Time Synchronization:/:/usr/bin/false
systemd-coredump:x:79:79:systemd Core Dumper:/:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
systemd-oom:x:81:81:systemd Out Of Memory Daemon:/:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
EOF

## Creating /etc/group file ...
echo -e '\n >> Creating /etc/group file ...\n'
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
systemd-journal:x:23:
input:x:24:
mail:x:34:
kvm:x:61:
systemd-journal-gateway:x:73:
systemd-journal-remote:x:74:
systemd-journal-upload:x:75:
systemd-network:x:76:
systemd-resolve:x:77:
systemd-timesync:x:78:
systemd-coredump:x:79:
uuidd:x:80:
systemd-oom:x:81:
wheel:x:97:
users:x:999:
nogroup:x:65534:
EOF

echo "tester:x:101:101::/home/tester:/bin/bash" >> /etc/passwd
echo "tester:x:101:" >> /etc/group
install -o tester -d /home/tester

exec /usr/bin/bash --login

touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp

## Installing 7.7. Gettext-0.26
echo -e '\n >> Installing 7.7. Gettext-0.26 ...\n'

## Installing 7.8. Bison-3.8.2
echo -e '\n >> Installing 7.8. Bison-3.8.2 ...\n'


## Installing 7.9. Perl-5.42.0
echo -e '\n >> Installing 7.9. Perl-5.42.0 ...\n'


## Installing 7.10. Python-3.13.7
echo -e '\n >> Installing 7.10. Python-3.13.7 ...\n'


## Installing 7.11. Texinfo-7.2
echo -e '\n >> Installing 7.11. Texinfo-7.2 ...\n'


## Installing 7.12. Util-linux-2.41.1
echo -e '\n >> Installing 7.12. Util-linux-2.41.1 ...\n'


## 7.13. Cleaning up and Saving the Temporary System

EOSU ## Until LFS user is required.






