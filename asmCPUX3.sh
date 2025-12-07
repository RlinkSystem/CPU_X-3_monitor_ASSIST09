#!/bin/bash
#
# Made By Roger Landén	Sat Feb  1 12:34:21 CET 2025

emutty=/dev/tty.usbserial-1110

# set -x 
inf="$1"
asmfil=${inf%.*}
asmext=$([[ "${inf}" = *.* ]] && echo "${inf##*.}" || echo 'asm')

# -9 -> -3
echo asm6809 -3 -B -S -v -o ${asmfil}.s9 -l ${asmfil}.lst -E ${asmfil}.exp -s ${asmfil}.sym ${asmfil}.${asmext}
asm6809 -3 -B -S -v -o ${asmfil}.s9 -l ${asmfil}.lst -E ${asmfil}.exp -s ${asmfil}.sym ${asmfil}.${asmext}
ret=$?

if [[ $ret -ne 0 ]]
then
	printf "Exit code = %d\n" $ret
	exit $ret
fi

if [[ $? -eq 0 ]]
then
	echo eeprom --noenter --cli --memory 2764 --spi N --autoload N --startaddress 0x0000 --firstbyte Y --memorymap Y --datacache N ${asmfil}.s9 ${emutty}
	eeprom --noenter --cli --memory 2764 --spi N --autoload N --startaddress 0x0000 --firstbyte Y --memorymap Y --datacache N ${asmfil}.s9 ${emutty}
fi
