#line 1 "C:/Users/erest/OneDrive/Escritorio/MicrosTeoria/LCDv2/LCDv2.c"








void Pulse();
void LCDinit();
void LCDcommand(unsigned char command);
void LCDwriteChar(unsigned char character);
void LCDwriteMessage(const char* message);
void LCDsetCursor(unsigned char row, unsigned char col);
void LCDwriteBinary(unsigned char row, unsigned char col, unsigned char binary);
void LCDclear();


void main() {
 CMCON = 0x07;
 TRISB = 0x00;
 TRISA = 0x00;

 LCDinit();
 Delay_ms(200);


 LCDclear();
 LCDwriteMessage("Hola Mundo  0_o");
 LCDsetCursor(1, 15);
 LCDcommand(0b11000000);
 LCDwriteMessage("By:Ernest");
 Delay_ms(4000);


 LCDclear();
 LCDwriteMessage("Clase de Micros");
 LCDwriteBinary(0, 15, 0b11001000);
 LCDcommand(0b11000000);
 LCDwriteMessage("Fes Aragon UNAM");
}


void Pulse() {
  PORTA.F1  = 1; Delay_ms(10);  PORTA.F1  = 0; Delay_ms(10);
}


void LCDinit() {
 Delay_ms(200);
 LCDcommand(0b00111000);
 LCDcommand(0b00001100);
 LCDcommand(0b00000110);
 LCDclear();
}


void LCDcommand(unsigned char command) {
  PORTA.F0  = 0;
  PORTB  = command;
 Pulse();
}


void LCDwriteChar(unsigned char character) {
  PORTA.F0  = 1;
  PORTB  = character;
 Pulse();
}


void LCDwriteMessage(const char* message) {
 while(*message) {
 LCDwriteChar(*message++);
 }
}


void LCDclear() {
 LCDcommand(0b00000001);
 Delay_ms(30);
}


void LCDsetCursor(unsigned char row, unsigned char col) {
 unsigned char address;
 if (row == 1) {
 address = col;
 } else {
 address = 0x40 + col;
 }
 LCDcommand(0b10000000 | address);
}


void LCDwriteBinary(unsigned char row, unsigned char col, unsigned char binary) {
 unsigned char command;
 if (row == 0) {
 command = 0x80 | col;
 } else if (row == 1) {
 command = 0xC0 | col;
 } else {
 return;
 }

 LCDcommand(command);
 LCDwriteChar(binary);
}
