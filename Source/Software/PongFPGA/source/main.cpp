#include "GfxEngine/GfxEngine.h"
#include "Game/Game.h"

#include <io.h>
#include <stdint.h>

#include "system.h"
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"

#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_timer.h"

/// Unfortunately global pointer to GfxEngine since I have no
/// idea how to solve interrupts without it
gfx::GfxEngine* gGfxEngine;

/// Keys interrupts
static void swTimerInterrupt( void* context )
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
			gGfxEngine->processInput( state );
		}
		++bounceMsCounter;
	}
	else
	{
		bounceMsCounter = 0;
	}
}

void initInterrupts( )
{
	// Timer initialization
	alt_ic_isr_register( SW_TIMER_IRQ_INTERRUPT_CONTROLLER_ID, SW_TIMER_IRQ, swTimerInterrupt, NULL,
	        NULL );

	IOWR_ALTERA_AVALON_TIMER_CONTROL( SW_TIMER_BASE,
	        ALTERA_AVALON_TIMER_CONTROL_START_MSK | ALTERA_AVALON_TIMER_CONTROL_CONT_MSK
	                | ALTERA_AVALON_TIMER_CONTROL_ITO_MSK );

	// Switch initialization
	alt_ic_isr_register( SW_IRQ_INTERRUPT_CONTROLLER_ID, SW_IRQ, NULL, NULL, NULL );
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK( SW_BASE, 0b111 );
}

int main( )
{
	int deltaTime = 1;

	gfx::IGame* game = new game::Game( );
	gGfxEngine = new gfx::GfxEngine( game, math::Vector2i( 32, 20 ) );

	game->init( gGfxEngine );

	while( 1 )
	{
		gGfxEngine->update( deltaTime );
		gGfxEngine->render( );
	}
	delete gGfxEngine;

	return 0;
}
