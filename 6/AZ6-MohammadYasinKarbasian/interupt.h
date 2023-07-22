#ifndef _interupt_INCLUDED_
#define _interupt_INCLUDED_

interrupt[TIM0_OVF] void timer0_ovf_isr(void);
interrupt[ADC_INT] void adc_isr(void);
void init_q2();
void init_q3();

#endif
