# CPU_X-3_monitor_ASSIST09
ASSIST09 - MC6809 Monitor, Copyright (C) Motorola, Inc., 1979, Appendix B of M6809PM

Adjusted for CPU X-3 rev 3

This is a source code copy of Motorola's ASSSIST09 monitor that
- Source code formating is adjusted/updated
- lightly modified to be adopted to CPU X-3 rev 3 build, regarding to
  - IO-addess range `$D000-$D3FF`
    - ACIA [6850] IO-address `$D006,$D007`
  - System Memory `$D400-$DFFF`

## Additions

- ROM extension to the ASSIST09
  - Detects if it is a MC6809 or HD63C09
  - Change the {cmdtable} list to support UPPER and lower case commands
  - Adds **BASIC**  cmd to the list, that init the setup and calls the Tiny Basic
- Add **Tiny BASIC** V1.37.2
  - WRITTEN 20-OCT-77 BY JOHN BYRNS
    - some minor code adjustments 
    - some code formating adjustment/update are done
    - Adjusted to ASSIST09 on CPU X-3
    - Adjusted to CPU X-3 Memmory map

## 8K EPROM map

- `$E000` Tiny Basic
- `$F000` ROM Extension to assist09
- `$F800` ASSIST09 *rom copy* with ACIA & RAM address adjustments

## Assembly

Using asm6809 from Ciaran Anscomb
Home page: [6809.org.uk asm6809](https://www.6809.org.uk/asm6809)

And for running development and testing of the EPROM code,
I'm using the EPROM emulatorn from My Geek Hoppy 
**Home Page:** [EPROM-EMU-NG](https://github.com/Kris-Sekula/EPROM-EMU-NG)
**github:** [github EPROM-EMU-NG](https://github.com/Kris-Sekula/EPROM-EMU-NG)

Have a script [`asmCPUX3.sh`] that I use for assembling the code and then load it to the EPROM emulatorn.

### files

|  File  |  Description  |
| ------ | ------------- |
| README.md | This README text |
| asmCPUX3.sh | Build script |
| ------ | ------------- |
| CPU-X3_ASSIST09.asm | The 8K EPROM setup |
| CPU-X3_ASSIST09.lst | Assembly listing |
| CPU-X3_ASSIST09.s9 | Motorola S9 HEX-bin file |
| CPU-X3_ASSIST09.exp |   |
| CPU-X3_ASSIST09.sym |   |
| ------ | ------------- |
| assist09.asm | ASSIST09 assembly code |
| extend_a09.asm | Extension "ROM" |
| basic.asm | Tiny BASIC |
| ------ | ------------- |
| macdef.mac | CPU X-3 Macro defines  |
| mpxdef.asm | CPU X-3 System definitions |
| ccflags.asm | CC flags defines |
| ascii_ctrl.asm | ASCII control char defines |
| swi_func.asm | ASSIST09 swi api codes |

