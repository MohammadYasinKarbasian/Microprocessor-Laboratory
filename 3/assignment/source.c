#include <headers.h>

interrupt [EXT_INT1] void ext_int1_isr(void)
{
   PORTC=~PORTC;

while(1){  
   q3_keypad(0,0); 
   lcd_gotoxy(0,1);
   lcd_puts("interrupt");  
   }
}

void q1_name(){
lcd_puts("Karbasian");
lcd_puts("\n9928883");
delay_ms(500);
lcd_clear();

}

void q2_str(){

char i;
char str[]="Welcome to the Microprocessor lab classes in Isfahan University of Thecnology. ";
char str2[16]="";
lcd_clear();
for( i=0;i<80;i++){
strncpy(str2,str+i ,15);
lcd_gotoxy(0,1);
lcd_puts(str2);
delay_ms(200);

 }
}
  



char q3_keypad(char x,char y)
{
char c;
char r;
char key;
char s;
char row[4]={0x10,0x20,0x40,0x80};
s=100;
for(r=0;r<4;r++)
{
PORTB=row[r];
c=5;
delay_ms(10);
if (PINB.0==1) c=0;
if (PINB.1==1) c=1;
if (PINB.2==1) c=2;
if (PINB.3==1) c=3;
if (!(c==5)){
key=(r*4)+c;
lcd_gotoxy(x,y);
lcd_putchar(data_key[key]);
s=data_key[key];
while (PINB.0==1) {}
while (PINB.1==1) {}
while (PINB.2==1) {}
while (PINB.3==1) {}
}
}
return s;
}



void q5_init(){
char s1;
char s0;
char f=0;
s1=10;
s0=10;
lcd_clear();
lcd_gotoxy(0,0);
lcd_puts("system init");
lcd_gotoxy(0,1);
lcd_puts("speed:??(0-50)r");
while(1){
s1=q3_keypad(6,1);
if(s1<100){
while(1){
s0=q3_keypad(7,1);

if(s0<100){
if((s1>'5')||(s1=='5' && s0>'0'))
{
lcd_gotoxy(0,1);
lcd_puts("speed:EE(0-50r)");
break;
}
else{
f=1;
break;
}
}
}
if(f==1){
break;}
}
}
f=0;

lcd_clear();
lcd_gotoxy(0,0);
lcd_puts("system init");
lcd_gotoxy(0,1);
lcd_puts("time:??(0-99)s");
while(1){
s1=q3_keypad(5,1);
if(s1<100){
while(1){
s0=q3_keypad(6,1);

if(s0<100){
if(s1=='9' && s0>'9')
{
lcd_gotoxy(0,1);
lcd_puts("time:EE(0-99)s");
break;
}
else{
f=1;
break;
}
}
}
if(f==1){
break;}
}
}
f=0;
lcd_clear();
lcd_gotoxy(0,0);
lcd_puts("system init");
lcd_gotoxy(0,1);
lcd_puts("w:??(0-99)kg");
while(1){
s1=q3_keypad(2,1);
if(s1<100){
while(1){
s0=q3_keypad(3,1);

if(s0<100){
if(s1=='9' && s0>'9')
{
lcd_gotoxy(0,1);
lcd_puts("w:EE(0-99)kg");
break;
}
else{
f=1;
break;
}
}
}
if(f==1){
break;}
}
}
f=0;
lcd_clear();
lcd_gotoxy(0,0);
lcd_puts("system init");
lcd_gotoxy(0,1);
lcd_puts("temp:??(20-80)c");
while(1){
s1=q3_keypad(5,1);
if(s1<100){
while(1){
s0=q3_keypad(6,1);

if(s0<100){
if((s1<'2')||(s1>'8')||(s1=='8' && s0>'0'))
{
lcd_gotoxy(0,1);
lcd_puts("temp:EE(20-80)c");
break;
}
else{
f=1;
break;
}
}
}
if(f==1){
break;}
}
}
lcd_clear();
lcd_puts("end of init");
lcd_puts("\n thanks");
delay_ms(1000);
lcd_clear();
}

void init(){
DDRA=0xff;
DDRB=0xf0;
DDRC=0xff;
DDRD=0x00;
PORTC=0x00;
GICR|=(1<<INT1) | (0<<INT0) | (0<<INT2);
MCUCR=(1<<ISC11) | (1<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);
GIFR=(1<<INTF1) | (0<<INTF0) | (0<<INTF2);
lcd_init(16);
}