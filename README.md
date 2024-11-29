## Setup environment and cross-compiler for chipignite

### Clone the GNU Toolchain for RISCV

```bash
git clone https://github.com/riscv/riscv-gnu-toolchain
```

### Run the configure
Inside riscv-gnu-toolchain folder, open terminal and export path for compiler:
```bash
export PATH=$PATH:/opt/riscv/bin
```
Configure permission for installing inside the /opt:
```bash
sudo chown username:username /opt
```
Run the following command to configure the set up:
```bash
./configure --prefix=/opt/riscv --enable-multilib
```
After finished, run make:
```bash
make
```
Wait for the setup to finish
