#include <header.h>
unsigned int previous[8] = {0};
void main(void)
{
      init();

      // question 1
      init_q1();
      q1();
      delay_ms(1000);

      // question 2
      init_q2();

      // question 3
      init_q3();

#asm("sei")

      while (1)
      {
      }
}