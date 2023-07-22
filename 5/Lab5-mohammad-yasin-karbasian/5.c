#include <headers.h>

char clockwies=1;
char  turn=1;
char OverFlow=0;
unsigned int old=0;
unsigned int  new=0;
unsigned int  rpm=0;
unsigned int  display_rpm=0;
unsigned int counter=0;
unsigned int  speed=0;


void main(void)
{
init();

clockwies=1;
turn=1;
OverFlow=0;
old=0;
new=0;
rpm=0;
display_rpm=0;
counter=0;
speed=0;

q2(10);
delay_ms(1000);

q2(30);
delay_ms(1000);

q2(50);
delay_ms(1000);

q2(70);
delay_ms(1000);

q2(90);
delay_ms(1000);

q4();

while (1)
      {

      }
}
