#include <io.h>
#include <stdint.h>

#include "system.h"
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"

#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_timer.h"

/// Position of square on screen
volatile int16_t pos = 0;

void SetPosOnRAM( )
{
	// Setting pos
	uint8_t data = 0;
	uint8_t address = pos / 8;
	data |= 1 << (pos % 8);
	IOWR_8DIRECT( VRAM_BASE, address, data );

	// Clearing other parts of RAM
	for( uint8_t i = 0; i < 96; ++i )
	{
		if( i != address )
		{
			IOWR_8DIRECT( VRAM_BASE, i, 0 );
		}
	}
}

/// Input from key interrupts
void processInput( uint8_t state )
{
	if( state == 0b101 ) // right button
	{
		++pos;
		if( pos > 767 )
		{
			pos = 0;
		}
	}
	else if( state == 0b011 ) // left button
	{
		--pos;
		if( pos < 0 )
		{
			pos = 767;
		}
	}
	else if( state == 0b110 ) // reset button
	{
		pos = 0;
	}
	SetPosOnRAM( );
}

/// Keys interrupts
void swTimerInterrupt( void* context )
{
	// Clear interrupt record
	IOWR_ALTERA_AVALON_TIMER_STATUS( SW_TIMER_BASE, 0 );

	/// Count time of pushing button
	static uint8_t bounceMsCounter = 0;

	/// Buttons state
	uint8_t state = IORD_ALTERA_AVALON_PIO_DATA( SW_BASE );

	if( state != 0b111 )
	{
		if( bounceMsCounter == 50 )
		{
			processInput( state );
		}
		++bounceMsCounter;
	}
	else
	{
		bounceMsCounter = 0;
	}
}

int main( )
{
	// Timer initialisation
	alt_ic_isr_register( SW_TIMER_IRQ_INTERRUPT_CONTROLLER_ID, SW_TIMER_IRQ, swTimerInterrupt, NULL,
	        NULL );

	IOWR_ALTERA_AVALON_TIMER_CONTROL( SW_TIMER_BASE,
	        ALTERA_AVALON_TIMER_CONTROL_START_MSK | ALTERA_AVALON_TIMER_CONTROL_CONT_MSK
	                | ALTERA_AVALON_TIMER_CONTROL_ITO_MSK );

	// Switch initialisation
	alt_ic_isr_register( SW_IRQ_INTERRUPT_CONTROLLER_ID, SW_IRQ, NULL, NULL, NULL );
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK( SW_BASE, 0b111 );

	while( 1 )
	{
	}

	return 0;
}
