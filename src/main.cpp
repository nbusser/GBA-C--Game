#include <gba_console.h>
#include <gba_interrupt.h>
#include <gba_systemcalls.h>

#include <cstdio>
#include <cstdlib>

int main() {
  irqInit();
  irqEnable(IRQ_VBLANK);

  consoleDemoInit();

  printf("\x1b[10;10HHello From Bazel!\n");

  while (true) {
    VBlankIntrWait();
  }
}
