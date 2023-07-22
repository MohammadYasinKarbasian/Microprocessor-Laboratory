#ifndef _header_INCLUDED_
#define _header_INCLUDED_

#include <mega16.h>
#include <stdio.h>
#include <delay.h>
#include <alcd.h>
#include <math.h>
#include <polling.h>
#include <interupt.h>

#define FIRST_ADC_INPUT 0
#define LAST_ADC_INPUT 7
#define ADC_VREF_TYPE ((0 << REFS1) | (1 << REFS0) | (0 << ADLAR))
extern unsigned int previous[8];

#endif
