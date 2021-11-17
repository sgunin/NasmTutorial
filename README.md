# NasmTutorial
NASM Tutorial under MacOSX

Примеры кода на языке Ассемблер для платформы MacOSX

Установка и настройка среды разработки
1. Скачиваем и устанавливаем Visual Studio Code под платформу MacOSX https://code.visualstudio.com
2. Устанавливаем плагин для поддержки синтаксиса языка "x86 and x86_64 Assembly" https://marketplace.visualstudio.com/items?itemName=13xforever.language-x86-64-assembly
3. Устанавливаем плагин для возможности компиляции и запуска программ на языке Ассемблера "Code Runner" https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner
4. Устанавливаем ассемблер в MacOSX #brew install nasm
5. Опционально. Устанавливаем отладчик GDB https://sourceware.org/gdb/wiki/PermissionsDarwin #brew install gdb
6. Настраиваем плагин запуска программ Code Runner, добавляя строчку в конфигурацию ".asm": "cd $dir && make source=$fileNameWithoutExt && ./$fileNameWithoutExt",

**Упражнение Lab01_Intro**
Проект состоит из двух файлов - файла инструкций сборки Makefile и файла с асемблером main.asm

Структура файла Makefile
# для компиляции файла с ассемблером запускаем NASM и указываем формат исполняемого файла Macho64 (формат MacOSX)
nasm -f macho64 ${source}.asm
# выполняем линковку объектного файла, сформированного на предыдущем шаге с библиотекой System операционной системы MacOSX
# указываем минимальную версию операционной системы, в которой поддерживается работоспособность исполняемого файла
# отключаем поддержку позиционно зависимого кода
ld -macosx_version_min 10.12 -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o ${source} ${source}.o -no_pie
# удаляем не используемый в дальнейшем объектный файл
rm ${source}.o
  
После сборки файл можно запустить ./main
В случае проблем с запуском, файлу необходимо добавить атрибут исполняемого командой chmod +x ./main

Структуру сформированного исполняемого файла можно посмотреть с использованием утилиты ObjDump
objdump -d -m main

main:
(__TEXT,__text) section
_main:
100003f94:	b8 04 00 00 02        movl	$33554436, %eax
100003f99:	bf 01 00 00 00        movl	$1, %edi
100003f9e:	48 8d 35 5b 00 00 00	leaq	msg(%rip), %rsi
100003fa5:	ba 0e 00 00 00        movl	$msg.len, %edx
100003faa:	0f 05                 syscall
100003fac:	b8 01 00 00 02        movl	$33554433, %eax
100003fb1:	bf 00 00 00 00        movl	$0, %edi
100003fb6:	0f 05                 syscall
