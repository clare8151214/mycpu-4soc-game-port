CROSS_COMPILE ?= riscv64-unknown-elf-

ASFLAGS = -march=rv32im_zicsr -mabi=ilp32
# Optimization required: -O2 produces large stack frames that overflow in deep call chains
# RV32IM with hardware multiply/divide (M extension) for better performance
CFLAGS = -O2 -Wall -fno-builtin -march=rv32im_zicsr -mabi=ilp32 -I . -I trex -I tetris
LDFLAGS = --oformat=elf32-littleriscv

AS := $(CROSS_COMPILE)as
CC := $(CROSS_COMPILE)gcc
LD := $(CROSS_COMPILE)ld
OBJCOPY := $(CROSS_COMPILE)objcopy

# Program targets (add new programs here)
PROGRAMS := nyancat uart shell trex tetris vga_test
BINARIES := $(PROGRAMS:%=%.asmbin)

%.asmbin: %.elf
	$(OBJCOPY) -O binary -j .text -j .data $< $@

.DEFAULT_GOAL := all

all: $(BINARIES)

# All programs use proper init.S with ABI compliance and .bss clearing
nyancat.asmbin: nyancat.c nyancat-data.h init.o link.lds
	$(CC) $(CFLAGS) -DNYANCAT_COMPRESSION_DELTA=$(NYANCAT_COMPRESSION_DELTA) -c -o nyancat.o nyancat.c
	$(CROSS_COMPILE)ld -o nyancat.elf -T link.lds $(LDFLAGS) nyancat.o init.o
	$(OBJCOPY) -O binary -j .text -j .data nyancat.elf $@

uart.asmbin: uart.c mmio.h init.o link.lds
	$(CC) $(CFLAGS) -c -o uart.o uart.c
	$(CROSS_COMPILE)ld -o uart.elf -T link.lds $(LDFLAGS) uart.o init.o
	$(OBJCOPY) -O binary -j .text -j .data uart.elf $@

shell.asmbin: shell.c mmio.h init.o link.lds
	$(CC) $(CFLAGS) -c -o shell.o shell.c
	$(CROSS_COMPILE)ld -o shell.elf -T link.lds $(LDFLAGS) shell.o init.o
	$(OBJCOPY) -O binary -j .text -j .data shell.elf $@

vga_test.asmbin: vga_test.c mmio.h init.o link.lds
	$(CC) $(CFLAGS) -c -o vga_test.o vga_test.c
	$(CROSS_COMPILE)ld -o vga_test.elf -T link.lds $(LDFLAGS) vga_test.o init.o
	$(OBJCOPY) -O binary -j .text -j .data vga_test.elf $@
# --- T-Rex 遊戲多檔案編譯規則 ---
TREX_SOURCES = trex/main.c  trex/play.c trex/draw.c 
TREX_OBJS = $(TREX_SOURCES:.c=.o)

# 這裡把原本的 trex.asmbin 改成處理所有物件檔
# --- 修改後的 T-Rex 編譯規則 ---
# --- 最終修正版的 T-Rex 連結規則 ---
trex.asmbin: $(TREX_OBJS) init.o link.lds
	@echo "   LD      Linking T-Rex Project..."
# 加入 -nodefaultlibs 避免它去找 libc 和 lgloss
	$(CC) $(CFLAGS) -o trex.elf -T link.lds -nostartfiles -nodefaultlibs $(TREX_OBJS) init.o -lgcc
	$(OBJCOPY) -O binary -j .text -j .data trex.elf $@

TETRIS_SOURCES = tetris/tetris.c tetris/tetris_draw.c tetris/tetris_grid.c tetris/tetris_shape.c
TETRIS_OBJS = $(TETRIS_SOURCES:.c=.o)

tetris.asmbin: $(TETRIS_OBJS) init.o link.lds
	@echo "   LD      Linking Tetris Project..."
	$(CC) $(CFLAGS) -o tetris.elf -T link.lds -nostartfiles -nodefaultlibs $(TETRIS_OBJS) init.o -lgcc
	$(OBJCOPY) -O binary -j .text -j .data tetris.elf $@

%.o: %.c mmio.h
	@echo "  CC      $@"
	$(CC) $(CFLAGS) -c -o $@ $<

trex/%.o: trex/%.c mmio.h trex/trex.h 
	@echo "  CC      $@"
	$(CC) $(CFLAGS) -c -o $@ $<

tetris/%.o: tetris/%.c mmio.h tetris/tetris.h
	@echo "  CC      $@"
	$(CC) $(CFLAGS) -c -o $@ $<

init.o: init.S
	$(AS) -R $(ASFLAGS) -o $@ $<

# Generate nyancat animation data from upstream source
# Configure compression mode via NYANCAT_COMPRESSION_DELTA (default: 1 for delta-RLE)
# - NYANCAT_COMPRESSION_DELTA=1: delta-RLE compression (91% reduction, 4.7KB)
# - NYANCAT_COMPRESSION_DELTA=0: baseline RLE (87% reduction, 6.7KB)
NYANCAT_COMPRESSION_DELTA ?= 1

nyancat-data.h: ../../scripts/gen-nyancat-data.py
ifeq ($(NYANCAT_COMPRESSION_DELTA),1)
	python3 $< --delta --output $@
else
	python3 $< --output $@
endif

# Nyancat build depends on generated data
nyancat.o: nyancat.c nyancat-data.h

update: $(BINARIES)
	cp -f $(BINARIES) ../src/main/resources
	@echo ""
	@echo "Updated $(BINARIES) to ../src/main/resources"

clean:
	$(RM) *.o *.elf *.asmbin init_minimal.S nyancat-data.h

# Convenience targets (prevent implicit rule interference)
$(PROGRAMS): %: %.asmbin

.PHONY: all update clean $(PROGRAMS)
