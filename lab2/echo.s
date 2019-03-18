SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDIN = 0
STDOUT = 1
EXIT_SUCCESS = 0
.align 32

.global _start
_start:

mov $1, %esi				# esi - licznik petli
mov $SYSREAD, %eax			# eax - SYSREAD
mov $STDIN, %ebx			# ebx - STDIN
mov $1, %edx				# edx - dlugosc=1
read:
	int $0x80				#wywolanie
	inc %esi				#licznik++
	push %ecx				#push...dziala?
	cmp $30, %esi			#warunek ->
	je end_read				#-> skok
	jmp read				#end
end_read:

#mov $SYSEXIT, %eax
#mov $EXIT_SUCCESS, %ebx
#int $0x80

mov $1, %esi				# esi -licznik
mov $SYSWRITE, %eax			# eax - SYSWRITE
mov $STDOUT, %ebx			# ebx - STDOUT
mov $1, %edx				# edx - dlugosc=1
echo:
	pop %ecx
	int $0x80
	inc %esi
	cmp $30, %esi
	je end_echo
	jmp echo
end_echo:

mov $SYSEXIT, %eax
mov EXIT_SUCCESS, %ebx
int $0x80
