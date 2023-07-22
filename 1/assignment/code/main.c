
#include <mega16.h>
#include <delay.h>


void function1(void){
    int i = 0;
    for(i=0;i<4;i++){
        PORTB = 0xFF;
        delay_ms(500);
        PORTB = 0x00;
        delay_ms(500);
    }
}

void function2(void){
    
        int i = 4,k=0; 
        PORTB = 1<<i;
        delay_ms(1000);  
        for(k=0;k<9;k++){
        PORTB = 1 << (i+k)%8;
        delay_ms(375);     //375*8 = 3000  
        }
}

void function3(void){
 unsigned char temp = PINA;
 delay_ms(5);
 PORTB = PINA;
}

void function4(void){
 unsigned char digit[]={0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D,0x07, 0x7F, 0x6F};
 int i=0;      
 PORTD = PORTD & 0xF0;
 for(i=9;i>=0;i--){
  PORTC = digit[i];  
  delay_ms(400);
 }
}

void function5(void){
 int temp = PINA;   
  int i=0;
 unsigned char digit[]={0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D,0x07, 0x7F, 0x6F};
 delay_ms(5);  
 temp *= 10;
  while(temp>=0){
 for(i=0;i<5;i++)    // 10 * (5+5+5+5) = 10*20 = 200
 {
 int a = temp/1000;
 int b = (temp%1000)/100;
 int c = (temp%100)/10;
 int d = temp%10;
 PORTD = 0b11111110;
 PORTC = digit[a];
 delay_ms(10);
 PORTD = 0b11111101;
 PORTC = digit[b];
 delay_ms(10);
 PORTD = 0b11111011; 
 PORTC = digit[c]|1<<7;
 delay_ms(10);
 PORTD = 0b11110111;  
 PORTC = digit[d];
 delay_ms(10);
}
 temp -= 2;
}
}

void function6(void){
 int temp = PINA;   
  int i=0;
 unsigned char digit[]={0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D,0x07, 0x7F, 0x6F};
 delay_ms(5);  
 temp *= 10;
  while(temp>=0){
  if(PIND.4==0)   {
   temp -= (temp%10);
  }   
  if(PIND.5==0)   {
   temp -= (int)((temp%100)/10)*10;
  }
  if(PIND.6==0)   {
   temp -= (int)((temp%1000)/100)*100;
  }
  if(PIND.7==0)   {
   temp -= (int)(temp/1000)*1000;
  }
 for(i=0;i<5;i++)    // 10 * (5+5+5+5) = 10*20 = 200
 {
 int a = temp/1000;
 int b = (temp%1000)/100;
 int c = (temp%100)/10;
 int d = temp%10;
 PORTD = 0b11111110;
 PORTC = digit[a];
 delay_ms(10);
 PORTD = 0b11111101;
 PORTC = digit[b];
 delay_ms(10);
 PORTD = 0b11111011; 
 PORTC = digit[c]|1<<7;
 delay_ms(10);
 PORTD = 0b11110111;  
 PORTC = digit[d];
 delay_ms(10);
}
 temp -= 2;
}
}


void main(void)
{

DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);


while (1)
    
      {   
       function1();
       function2();
       function3();    
       function4();   
       function5();
       function6();
      }
}
