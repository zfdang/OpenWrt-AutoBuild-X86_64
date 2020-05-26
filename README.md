# 利用Github的Actions来编译openwrt的固件

主要文件有3个：

x86_64.config
这个是利用./scripts/diffconfig 生成的diff版本的config文件

customize.sh
在编译固件前，进行的一些定制化的工作

.github/workflows/Build_OP_x86_64.yml
利用Actions编译固件的脚本
这个脚本里，会去 https://github.com/zfdang/lede 下载代码，并且利用上述的两个文件做定制化，最后进行编译。

# 使用
目前的设置是提交代码就自动触发编译。

# 关于make defconfig

```
Defconfig
make defconfig
will produce a default configuration of the target device and build system, including a check of dependencies and prerequisites for the build environment.

Defconfig will also remove outdated items from .config. E.g. references to non-existing packages or config options.

It also checks the dependencies and will add possibly missing necessary dependencies. This can be used to “expand” a short .config recipe (like diffconfig output, possible even pruned further) to a full .config that the make process accepts.
```
