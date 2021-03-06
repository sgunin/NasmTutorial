default rel     ; Mach-O 64-bit формат поддерживает только относительную адресацию

global _main:   ; объявляем глобально точку входа в приложение

section	.text   ; секция исполняемого кода

_main:
                            ; напечатаем строку в стандартный поток вывода
    mov     rax, 0x2000004  ; идентификатор функции Write
    mov     rdi, 1          ; задаем поток вывода информации - stdout
    lea     rsi, [msg]      ; адрес строки
    mov     rdx, msg.len    ; длина строки
    syscall                 ; системный вызов

                            ; корректно завершаем работу приложения
    mov     rax, 0x2000001  ; идентификатор функции Write
    mov     rdi, 0          ; код выхода - 0 (корректное завершение)
    syscall                 ; системный вызов

section .data   ; секция данных
msg:    db      "Hello, world!", 10
.len:   equ     $ - msg