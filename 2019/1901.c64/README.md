# The Tyranny of the Rocket Equation

## Commodore 64 Edition

This is my Commdore 64 BASIC V2 solution for [Day 1 of the 2019 Advent of Code](https://adventofcode.com/2019/day/1).

To try it:

```
./run
```

This will build a .D64 Commodore 64 disk image from the BASIC program and its input file and then run it in the [VICE](http://vice-emu.sourceforge.net/) emulator.

## Building

The makefile (which `run` automatically calls) uses `petcat` and `c1541` from VICE to build the disk image from a ".bas" and ".in" file. It's pretty generic so it could be used in other Advent of Code solutions. 