#include <header.h>

char q1(char in_port){
 char data_in;
 switch (in_port){
  case(port_a):
    DDRA = 0x00;  
    data_in = PINA;
    break;
  case(port_b):
    DDRB = 0x00;  
    data_in = PINB;
    break;
  case(port_c):
    DDRC = 0x00;  
    data_in = PINC;
    break;
  case(port_d):
    DDRD = 0x00;  
    data_in = PIND;
    break;  
 }
 return data_in;
}

void q2(char out_port, char data){
 switch (out_port){
  case(port_a):
    DDRA = 0xFF;  
    PORTA = data;
    break;
  case(port_b):
    DDRB = 0xFF;  
    PORTB = data;
    break;
  case(port_c):
    DDRC = 0xFF;  
    PORTC = data;
    break;
  case(port_d):
    DDRD = 0xFF;  
    PORTD = data;
    break;  
 }
}

void q3(int count, int delay){
 int i;
 for(i=0;i<count;i++){
    q2(port_b,0xFF);
    delay_ms(delay);
    q2(port_b, 0x00);
    delay_ms(delay);
 
 }
}

void q4(){
 char data = q1(port_a);
 q2(port_b,data);
}

void q5(int data, char enable_port, char data_port){
 unsigned char digit [10] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};  
 int i;
 for(i=0;i<5;i++){   
 
 
 char a = data/1000;
 char b = (data%1000)/100;
 char c = (data%100)/10;
 char d = data%10;
 
  
 q2(enable_port,0b11111110);
 q2(data_port, digit[a]);
 delay_ms(10);
 q2(enable_port,0b11111111);

 
 q2(enable_port,0b11111101);
 q2(data_port, digit[b]);
 delay_ms(10);
 q2(enable_port,0b11111111);

 
 q2(enable_port,0b11111011);
 q2(data_port, digit[c]);
 delay_ms(10); 
 q2(enable_port,0b11111111);

 q2(enable_port,0b11110111);
 q2(data_port, digit[d]);
 delay_ms(10); 
 q2(enable_port,0b11111111);

}
}
