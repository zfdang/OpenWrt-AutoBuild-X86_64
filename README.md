# 利用Github的Actions来编译openwrt的固件

主要文件有3个：

1. x86_64.config

这个是利用./scripts/diffconfig 生成的diff版本的config文件； 这个之后会利用make defconfig还原完整的.config文件

2. customize.sh

在编译固件前，进行的一些定制化的工作

3 .github/workflows/Build_OP_x86_64.yml

利用Actions编译固件的脚本；这个脚本里，会去 https://github.com/coolsnowwolf/lede 下载代码，并且利用上述的两个文件做定制化，最后进行编译。

# 编译设置

目前的设置是提交代码就触发自动编译；也会每周定时编译一份最新的代码；

# 固件下载

目前固件会每周编译一次。

编译好的固件，可以从Releases处下载，也可以从Actions处下载:

Releases: https://github.com/zfdang/OpenWrt-AutoBuild-X86_64/releases

Actions:https://github.com/zfdang/OpenWrt-AutoBuild-X86_64/actions?query=workflow%3ABuild_x86_64

里面有不同的压缩包，请根据需要下载对应的文件。

# 固件使用

固件的ETH0绑定LAN, ETH1绑定WAN.

LAN的IP地址是192.168.2.1

固件的登录信息：

  用户名: root 
  密码: password

# 如何定制x86_64.config

1. 首先装好 Ubuntu 64bit，推荐  Ubuntu  18 LTS x64

2. 命令行输入 `sudo apt-get update` ，然后输入

```
sudo apt update -y
sudo apt full-upgrade -y
sudo apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pyelftools libpython3-dev qemu-utils rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev python3-setuptools
```

3. 使用 `git clone --depth=1 https://github.com/coolsnowwolf/lede openwrt` 命令下载好源代码

4. 使用定制化脚本来customize openwrt
```
wget https://raw.githubusercontent.com/zfdang/OpenWrt-AutoBuild-X86_64/master/customize.sh
chmod +x customize.sh
./customize.sh
```

4. 生成定制化的config文件

```bash
   cd openwrt
   ./scripts/feeds clean
   ./scripts/feeds update -a
   ./scripts/feeds install -a
   ./scripts/feeds clean && ./scripts/feeds update -a && ./scripts/feeds install -a

   make menuconfig
   ./scripts/diffconfig.sh > diffconf
   
```

5. 使用config来进行编译
   
上载diffconf到 https://github.com/zfdang/OpenWrt-AutoBuild-X86_64/blob/master/x86_64.config

更新会自动触发编译。

# 关于make defconfig

```
Defconfig
make defconfig
will produce a default configuration of the target device and build system, including a check 
of dependencies and prerequisites for the build environment.

Defconfig will also remove outdated items from .config. E.g. references to non-existing packages 
or config options.

It also checks the dependencies and will add possibly missing necessary dependencies. This can
be used to “expand” a short .config recipe (like diffconfig output, possible even pruned further)
to a full .config that the make process accepts.
```
