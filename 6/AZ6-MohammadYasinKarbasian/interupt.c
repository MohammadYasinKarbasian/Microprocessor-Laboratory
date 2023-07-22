#include <header.h>

interrupt[ADC_INT] void adc_isr(void)
{
    static unsigned char input_index = 0;
    float dataset[8];
    char string[8];
    float upper = 0;
    float lower = 0;
    float data = 0;
    long int cache;
    int v;
    int index;
    float percent = 0;
    for (index = FIRST_ADC_INPUT; index <= LAST_ADC_INPUT; index++)
        dataset[index] = read_adc(index);
    if (++input_index > (LAST_ADC_INPUT - FIRST_ADC_INPUT))
        input_index = 0;
    ADMUX = (FIRST_ADC_INPUT | ADC_VREF_TYPE) + input_index;
    delay_us(10);

    for (index = FIRST_ADC_INPUT; index <= LAST_ADC_INPUT; index++)
    {
        data = dataset[index];

        percent = (float)(data / 20);
        upper = data + percent;
        lower = data - percent;
        if (upper < previous[index] || lower > previous[index])
        {
            previous[index] = data;
            lcd_clear();
            lcd_gotoxy(0, 0);
            lcd_puts("Question 2");
            cache = (long)data * 5000;
            v = cache / 1023;
            sprintf(string, "ADC[%d] = %dmv", index, v);
            lcd_gotoxy(0, 1);
            lcd_puts(string);
            delay_ms(1000);
        }
    }
    ADCSRA |= (1 << ADSC);
}

interrupt[TIM0_OVF] void timer0_ovf_isr(void)
{
    float data = 0;
    float duty_cycle = 0;
    long int cache = 0;
    data = read_adc(0);
    cache = (long)data * 5000;
    duty_cycle = (float)(((float)(cache / 1023)) / 5000);
    OCR0 = floor(255 * duty_cycle);
}
void init_q2()
{
    TCCR0 = (0 << WGM00) | (0 << COM01) | (0 << COM00) | (0 << WGM01) | (0 << CS02) | (0 << CS01) | (0 << CS00);
    TCNT0 = 0x00;
    OCR0 = 0x80;
    TCCR1A = (0 << COM1A1) | (0 << COM1A0) | (0 << COM1B1) | (0 << COM1B0) | (0 << WGM11) | (0 << WGM10);
    TCCR1B = (0 << ICNC1) | (0 << ICES1) | (0 << WGM13) | (0 << WGM12) | (0 << CS12) | (0 << CS11) | (0 << CS10);
    TCNT1H = 0x00;
    TCNT1L = 0x00;
    ICR1H = 0x00;
    ICR1L = 0x00;
    OCR1AH = 0x00;
    OCR1AL = 0x00;
    OCR1BH = 0x00;
    OCR1BL = 0x00;
    ASSR = 0 << AS2;
    TCCR2 = (0 << PWM2) | (0 << COM21) | (0 << COM20) | (0 << CTC2) | (0 << CS22) | (0 << CS21) | (0 << CS20);
    TCNT2 = 0x00;
    OCR2 = 0x00;
    TIMSK = (0 << OCIE2) | (0 << TOIE2) | (0 << TICIE1) | (0 << OCIE1A) | (0 << OCIE1B) | (0 << TOIE1) | (0 << OCIE0) | (0 << TOIE0);
    MCUCR = (0 << ISC11) | (0 << ISC10) | (0 << ISC01) | (0 << ISC00);
    MCUCSR = (0 << ISC2);
    UCSRB = (0 << RXCIE) | (0 << TXCIE) | (0 << UDRIE) | (0 << RXEN) | (0 << TXEN) | (0 << UCSZ2) | (0 << RXB8) | (0 << TXB8);
    ACSR = (1 << ACD) | (0 << ACBG) | (0 << ACO) | (0 << ACI) | (0 << ACIE) | (0 << ACIC) | (0 << ACIS1) | (0 << ACIS0);
    ADMUX = FIRST_ADC_INPUT | ADC_VREF_TYPE;
    ADCSRA = (1 << ADEN) | (1 << ADSC) | (1 << ADATE) | (0 << ADIF) | (1 << ADIE) | (0 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
    SFIOR = (0 << ADTS2) | (0 << ADTS1) | (0 << ADTS0);
    SPCR = (0 << SPIE) | (0 << SPE) | (0 << DORD) | (0 << MSTR) | (0 << CPOL) | (0 << CPHA) | (0 << SPR1) | (0 << SPR0);
    TWCR = (0 << TWEA) | (0 << TWSTA) | (0 << TWSTO) | (0 << TWEN) | (0 << TWIE);
    lcd_clear();
}

void init_q3()
{

    TCCR0 = (1 << WGM00) | (1 << COM01) | (0 << COM00) | (1 << WGM01) | (0 << CS02) | (0 << CS01) | (1 << CS00);
    TCNT0 = 0x00;
    OCR0 = 0x00;
    TIMSK = (0 << OCIE2) | (0 << TOIE2) | (0 << TICIE1) | (0 << OCIE1A) | (0 << OCIE1B) | (0 << TOIE1) | (0 << OCIE0) | (1 << TOIE0);
}