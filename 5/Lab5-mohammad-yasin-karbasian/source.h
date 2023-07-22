#ifndef _source_INCLUDED_
#define _source_INCLUDED_

interrupt [TIM1_OVF] void timer1_ovf_isr(void);

interrupt [TIM1_CAPT] void timer1_capt_isr(void);

interrupt [TIM2_OVF] void timer2_ovf_isr(void);

void q2(char duty_cycle);

void q4();

void changeB(char a,char b , char c, char d);

void q5();

void q6();

void init();

#endif