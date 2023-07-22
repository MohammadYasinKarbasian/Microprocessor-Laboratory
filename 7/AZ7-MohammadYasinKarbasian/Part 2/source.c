#include <header.h>

void q2()
{
    unsigned char string[10] = "";
    unsigned char gt ='';
    int dig = 0;
    puts("part 2 is running!\r");

    gt = getchar_nv();
    if (gt == '0')
    {
        dig = 0;
    }
    else if (gt == '1')
    {
        dig = 1;
    }
    else if (gt == '2')
    {
        dig = 2;
    }
    else if (gt == '3')
    {
        dig = 3;
    }
    else if (gt == '4')
    {
        dig = 4;
    }
    else if (gt == '5')
    {
        dig = 5;
    }
    else if (gt == '6')
    {
        dig = 6;
    }
    else if (gt == '7')
    {
        dig = 7;
    }
    else if (gt == '8')
    {
        dig = 8;
    }
    else if (gt == '9')
    {
        dig = 9;
    }
    else
    {
        dig = 11;
    }

    if (dig < 10)
    {
        puts("\rTx:");
        putchar(gt);
        sprintf(string, "\rRx: Data=%d and 10*Data=%d \r", dig, 10 * dig);

        puts(string);
        lcd_clear();
        sprintf(string, "Tx: %d", dig);
        lcd_puts(string);
        sprintf(string, "Rx: Data=%d and 10*Data=%d", dig, 10 * dig);
        lcd_gotoxy(0, 1);
        lcd_puts(string);
    }

    else if (gt == 'D')
    {
        lcd_clear();
        lcd_puts("LCD delete");
        puts("\rLCD delete\r");
    }

    else if (gt == 'H')
    {
        puts("\rThis is AZ7 of Microprocessor Lab at IUT\r");
        lcd_clear();
        lcd_puts("This is AZ7 of Microprocessor Lab at IUT");
    }

    else if (gt == 'E')
    {
        puts("\rRx: END of this part\r");
        lcd_clear();
        lcd_puts("Rx: END of this part");
        return;
    }
    else
    {
        puts("\rTx:");
        putchar(gt);
        puts("\rRx: input letter is ");
        putchar('\"');
        putchar(gt);
        putchar('\"');
        puts("\r");
        lcd_clear();
        sprintf(string, "Tx: %c", gt);
        lcd_puts(string);
        sprintf(string, "Rx: input letter is \"%c\" ", gt);
        lcd_gotoxy(0, 1);
        lcd_puts(string);
    }
    puts("\rPart 2 is ending!\r");
}

void q3()
{
    unsigned char string[100] = "";
    unsigned char gt ='';
    int counter = 0;
    int dig = 1;
    int index = 0;
    puts("part 3 is running!\r");
    gt = getchar_nv();
    putchar(gt);
    while (gt != '\r')
    {
        string[counter] = gt;
        gt = getchar_nv();
        putchar(gt);
        counter++;
    }
    lcd_clear();

    for (index = 2; string[index] != ')'; index++)
    {
        if (!((string[index] == '0') || (string[index] == '1') || (string[index] == '2') || (string[index] == '3') || (string[index] == '4') || (string[index] == '5') || (string[index] == '6') || (string[index] == '7') || (string[index] == '8') || (string[index] == '9')))
            dig = 0;
    }

    if (dig == 0)
    {
        puts("\rTx:");
        puts(string);
        putchar('\r');
        puts("\rFrame must be 5 integer\r");
        sprintf(string, "Tx: %d", dig);
        lcd_clear();
        lcd_puts(string);
        lcd_gotoxy(0, 1);
        lcd_puts("Frame must be 5 integer");
    }
    else if (counter != 9)
    {
        puts("\rTx:");
        puts(string);
        putchar('\r');
        puts("\rIncorrect frame size.\r");
        lcd_clear();
        lcd_puts("Tx:");
        lcd_puts(string);

        lcd_gotoxy(0, 1);
        lcd_puts("Incorrect frame size.");
    }
    else
    {
        puts("\rTx:");
        puts(string);
        putchar('\r');
        puts("\rThe frame is correct\r");
        lcd_clear();
        lcd_puts("Tx:");
        lcd_puts(string);
        lcd_gotoxy(0, 1);
        lcd_puts("The frame is correct");
    }
    puts("\rPart 3 is ending!");
    putchar('\r');
    // getchar_nv();
}

