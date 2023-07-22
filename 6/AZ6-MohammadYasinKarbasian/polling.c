#include <header.h>

void q1()
{
        long int cache;
        int data[8];
        char string[16];
        int index;
        int v;
        for (index = FIRST_ADC_INPUT; index <= LAST_ADC_INPUT; index++)
        {
                lcd_gotoxy(0, 0);
                lcd_puts("Question 1");
                data[index] = read_adc(index);
                cache = (long)data[index] * 5000;
                v = cache / 1024;
                lcd_gotoxy(0, 1);
                sprintf(string, "ADC[%d] = %dmv", index, v);
                lcd_puts(string);
                delay_ms(1000);
                lcd_clear();
        }
}

unsigned int read_adc(unsigned char adc_input)
{
        ADMUX = adc_input | ADC_VREF_TYPE;
        delay_us(10);
        ADCSRA |= (1 << ADSC);
        while ((ADCSRA & (1 << ADIF)) == 0)
                ;
        ADCSRA |= (1 << ADIF);
        return ADCW;
}

void init_q1()
{
        ADMUX = ADC_VREF_TYPE;
        ADCSRA = (1 << ADEN) | (0 << ADSC) | (1 << ADATE) | (0 << ADIF) | (0 << ADIE) | (0 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
        SFIOR = (0 << ADTS2) | (0 << ADTS1) | (0 << ADTS0);
}

void init()
{
        DDRA = (0 << DDA7) | (0 << DDA6) | (0 << DDA5) | (0 << DDA4) | (0 << DDA3) | (0 << DDA2) | (0 << DDA1) | (0 << DDA0);
        PORTA = (0 << PORTA7) | (0 << PORTA6) | (0 << PORTA5) | (0 << PORTA4) | (0 << PORTA3) | (0 << PORTA2) | (0 << PORTA1) | (0 << PORTA0);
        DDRB = (0 << DDB7) | (0 << DDB6) | (0 << DDB5) | (0 << DDB4) | (1 << DDB3) | (0 << DDB2) | (0 << DDB1) | (0 << DDB0);
        PORTB = (0 << PORTB7) | (0 << PORTB6) | (0 << PORTB5) | (0 << PORTB4) | (0 << PORTB3) | (0 << PORTB2) | (0 << PORTB1) | (0 << PORTB0);
        DDRC = (0 << DDC7) | (0 << DDC6) | (0 << DDC5) | (0 << DDC4) | (0 << DDC3) | (0 << DDC2) | (0 << DDC1) | (0 << DDC0);
        PORTC = (0 << PORTC7) | (0 << PORTC6) | (0 << PORTC5) | (0 << PORTC4) | (0 << PORTC3) | (0 << PORTC2) | (0 << PORTC1) | (0 << PORTC0);
        DDRD = (0 << DDD7) | (0 << DDD6) | (0 << DDD5) | (0 << DDD4) | (0 << DDD3) | (0 << DDD2) | (0 << DDD1) | (0 << DDD0);
        PORTD = (0 << PORTD7) | (0 << PORTD6) | (0 << PORTD5) | (0 << PORTD4) | (0 << PORTD3) | (0 << PORTD2) | (0 << PORTD1) | (0 << PORTD0);
        lcd_init(16);
}
