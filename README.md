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

## Configure Makefile to run
After installed the RISCV GNU Toolchain, clone the project for testing the board:
```bash
https://github.com/efabless/caravel_board.git
```
After cloned you will see the caravel_board folder, go to caravel_board/firmware/chipignite/blink click to Makefile to config some variable. At the top of the file command all the TOOLCHAIN_PATH and add a new toolchain path like this:
```bash
TOOLCHAIN_PATH=/opt/riscv/
```
Below you will see the TOOLCHAIN_PREFIX, set the toolchain prefix to:
```bash
TOOLCHAIN_PREFIX=riscv64-unknown-elf
```
Next, you will a line to combine all the PATH name, remove the -gcc so this should be like this:
```bash
$(TOOLCHAIN_PATH)$(TOOLCHAIN_PREFIX) -I../ -I../generated/ -O0 -mabi=ilp32 -march=$(ARCH) -D__vexriscv__ -Wl,-Bstatic,-T,../sections.lds,--strip-debug -ffreestanding -nostdlib -o $@ ../crt0_vex.S ../isr.c ../stub.c $<
```


