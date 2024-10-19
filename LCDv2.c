// Define los pines de control para la LCD
#define RS PORTA.F0  // Registro de Selección: 0 para comando, 1 para datos
#define E  PORTA.F1  // Pin de Enable: activa la LCD para leer comandos o datos

// Define el puerto de datos
#define DATA_PORT PORTB  // Se usa todo el puerto para simplificar la transferencia de datos

// Declaraciones de funciones para operar la LCD
void Pulse();  // Genera un pulso en el pin Enable para confirmar la operación
void LCDinit();  // Inicializa la pantalla LCD en el modo deseado
void LCDcommand(unsigned char command);  // Envía un comando a la LCD
void LCDwriteChar(unsigned char character);  // Escribe un solo carácter en la posición actual del cursor
void LCDwriteMessage(const char* message);  // Escribe una cadena de caracteres en la LCD
void LCDsetCursor(unsigned char row, unsigned char col);  // Coloca el cursor en una fila y columna específicas
void LCDwriteBinary(unsigned char row, unsigned char col, unsigned char binary);  // Escribe un valor en binario en la posición especificada
void LCDclear();  // Limpia toda la pantalla de la LCD

// Programa principal
void main() {
    CMCON = 0x07;   // Desactiva los comparadores del microcontrolador para evitar interferencias
    TRISB = 0x00;   // Configura PORTB como salida para enviar datos a la LCD
    TRISA = 0x00;   // Configura PORTA como salida para los pines de control

    LCDinit();  // Llama a la función de inicialización de la LCD
    Delay_ms(200);  // Espera 200 ms para dar tiempo a la LCD a inicializarse

    // Muestra el primer mensaje en la LCD
    LCDclear();  // Limpia la pantalla de la LCD
    LCDwriteMessage("Hola Mundo  0_o");  // Escribe el mensaje en la primera línea
    LCDsetCursor(1, 15);  // Coloca el cursor en la segunda fila y en la posición 15
    LCDcommand(0b11000000);  // Comando que mueve el cursor a la segunda línea
    LCDwriteMessage("By:Ernest");  // Escribe el mensaje en la segunda línea
    Delay_ms(4000);  // Pausa de 4 segundos para que el usuario pueda leer el mensaje

    // Muestra el segundo mensaje en la LCD
    LCDclear();  // Limpia nuevamente la pantalla
    LCDwriteMessage("Clase de Micros");  // Escribe el mensaje en la primera línea
    LCDwriteBinary(0, 15, 0b11001000); // Escribe un valor binario en la posición especificada
    LCDcommand(0b11000000);  // Mueve el cursor a la segunda línea
    LCDwriteMessage("Fes Aragon UNAM");  // Escribe el segundo mensaje en la segunda línea
}

// Genera un pulso en el pin Enable de la LCD para confirmar el envío de comandos o datos
void Pulse() {
    E = 1; Delay_ms(10); E = 0; Delay_ms(10);  // Pulso de activación y desactivación del pin E
}

// Inicializa la LCD en modo 8 bits, 2 líneas y sin cursor
void LCDinit() {
    Delay_ms(200);  // Espera para asegurar que la LCD esté lista
    LCDcommand(0b00111000);  // Configura la LCD en modo 8 bits y 2 líneas
    LCDcommand(0b00001100);  // Enciende la LCD sin mostrar el cursor
    LCDcommand(0b00000110);  // Habilita el desplazamiento automático del cursor a la derecha
    LCDclear();  // Limpia la pantalla de la LCD
}

// Envía un comando a la LCD para realizar configuraciones o ajustes
void LCDcommand(unsigned char command) {
    RS = 0;  // Configura el pin RS para enviar un comando (0)
    DATA_PORT = command;  // Carga el comando en el puerto de datos
    Pulse();  // Envía el pulso de confirmación
}

// Escribe un carácter en la posición actual del cursor
void LCDwriteChar(unsigned char character) {
    RS = 1;  // Configura el pin RS para enviar datos (1)
    DATA_PORT = character;  // Carga el carácter en el puerto de datos
    Pulse();  // Envía el pulso de confirmación
}

// Escribe una cadena de caracteres en la pantalla, avanzando automáticamente el cursor
void LCDwriteMessage(const char* message) {
    while(*message) {  // Recorre cada carácter de la cadena
        LCDwriteChar(*message++);  // Escribe el carácter y avanza al siguiente
    }
}

// Limpia toda la pantalla y coloca el cursor en la primera posición
void LCDclear() {
    LCDcommand(0b00000001);  // Envía el comando para limpiar la pantalla
    Delay_ms(30);  // Espera el tiempo necesario para completar la operación
}

// Establece el cursor en una posición específica (fila y columna)
void LCDsetCursor(unsigned char row, unsigned char col) {
    unsigned char address;
    if (row == 1) {
        address = col;  // La primera fila empieza en la dirección 0x00
    } else {
        address = 0x40 + col;  // La segunda fila empieza en la dirección 0x40
    }
    LCDcommand(0b10000000 | address);  // Envía el comando para posicionar el cursor
}

// Escribe un valor binario como un carácter en la posición indicada (fila y columna)
void LCDwriteBinary(unsigned char row, unsigned char col, unsigned char binary) {
    unsigned char command;
    if (row == 0) {
        command = 0x80 | col;  // Calcula la posición de la primera fila
    } else if (row == 1) {
        command = 0xC0 | col;  // Calcula la posición de la segunda fila
    } else {
        return;  // Salir si la fila es inválida
    }

    LCDcommand(command);  // Envía el comando para colocar el cursor
    LCDwriteChar(binary);  // Escribe el carácter representado por el valor binario
}