void init(void)
{
    float temp1 = 0;
    int temp2 = 0;
    DDRA = (0 << DDA7) | (0 << DDA6) | (0 << DDA5) | (0 << DDA4) | (0 << DDA3) | (0 << DDA2) | (0 << DDA1) | (0 << DDA0);
    PORTA = (0 << PORTA7) | (0 << PORTA6) | (0 << PORTA5) | (0 << PORTA4) | (0 << PORTA3) | (0 << PORTA2) | (0 << PORTA1) | (0 << PORTA0);
    DDRB = (0 << DDB7) | (0 << DDB6) | (0 << DDB5) | (0 << DDB4) | (0 << DDB3) | (0 << DDB2) | (0 << DDB1) | (0 << DDB0);
    PORTB = (0 << PORTB7) | (0 << PORTB6) | (0 << PORTB5) | (0 << PORTB4) | (0 << PORTB3) | (0 << PORTB2) | (0 << PORTB1) | (0 << PORTB0);
    DDRC = (1 << DDC7) | (1 << DDC6) | (1 << DDC5) | (1 << DDC4) | (1 << DDC3) | (1 << DDC2) | (1 << DDC1) | (1 << DDC0);
    PORTC = (0 << PORTC7) | (0 << PORTC6) | (0 << PORTC5) | (0 << PORTC4) | (0 << PORTC3) | (0 << PORTC2) | (0 << PORTC1) | (0 << PORTC0);
    DDRD = (0 << DDD7) | (0 << DDD6) | (0 << DDD5) | (0 << DDD4) | (0 << DDD3) | (0 << DDD2) | (0 << DDD1) | (0 << DDD0);
    PORTD = (0 << PORTD7) | (0 << PORTD6) | (0 << PORTD5) | (0 << PORTD4) | (0 << PORTD3) | (0 << PORTD2) | (0 << PORTD1) | (0 << PORTD0);
    TCCR0 = (0 << WGM00) | (0 << COM01) | (0 << COM00) | (0 << WGM01) | (0 << CS02) | (0 << CS01) | (0 << CS00);
    TCNT0 = 0x00;
    OCR0 = 0x00;
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

    ACSR = (1 << ACD) | (0 << ACBG) | (0 << ACO) | (0 << ACI) | (0 << ACIE) | (0 << ACIC) | (0 << ACIS1) | (0 << ACIS0);
    SFIOR = (0 << ACME);
    ADCSRA = (0 << ADEN) | (0 << ADSC) | (0 << ADATE) | (0 << ADIF) | (0 << ADIE) | (0 << ADPS2) | (0 << ADPS1) | (0 << ADPS0);
    SPCR = (0 << SPIE) | (0 << SPE) | (0 << DORD) | (0 << MSTR) | (0 << CPOL) | (0 << CPHA) | (0 << SPR1) | (0 << SPR0);
    TWCR = (0 << TWEA) | (0 << TWSTA) | (0 << TWSTO) | (0 << TWEN) | (0 << TWIE);
    lcd_init(16);

    UCSRA = (0 << RXC) | (0 << TXC) | (0 << UDRE) | (0 << FE) | (0 << DOR) | (0 << UPE) | (0 << U2X) | (0 << MPCM);
    UCSRB = (1 << RXCIE) | (1 << TXCIE) | (0 << UDRIE) | (1 << RXEN) | (1 << TXEN) | (0 << UCSZ2) | (0 << RXB8) | (0 << TXB8);
    UCSRC = (1 << URSEL) | (0 << UMSEL) | (0 << UPM1) | (0 << UPM0) | (0 << USBS) | (1 << UCSZ1) | (1 << UCSZ0) | (0 << UCPOL);

    temp1 = ((8 * 1000000) / (16 * 9600)) - 1;
    temp2 = (int)temp1;

    if (temp2 < 0xFF)
    {
        UBRRL = temp2;
    }
    else
    {
        UBRRL = temp2 % 0xFF;
        UBRRH = temp2 / 0xFF;
    }
#asm("sei")
}