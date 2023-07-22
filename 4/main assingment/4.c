#include <mega16.h>
#include <alcd.h>
#include <stdio.h>

char started=0;
unsigned long counter=0;
int capacity = 0;
int glob_priod;
char temp[16];

void show(int hour, int min, int sec, int mlsec){
  if (hour<10){
  sprintf(temp, "0%d:", hour);     
  lcd_gotoxy(0, 0);
  lcd_puts(temp);
  }  
  else{
  sprintf(temp, "%d:", hour);     
  lcd_gotoxy(0, 0);
  lcd_puts(temp);
  } 
  
  if (min<10){
  sprintf(temp, "0%d:", min);     
  lcd_gotoxy(3, 0);
  lcd_puts(temp);
  }  
  else{
  sprintf(temp, "%d:", min);     
  lcd_gotoxy(3, 0);
  lcd_puts(temp);
  }
  
  if (sec<10){
  sprintf(temp, "0%d:", sec);     
  lcd_gotoxy(6, 0);
  lcd_puts(temp);
  }  
  else{
  sprintf(temp, "%d:", sec);     
  lcd_gotoxy(6, 0);
  lcd_puts(temp);
  }
  
  if (mlsec<10){
  sprintf(temp, "0%d", mlsec);     
  lcd_gotoxy(9, 0);
  lcd_puts(temp);
  }  
  else{
  sprintf(temp, "%d", mlsec);     
  lcd_gotoxy(9, 0);
  lcd_puts(temp);
  }

}

void timer_counter(){  
  if(PINB.5 == 0 && started == 0){  
  show(0,0,0,0);
   counter = 0;
  }
  else if(PINB.5==0 && started == 1){
  started = 0;
  TCCR0 = 0x00;
  }
  else if(PINB.4 ==0){
  started = 1;
  TCCR0 = 0x01;
  }
}

void parking(){    
  if (PINB.3 == 0)   // car out
  {
    if (capacity < 1000)
    {
        capacity++;
    } 
    lcd_gotoxy(0,1); 
    lcd_puts("       ");   
    lcd_gotoxy(0, 1);   
    sprintf(temp, "CE:%d", capacity);
    lcd_puts(temp);
  }
  else if (PINB.7 == 0)  // car in
  {
     
    if(capacity == 0){
    lcd_gotoxy(0,1); 
    lcd_puts("       ");   
    lcd_gotoxy(0,1);
    lcd_puts("CE:FULL");
    } 
    else{            
    capacity--;
    if (capacity == 0)
    {
      lcd_gotoxy(0,1); 
    lcd_puts("       ");   
      lcd_gotoxy(0, 1);
      lcd_puts("CE:FULL");
    }
    else
    {
      lcd_gotoxy(0,1); 
    lcd_puts("       ");   
      lcd_gotoxy(0, 1);   
      sprintf(temp, "CE:%d", capacity);
      lcd_puts(temp);
    }
    }
  }
}

void clock(){
  short int hour, minute,second,milisecond, number;
  TCNT0 = 0xB2;    
  
  if (counter == 0)
  {
    show(0,0,0,0);
  }
  counter++;
  number = counter;
  milisecond = number % 100;
  number = number / 100;
  second = number % 60;
  number = number / 60;
  minute = number % 60;
  number = number / 60;
  hour = number % 60;
  number = number / 60;
  show(hour,minute,second,milisecond);
}

void wave(){
  int period;  
  unsigned long a = PINA;
  period = (a * 39212)/1000+1;
  glob_priod = period;
  TCNT1L = period & 0x00FF;
  TCNT1H = period >> 8;
  lcd_gotoxy(7, 1);
  sprintf(temp, "TSG:%d", period);
  lcd_puts(temp);
}

void init_timer1(){
  TCNT1L = glob_priod & 0x00FF;
  TCNT1H = glob_priod >> 8;
}

interrupt [EXT_INT0] void ext_int0_isr(void)
{
  parking();
}

interrupt [EXT_INT1] void ext_int1_isr(void)
{
 timer_counter();
}

interrupt [EXT_INT2] void ext_int2_isr(void)
{
    wave();
}

interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
    clock();
}

interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
  init_timer1();
}

void main(void)
{
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
PORTC=0xFF;
DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (1<<CS00);
TCNT0=0xB2;
OCR0=0x00;
TCCR1A=(0<<COM1A1) | (1<<COM1A0) | (0<<COM1B1) | (1<<COM1B0) | (0<<WGM11) | (0<<WGM10);
TCCR1B=(0<<ICNC1) | (0<<ICES1) | (1<<WGM13) | (1<<WGM12) | (0<<CS12) | (1<<CS11) | (0<<CS10);
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0xFF;
ICR1L=0xFF;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
ASSR=0<<AS2;
TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
TCNT2=0x00;
OCR2=0x00;
TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
GICR|=(1<<INT1) | (1<<INT0) | (1<<INT2);
MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);
GIFR=(1<<INTF1) | (1<<INTF0) | (1<<INTF2);
UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
SFIOR=(0<<ACME);
ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
lcd_init(16);
#asm("sei")


TCCR0 = 0x00;
show(0,0,0,0);
lcd_gotoxy(0, 1);
lcd_puts("CE:FULL");


while (1)
      {}
}
