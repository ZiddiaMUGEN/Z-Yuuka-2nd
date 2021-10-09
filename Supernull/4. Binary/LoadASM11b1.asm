;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Z-Yuuka Supernull (1.1b1)                                            ;;
;; This removes range checking on var triggers, and allows any value    ;;
;; outside of (-3868,3868) to refer directly to a memory address.       ;;
;; This allows generalized memory editing via var access.				;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[bits 32]
;;;; 1. VirtualProtect the MUGEN code segment
mov eax,dword [0x67BD0324]			;; VirtualProtect ptr
push 0x67BD0344						;; lpflOldProtect
push 0x40							;; flNewProtect
push 0xDD000						;; dwSize
push 0x401000						;; lpAddress
call eax							;; execute VirtualProtect and return here

;;;; 2. Patch the var range checking code for READ
;;   Done in a couple steps:
;;   1. Change 0x00456F53 to read `JMP 0x00427FEC` - bytes: E9 94 10 FD FF
;;   2. Output some custom code to the location 0x00427FEC
;;   The custom code will be bytes representing the following instructions:
;;   cmp eax,0xF1C
;;   jg .read_raw
;;   cmp eax,-0xF1C
;;   jl .read_raw
;;   jmp 0x00456F47
;;   .read_raw:
;;   mov ebp,dword [eax]
;;   jmp 0x00458242
;; bytes: 3D 1C 0F 00 
;;        00 7F 0C 3D
;;        E4 F0 FF FF
;;        7C 05 E9 48
;;        EF 02 00 8B
;;        28 E9 3C 02
;;        03 00
mov ebx,0x00456F53					;; address for instruction to modify
mov dword [ebx],0xFD1094E9			;; write 1
mov byte [ebx+0x04],0xFF			;; write 2
mov ebx,0x00427FEC					;; address for location to write custom code
mov dword [ebx],0x000F1C3D			;; write 1
mov dword [ebx+0x04],0x3D0C7F00		;; write 2
mov dword [ebx+0x08],0xFFFFF0E4		;; write 3
mov dword [ebx+0x0C],0x48E9057C		;; write 4
mov dword [ebx+0x10],0x8B0002EF		;; write 5
mov dword [ebx+0x14],0x023CE928		;; write 6
mov word [ebx+0x18],0x0003			;; write 7

;;;; 3. Patch the var range checking code for WRITE
;;   Basically the same 2 steps:
;;   1. Change 0x00402E73 to read `JMP 0x0042800C` - bytes: E9 94 51 02 00
;;   2. Output some custom code to the location 0x0042800C
;;   cmp eax,0xF1C
;;   jg .write_raw
;;   cmp eax,-0xF1C
;;   jl .write_raw
;;   jmp 0x00402E67
;;   .write_raw:
;;   mov dword [eax],esi
;;   jmp 0x00402E6E
;; bytes: 3D 1C 0F 00 
;;        00 7F 0C 3D
;;        E4 F0 FF FF
;;        7C 05 E9 48
;;        AE FD FF 89 
;;        30 E9 48 AE 
;;        FD FF
mov ebx,0x00402E73
mov dword [ebx],0x025194E9
mov byte [ebx+0x04],0x00
mov ebx,0x0042800C
mov dword [ebx],0x000F1C3D
mov dword [ebx+0x04],0x3D0C7F00
mov dword [ebx+0x08],0xFFFFF0E4
mov dword [ebx+0x0C],0x48E9057C
mov dword [ebx+0x10],0x89FFFDAE
mov dword [ebx+0x14],0xAE48E930
mov word [ebx+0x18],0xFFFD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Finalization in this version is handled in the loader.               ;;
;; Just return.                                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ret