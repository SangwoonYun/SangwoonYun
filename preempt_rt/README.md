# Patch Preempt-RT on Ubuntu
These are my notes on how to install `Preempt RT` patch for linux kernel on `Ubuntu`.    
I will be installing RT-PREEMPT kernel on Ubuntu.    
Kernel version I'm choosing is 5.4.193.


### Install Dependencies
Install compilers required for building the kernel.
```bash
sudo apt update
sudo apt install -y git build-essential libssl-dev libelf-dev libncurses-dev flex bison
```


### Download Kernel Source & Patch
Download the linux-5.4.193 kernel from [kernel.org](https://kernel.org/pub/) and RT patch.    
```bash
wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.4.193.tar.xz
wget https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.193-rt74.patch.xz
```

Extract the archive and apply the patch.
```bash
xz -cd linux-5.4.193.tar.xz | tar xvf -
cd linux-5.4.193
xzcat ../patch-5.4.193-rt74.patch.xz | patch -p1
```


### Configuration
Copy over the current config and use that to configure new kernel.
```bash
cp /boot/config-$(uname -r) .config
```

Delete `SYSTEM_TRUSTED_KEYS` & Disable `CONFIG_DEBUG_INFO_BTF` (If an error occurs...)
```bash
vi .config
```
```php
:%s/CONFIG_SYSTEM_TRUSTED_KEYS="debian\/canonical-certs.pem"/CONFIG_SYSTEM_TRUSTED_KEYS=""/
:%s/CONFIG_DEBUG_INFO_BTF=y/CONFIG_DEBUG_INFO_BTF=n/
```

Using the `menuconfig`, set it as follows:
```bash
make menuconfig
```
```mermaid
graph LR
A(General setup)-->A'(Preemption Model)-->A''(Fully Preemtible Kernel)
```
```mermaid
graph LR
B(Processor type and features)-->B'(Timer frequency)-->B''(1000 Hz)
```

If you need to disable `SMP`, try it as follows:
```mermaid
graph LR
C(Processor type and features)--> C'(Symmetric multi-processing support)
```


### Build and Install
Build the kernel as a debian package using make command.
```bash
make -j$(nproc) deb-pkg
sudo dpkg -i ../linux-headers-5.4.193-rt74_5.4.193-rt74-1_amd64.deb \
             ../linux-image-5.4.193-rt74_5.4.193-rt74-1_amd64.deb \
             ../linux-libc-dev_5.4.193-rt74-1_amd64.deb
```
or
```bash
make -j$(nproc)
make -j$(nproc) modules
sudo make -j$(nproc) modules_install
sudo make -j$(nproc) install
```


### Verification
Reboot system and check the kernel.    
It should show `PREEMPT_PT`.
```bash
uname -a
```

***

### Options
Enable os selection.
```bash
sudo vi /etc/default/grub
```
```ini
# Make the line comment
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=0
```
```bash
sudo update-grub
```

***

### Other Errors
Warning: os-prober will not be executed to detect other bootable partitions.
```bash
sudo vi /etc/default/grub
```
```ini
# Check for other operating systems
GRUB_DISABLE_OS_PROBER=false
```
```bash
sudo update-grub
```
