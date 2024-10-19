
_main:

;LCDv2.c,19 :: 		void main() {
;LCDv2.c,20 :: 		CMCON = 0x07;   // Desactiva los comparadores del microcontrolador para evitar interferencias
	MOVLW      7
	MOVWF      CMCON+0
;LCDv2.c,21 :: 		TRISB = 0x00;   // Configura PORTB como salida para enviar datos a la LCD
	CLRF       TRISB+0
;LCDv2.c,22 :: 		TRISA = 0x00;   // Configura PORTA como salida para los pines de control
	CLRF       TRISA+0
;LCDv2.c,24 :: 		LCDinit();  // Llama a la función de inicialización de la LCD
	CALL       _LCDinit+0
;LCDv2.c,25 :: 		Delay_ms(200);  // Espera 200 ms para dar tiempo a la LCD a inicializarse
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;LCDv2.c,28 :: 		LCDclear();  // Limpia la pantalla de la LCD
	CALL       _LCDclear+0
;LCDv2.c,29 :: 		LCDwriteMessage("Hola Mundo  0_o");  // Escribe el mensaje en la primera línea
	MOVLW      ?lstr_1_LCDv2+0
	MOVWF      FARG_LCDwriteMessage_message+0
	MOVLW      hi_addr(?lstr_1_LCDv2+0)
	MOVWF      FARG_LCDwriteMessage_message+1
	CALL       _LCDwriteMessage+0
;LCDv2.c,30 :: 		LCDsetCursor(1, 15);  // Coloca el cursor en la segunda fila y en la posición 15
	MOVLW      1
	MOVWF      FARG_LCDsetCursor_row+0
	MOVLW      15
	MOVWF      FARG_LCDsetCursor_col+0
	CALL       _LCDsetCursor+0
;LCDv2.c,31 :: 		LCDcommand(0b11000000);  // Comando que mueve el cursor a la segunda línea
	MOVLW      192
	MOVWF      FARG_LCDcommand_command+0
	CALL       _LCDcommand+0
;LCDv2.c,32 :: 		LCDwriteMessage("By:Ernest");  // Escribe el mensaje en la segunda línea
	MOVLW      ?lstr_2_LCDv2+0
	MOVWF      FARG_LCDwriteMessage_message+0
	MOVLW      hi_addr(?lstr_2_LCDv2+0)
	MOVWF      FARG_LCDwriteMessage_message+1
	CALL       _LCDwriteMessage+0
;LCDv2.c,33 :: 		Delay_ms(4000);  // Pausa de 4 segundos para que el usuario pueda leer el mensaje
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
;LCDv2.c,36 :: 		LCDclear();  // Limpia nuevamente la pantalla
	CALL       _LCDclear+0
;LCDv2.c,37 :: 		LCDwriteMessage("Clase de Micros");  // Escribe el mensaje en la primera línea
	MOVLW      ?lstr_3_LCDv2+0
	MOVWF      FARG_LCDwriteMessage_message+0
	MOVLW      hi_addr(?lstr_3_LCDv2+0)
	MOVWF      FARG_LCDwriteMessage_message+1
	CALL       _LCDwriteMessage+0
;LCDv2.c,38 :: 		LCDwriteBinary(0, 15, 0b11001000); // Escribe un valor binario en la posición especificada
	CLRF       FARG_LCDwriteBinary_row+0
	MOVLW      15
	MOVWF      FARG_LCDwriteBinary_col+0
	MOVLW      200
	MOVWF      FARG_LCDwriteBinary_binary+0
	CALL       _LCDwriteBinary+0
;LCDv2.c,39 :: 		LCDcommand(0b11000000);  // Mueve el cursor a la segunda línea
	MOVLW      192
	MOVWF      FARG_LCDcommand_command+0
	CALL       _LCDcommand+0
;LCDv2.c,40 :: 		LCDwriteMessage("Fes Aragon UNAM");  // Escribe el segundo mensaje en la segunda línea
	MOVLW      ?lstr_4_LCDv2+0
	MOVWF      FARG_LCDwriteMessage_message+0
	MOVLW      hi_addr(?lstr_4_LCDv2+0)
	MOVWF      FARG_LCDwriteMessage_message+1
	CALL       _LCDwriteMessage+0
;LCDv2.c,41 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_Pulse:

;LCDv2.c,44 :: 		void Pulse() {
;LCDv2.c,45 :: 		E = 1; Delay_ms(10); E = 0; Delay_ms(10);  // Pulso de activación y desactivación del pin E
	BSF        PORTA+0, 1
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_Pulse2:
	DECFSZ     R13+0, 1
	GOTO       L_Pulse2
	DECFSZ     R12+0, 1
	GOTO       L_Pulse2
	NOP
	NOP
	BCF        PORTA+0, 1
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_Pulse3:
	DECFSZ     R13+0, 1
	GOTO       L_Pulse3
	DECFSZ     R12+0, 1
	GOTO       L_Pulse3
	NOP
	NOP
;LCDv2.c,46 :: 		}
L_end_Pulse:
	RETURN
; end of _Pulse

_LCDinit:

;LCDv2.c,49 :: 		void LCDinit() {
;LCDv2.c,50 :: 		Delay_ms(200);  // Espera para asegurar que la LCD esté lista
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_LCDinit4:
	DECFSZ     R13+0, 1
	GOTO       L_LCDinit4
	DECFSZ     R12+0, 1
	GOTO       L_LCDinit4
	DECFSZ     R11+0, 1
	GOTO       L_LCDinit4
	NOP
;LCDv2.c,51 :: 		LCDcommand(0b00111000);  // Configura la LCD en modo 8 bits y 2 líneas
	MOVLW      56
	MOVWF      FARG_LCDcommand_command+0
	CALL       _LCDcommand+0
;LCDv2.c,52 :: 		LCDcommand(0b00001100);  // Enciende la LCD sin mostrar el cursor
	MOVLW      12
	MOVWF      FARG_LCDcommand_command+0
	CALL       _LCDcommand+0
;LCDv2.c,53 :: 		LCDcommand(0b00000110);  // Habilita el desplazamiento automático del cursor a la derecha
	MOVLW      6
	MOVWF      FARG_LCDcommand_command+0
	CALL       _LCDcommand+0
;LCDv2.c,54 :: 		LCDclear();  // Limpia la pantalla de la LCD
	CALL       _LCDclear+0
;LCDv2.c,55 :: 		}
L_end_LCDinit:
	RETURN
; end of _LCDinit

_LCDcommand:

;LCDv2.c,58 :: 		void LCDcommand(unsigned char command) {
;LCDv2.c,59 :: 		RS = 0;  // Configura el pin RS para enviar un comando (0)
	BCF        PORTA+0, 0
;LCDv2.c,60 :: 		DATA_PORT = command;  // Carga el comando en el puerto de datos
	MOVF       FARG_LCDcommand_command+0, 0
	MOVWF      PORTB+0
;LCDv2.c,61 :: 		Pulse();  // Envía el pulso de confirmación
	CALL       _Pulse+0
;LCDv2.c,62 :: 		}
L_end_LCDcommand:
	RETURN
; end of _LCDcommand

_LCDwriteChar:

;LCDv2.c,65 :: 		void LCDwriteChar(unsigned char character) {
;LCDv2.c,66 :: 		RS = 1;  // Configura el pin RS para enviar datos (1)
	BSF        PORTA+0, 0
;LCDv2.c,67 :: 		DATA_PORT = character;  // Carga el carácter en el puerto de datos
	MOVF       FARG_LCDwriteChar_character+0, 0
	MOVWF      PORTB+0
;LCDv2.c,68 :: 		Pulse();  // Envía el pulso de confirmación
	CALL       _Pulse+0
;LCDv2.c,69 :: 		}
L_end_LCDwriteChar:
	RETURN
; end of _LCDwriteChar

_LCDwriteMessage:

;LCDv2.c,72 :: 		void LCDwriteMessage(const char* message) {
;LCDv2.c,73 :: 		while(*message) {  // Recorre cada carácter de la cadena
L_LCDwriteMessage5:
	MOVF       FARG_LCDwriteMessage_message+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_LCDwriteMessage_message+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_LCDwriteMessage6
;LCDv2.c,74 :: 		LCDwriteChar(*message++);  // Escribe el carácter y avanza al siguiente
	MOVF       FARG_LCDwriteMessage_message+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_LCDwriteMessage_message+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_LCDwriteChar_character+0
	CALL       _LCDwriteChar+0
	INCF       FARG_LCDwriteMessage_message+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_LCDwriteMessage_message+1, 1
;LCDv2.c,75 :: 		}
	GOTO       L_LCDwriteMessage5
L_LCDwriteMessage6:
;LCDv2.c,76 :: 		}
L_end_LCDwriteMessage:
	RETURN
; end of _LCDwriteMessage

_LCDclear:

;LCDv2.c,79 :: 		void LCDclear() {
;LCDv2.c,80 :: 		LCDcommand(0b00000001);  // Envía el comando para limpiar la pantalla
	MOVLW      1
	MOVWF      FARG_LCDcommand_command+0
	CALL       _LCDcommand+0
;LCDv2.c,81 :: 		Delay_ms(30);  // Espera el tiempo necesario para completar la operación
	MOVLW      39
	MOVWF      R12+0
	MOVLW      245
	MOVWF      R13+0
L_LCDclear7:
	DECFSZ     R13+0, 1
	GOTO       L_LCDclear7
	DECFSZ     R12+0, 1
	GOTO       L_LCDclear7
;LCDv2.c,82 :: 		}
L_end_LCDclear:
	RETURN
; end of _LCDclear

_LCDsetCursor:

;LCDv2.c,85 :: 		void LCDsetCursor(unsigned char row, unsigned char col) {
;LCDv2.c,87 :: 		if (row == 1) {
	MOVF       FARG_LCDsetCursor_row+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_LCDsetCursor8
;LCDv2.c,88 :: 		address = col;  // La primera fila empieza en la dirección 0x00
	MOVF       FARG_LCDsetCursor_col+0, 0
	MOVWF      LCDsetCursor_address_L0+0
;LCDv2.c,89 :: 		} else {
	GOTO       L_LCDsetCursor9
L_LCDsetCursor8:
;LCDv2.c,90 :: 		address = 0x40 + col;  // La segunda fila empieza en la dirección 0x40
	MOVF       FARG_LCDsetCursor_col+0, 0
	ADDLW      64
	MOVWF      LCDsetCursor_address_L0+0
;LCDv2.c,91 :: 		}
L_LCDsetCursor9:
;LCDv2.c,92 :: 		LCDcommand(0b10000000 | address);  // Envía el comando para posicionar el cursor
	MOVLW      128
	IORWF      LCDsetCursor_address_L0+0, 0
	MOVWF      FARG_LCDcommand_command+0
	CALL       _LCDcommand+0
;LCDv2.c,93 :: 		}
L_end_LCDsetCursor:
	RETURN
; end of _LCDsetCursor

_LCDwriteBinary:

;LCDv2.c,96 :: 		void LCDwriteBinary(unsigned char row, unsigned char col, unsigned char binary) {
;LCDv2.c,98 :: 		if (row == 0) {
	MOVF       FARG_LCDwriteBinary_row+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_LCDwriteBinary10
;LCDv2.c,99 :: 		command = 0x80 | col;  // Calcula la posición de la primera fila
	MOVLW      128
	IORWF      FARG_LCDwriteBinary_col+0, 0
	MOVWF      LCDwriteBinary_command_L0+0
;LCDv2.c,100 :: 		} else if (row == 1) {
	GOTO       L_LCDwriteBinary11
L_LCDwriteBinary10:
	MOVF       FARG_LCDwriteBinary_row+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_LCDwriteBinary12
;LCDv2.c,101 :: 		command = 0xC0 | col;  // Calcula la posición de la segunda fila
	MOVLW      192
	IORWF      FARG_LCDwriteBinary_col+0, 0
	MOVWF      LCDwriteBinary_command_L0+0
;LCDv2.c,102 :: 		} else {
	GOTO       L_LCDwriteBinary13
L_LCDwriteBinary12:
;LCDv2.c,103 :: 		return;  // Salir si la fila es inválida
	GOTO       L_end_LCDwriteBinary
;LCDv2.c,104 :: 		}
L_LCDwriteBinary13:
L_LCDwriteBinary11:
;LCDv2.c,106 :: 		LCDcommand(command);  // Envía el comando para colocar el cursor
	MOVF       LCDwriteBinary_command_L0+0, 0
	MOVWF      FARG_LCDcommand_command+0
	CALL       _LCDcommand+0
;LCDv2.c,107 :: 		LCDwriteChar(binary);  // Escribe el carácter representado por el valor binario
	MOVF       FARG_LCDwriteBinary_binary+0, 0
	MOVWF      FARG_LCDwriteChar_character+0
	CALL       _LCDwriteChar+0
;LCDv2.c,108 :: 		}
L_end_LCDwriteBinary:
	RETURN
; end of _LCDwriteBinary
