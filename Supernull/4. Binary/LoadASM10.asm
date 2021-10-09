;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Z-Yuuka Supernull (1.0)                                              ;;
;; This removes range checking on var triggers, and allows any value    ;;
;; outside of (-3868,3868) to refer directly to a memory address.       ;;
;; This allows generalized memory editing via var access.				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[bits 32]
;;;; 1. VirtualProtect the MUGEN code segment
mov eax,dword [0x67BD0324]			;; VirtualProtect ptr
push 0x67BD0344						;; lpflOldProtect
push 0x40							;; flNewProtect
push 0x9A000						;; dwSize
push 0x401000						;; lpAddress
call eax							;; execute VirtualProtect and return here

;;;; 2. Patch the var range checking code for READ
;;   Done in a couple steps:
;;   1. Change 0x00486F7F to read `JMP 0x0049A700` - bytes: E9 7C 37 01 00
;;   2. Output some custom code to the location 0x0049A700
;;   The custom code will be bytes representing the following instructions:
;;   cmp eax,0xE9C
;;   jg .read_raw
;;   cmp eax,-0xE9C
;;   jl .read_raw
;;   jmp 0x00486F73
;;   .read_raw:
;;   mov esi,dword [eax]
;;   jmp 0x00488607
;; bytes: 3D 9C 0E 00
;;        00 7F 0C 3D
;;        64 F1 FF FF
;;        7C 05 E9 60
;;        C8 FE FF 8B
;;        30 E9 ED DE
;;        FE FF
mov ebx,0x00486F7F					;; address for instruction to modify
mov dword [ebx],0x01377CE9			;; write 1
mov byte [ebx+0x04],0x00			;; write 2
mov ebx,0x0049A700					;; address for location to write custom code
mov dword [ebx],0x000E9C3D			;; write 1
mov dword [ebx+0x04],0x3D0C7F00		;; write 2
mov dword [ebx+0x08],0xFFFFF164		;; write 3
mov dword [ebx+0x0C],0x60E9057C		;; write 4
mov dword [ebx+0x10],0x8BFFFEC8		;; write 5
mov dword [ebx+0x14],0xDEEDE930		;; write 6
mov word [ebx+0x18],0xFFFE			;; write 7

;;;; 3. Patch the var range checking code for WRITE
;;   Basically the same 2 steps:
;;   1. Change 0x00439803 to read `JMP 0x0049A750` - bytes: E9 48 0F 06 00
;;   2. Output some custom code to the location 0x0049A750
;;   cmp eax,0xE9C
;;   jg .write_raw
;;   cmp eax,-0xE9C
;;   jl .write_raw
;;   jmp 0x004397F7
;;   .write_raw:
;;   mov dword [eax],esi
;;   jmp 0x004397FE
;; bytes: 3D 9C 0E 00
;;        00 7F 0C 3D
;;        64 F1 FF FF
;;        7C 05 E9 94
;;        F0 F9 FF 89
;;        30 E9 94 F0
;;        F9 FF
mov ebx,0x00439803
mov dword [ebx],0x060F48E9
mov byte [ebx+0x04],0x00
mov ebx,0x0049A750
mov dword [ebx],0x000E9C3D
mov dword [ebx+0x04],0x3D0C7F00
mov dword [ebx+0x08],0xFFFFF164
mov dword [ebx+0x0C],0x94E9057C
mov dword [ebx+0x10],0x89FFF9F0
mov dword [ebx+0x14],0xF094E930
mov word [ebx+0x18],0xFFF9

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Finalization in this version is handled in the loader.               ;;
;; Just return.                                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ret