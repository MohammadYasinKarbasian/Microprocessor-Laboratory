
flash unsigned char new_image[]=
{
/* Image width: 128 pixels */
0x80, 0x00,
/* Image height: 63 pixels */
0x3F, 0x00,
#ifndef _GLCD_DATA_BYTEY_
/* Image data for monochrome displays organized
   as horizontal rows of bytes */
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x70, 0x00, 0x80, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x04, 0x00, 0x50, 0x00, 0xC0, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x01, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x40, 0x03, 
0x80, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x06, 0x00, 0x44, 0x00, 0x40, 0x02, 
0x80, 0x00, 0x00, 0x06, 0x00, 0x00, 0x0C, 0x00, 
0x00, 0x00, 0x03, 0x00, 0x84, 0x00, 0x20, 0x02, 
0x80, 0x00, 0x00, 0x02, 0x02, 0x00, 0x18, 0x00, 
0x00, 0x00, 0x01, 0x00, 0x80, 0x00, 0x20, 0x02, 
0x80, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x01, 0x00, 0x04, 0x00, 0x30, 0x06, 
0x80, 0x01, 0x00, 0x01, 0x02, 0x00, 0x50, 0x00, 
0x00, 0x00, 0x01, 0x00, 0x06, 0x01, 0x18, 0x04, 
0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 
0x00, 0x80, 0x00, 0x00, 0x02, 0x01, 0x08, 0x00, 
0x00, 0x01, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x80, 0x00, 0x00, 0x02, 0x01, 0x08, 0x04, 
0x00, 0x01, 0x40, 0x00, 0x02, 0x00, 0x40, 0x00, 
0x00, 0x80, 0x00, 0x00, 0x02, 0x00, 0x0C, 0x04, 
0x00, 0x06, 0x40, 0x00, 0x00, 0x80, 0x42, 0x00, 
0x00, 0x40, 0x00, 0x00, 0x01, 0x01, 0x00, 0x04, 
0x00, 0x04, 0x00, 0x00, 0x02, 0x80, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x00, 0x04, 
0x00, 0x04, 0x20, 0x00, 0x02, 0x40, 0x00, 0x00, 
0x00, 0x40, 0x00, 0x80, 0x00, 0x02, 0x04, 0x00, 
0x00, 0x04, 0x18, 0x00, 0x00, 0x20, 0x40, 0x00, 
0x00, 0x40, 0x00, 0xC0, 0x00, 0x02, 0x02, 0x00, 
0x00, 0x04, 0x08, 0x00, 0x02, 0x10, 0x40, 0x00, 
0x00, 0x40, 0x00, 0x00, 0x00, 0x04, 0x00, 0x08, 
0x00, 0x04, 0x00, 0x00, 0x00, 0x10, 0x40, 0x00, 
0x00, 0x40, 0x00, 0x40, 0x00, 0x04, 0x01, 0x08, 
0x00, 0x08, 0x00, 0x00, 0x02, 0x14, 0x40, 0x00, 
0x00, 0x40, 0x00, 0x20, 0x00, 0x00, 0x00, 0x10, 
0x00, 0x18, 0x01, 0x00, 0x02, 0x04, 0x40, 0x00, 
0x00, 0x40, 0x00, 0x20, 0x00, 0x84, 0x00, 0x10, 
0x00, 0x90, 0x01, 0x00, 0x02, 0x02, 0x40, 0x00, 
0x00, 0x40, 0x00, 0x30, 0x00, 0x08, 0x00, 0x10, 
0x00, 0x90, 0x00, 0x00, 0x81, 0x03, 0x40, 0x00, 
0x00, 0x40, 0x00, 0x10, 0x00, 0x88, 0x00, 0x10, 
0x00, 0x10, 0x00, 0x00, 0x40, 0x00, 0x40, 0x00, 
0x00, 0x20, 0x00, 0x18, 0x00, 0x88, 0x00, 0x10, 
0x00, 0x70, 0x00, 0x80, 0x20, 0x00, 0x40, 0x00, 
0x00, 0x20, 0x00, 0x08, 0x00, 0x48, 0x00, 0x10, 
0x00, 0x30, 0x00, 0x80, 0x20, 0x00, 0x40, 0x00, 
0x00, 0x20, 0x00, 0x08, 0x00, 0x18, 0x00, 0x10, 
0x00, 0x30, 0x00, 0x80, 0x18, 0x00, 0x40, 0x00, 
0x00, 0x20, 0x00, 0x08, 0x00, 0x20, 0x00, 0x10, 
0x00, 0x50, 0x00, 0x00, 0x08, 0x00, 0x40, 0x00, 
0x00, 0x00, 0x00, 0x08, 0x00, 0x30, 0x00, 0x10, 
0x00, 0x40, 0x00, 0x80, 0x08, 0x00, 0x40, 0x00, 
0x00, 0x20, 0x00, 0x0C, 0x00, 0x00, 0x00, 0x10, 
0x00, 0x40, 0x00, 0x80, 0x06, 0x00, 0x00, 0x00, 
0x00, 0x20, 0x00, 0x04, 0x00, 0x00, 0x00, 0x10, 
0x00, 0x40, 0x00, 0x80, 0x02, 0x00, 0x80, 0x00, 
0x00, 0x20, 0x00, 0x04, 0x00, 0x00, 0x00, 0x10, 
0x00, 0x40, 0x00, 0x00, 0x02, 0x00, 0x80, 0x00, 
0x00, 0x20, 0x00, 0x04, 0x00, 0x00, 0x00, 0x20, 
0x00, 0x40, 0x00, 0x00, 0x06, 0x00, 0x80, 0x00, 
0x00, 0x20, 0x00, 0x02, 0x00, 0x00, 0x00, 0x20, 
0x00, 0x40, 0x00, 0x40, 0x0C, 0x00, 0x80, 0x00, 
0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 
0x00, 0x00, 0x00, 0x40, 0x70, 0x00, 0x80, 0x00, 
0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x20, 
0x00, 0x40, 0x00, 0x40, 0xC0, 0x00, 0x80, 0x00, 
0x00, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x20, 
0x00, 0x40, 0x00, 0x40, 0x80, 0x02, 0x80, 0x00, 
0x00, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x40, 
0x00, 0x40, 0x00, 0x40, 0x00, 0x06, 0x00, 0x00, 
0x00, 0x20, 0x00, 0x01, 0x00, 0x00, 0x00, 0x40, 
0x00, 0x40, 0x00, 0x40, 0x00, 0x08, 0x80, 0x00, 
0x00, 0x20, 0x80, 0x01, 0x00, 0x00, 0x00, 0xC0, 
0x00, 0x40, 0x00, 0x40, 0x00, 0x50, 0x80, 0x00, 
0x00, 0x20, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x40, 0x00, 0x40, 0x00, 0x80, 0x80, 0x00, 
0x00, 0x20, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x40, 0x00, 0x20, 0x00, 0x80, 0x83, 0x00, 
0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x40, 0x00, 0x20, 0x00, 0x00, 0xC2, 0x00, 
0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x40, 0x00, 0x20, 0x00, 0x00, 0x40, 0x00, 
0x00, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x60, 0x00, 
0x00, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x00, 
0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0x00, 
0x00, 0x00, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0E, 0x00, 
0x00, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
#else
/* Image data for monochrome displays organized
   as rows of vertical bytes */
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x80, 0x00, 0x10, 0x00, 0x08, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0xC0, 0x40, 0xC0, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xC0, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 
0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 
0x3C, 0x06, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0xE0, 0x36, 0x00, 0x01, 0x00, 0x02, 0x0C, 
0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0xE0, 0x30, 0x1C, 0x03, 0x00, 
0x01, 0x1F, 0xB0, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 
0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x40, 
0x10, 0x0E, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x94, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x02, 0x06, 0x14, 0x00, 0xB0, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFA, 0x01, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x50, 0x18, 
0x06, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x02, 0x1C, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x40, 0x10, 0x09, 0x01, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x07, 0x60, 0x80, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x01, 0x3F, 0xC0, 0x80, 0x00, 0x00, 0x00, 
0x80, 0x00, 0x00, 0x18, 0x08, 0x04, 0x01, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0xD6, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0xC0, 0x00, 0x70, 0x08, 0x04, 0x03, 
0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0xF9, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x78, 0x07, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0xF8, 0x0E, 0x03, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x01, 0x3E, 0xA0, 0xC0, 0x10, 0x0D, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x7F, 0x38, 0xC8, 0x03, 
0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xB8, 
0x02, 0x01, 0x00, 0xE0, 0x20, 0x18, 0x04, 0x02, 
0x02, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xBF, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0xC0, 0x10, 0x0F, 0x01, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x07, 0xF8, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xDF, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x03, 
0x00, 0x0F, 0x19, 0x10, 0x20, 0x20, 0x60, 0xC0, 
0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFE, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0xC0, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x10, 0x0C, 
0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0x04, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x0F, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x01, 0x01, 0x02, 0x04, 0x00, 0x04, 0x18, 
0x10, 0x30, 0x00, 0x00, 0x00, 0x80, 0xE0, 0x3E, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 
0x04, 0x04, 0x08, 0x10, 0x10, 0x18, 0x08, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x04, 0x08, 0x08, 0x0E, 0x03, 0x01, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
#endif
};

