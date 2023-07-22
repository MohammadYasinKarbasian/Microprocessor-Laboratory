#include <headers.h>

interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
 OverFlow = 1;
}

interrupt [TIM1_CAPT] void timer1_capt_isr(void)
{
 q6();
}

interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
TCNT2=0xB2;
q5();
}

void q2(char duty_cycle){
 TCNT0=0x00;
 OCR0= (255*duty_cycle+50)/100;   
}

void q4(){
 char temp;
 temp = PINA;
 temp = (temp*100)/255;
 q2(temp);
}

void changeB(char a,char b , char c, char d){
                PORTB.4 = a;  
                PORTB.5 = b;  
                PORTB.6 = c;  
                PORTB.7 = d;
}

void q5(){
    char str[16];
    if (counter<=100){
        if (clockwies == 1 ){ 
            if (turn == 1) {
                changeB(1,0,0,0);
                turn ++ ;
            }
            if (turn == 2) {
                changeB(0,1,0,0);  
                turn ++ ;
            }
            if (turn == 3) {
                changeB(0,0,1,0); 
                turn ++ ;
            }
            if (turn == 4) {
                changeB(0,0,0,1);
                turn = 1 ;
            }     
        }
        counter++;  
    }    
    if (counter==100){ 
           changeB(0,0,0,0);
           clockwies=0;
           delay_ms(3000);
           counter++;
    }
                  
    if (counter >100 &&  counter<=200){ 
        if (clockwies == 0 ){
            if (turn == 1) {
                changeB(0,0,0,1);
                turn ++ ;
            }
            if (turn == 2) {
                changeB(0,0,1,0);
                turn ++ ;
            }
            if (turn == 3) {
                changeB(0,1,0,0);
                turn ++ ;
            }
            if (turn == 4) {
                changeB(1,0,0,0);
                turn = 1;
            }  
        }
        counter++; 
    }   
    if (counter>200){
        counter=0; 
        clockwies=1;  
        delay_ms(3000);
    }
    speed = (60*90/360)/0.01;  
    sprintf(str,"%d",speed); 
    lcd_gotoxy(0,0);  
    lcd_puts("        ");
    lcd_gotoxy(0,0);  
    lcd_puts(str);
    lcd_gotoxy(6,0);
    lcd_puts("RPM");   
}

void q6(){
 char str[16];
 if(OverFlow==1){
   old = ICR1L;
   old += ICR1H*256; 
   OverFlow=0;
 }                
 else{
  new = ICR1L;
  new += ICR1H*256;
  rpm = 1200000/(new-old);
  old = new;  
  if(rpm-display_rpm >=5 || rpm-display_rpm <=-5){  

    display_rpm = rpm;
    sprintf(str, "DC: %d", display_rpm);
    lcd_gotoxy(0,1);  
    lcd_puts("        ");
    lcd_gotoxy(0,1);
    lcd_puts(str);
  }  
 }
}

void init(){
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
DDRD=(0<<DDD7) | (0<<DDD6) | (1<<DDD5) | (1<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
TCCR0=(1<<WGM00) | (1<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (1<<CS01) | (0<<CS00);
TCNT0=0x00;
OCR0=0x33;
TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
ASSR=0<<AS2;
TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (1<<CS22) | (1<<CS21) | (1<<CS20);
TCNT2=0xB2;
OCR2=0x00;
TIMSK=(0<<OCIE2) | (1<<TOIE2) | (1<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);
UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
SFIOR=(0<<ACME);
ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
lcd_init(16);
#asm("sei")
}
