/*
 * GfxEngine.cpp
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#include "GfxEngine.h"
#include "GameInterface.h"

#include "system.h"
#include <io.h>

#include <stdlib.h>

namespace gfx
{

GfxEngine::GfxEngine( IGame* game, const math::Vector2i resolution ) :
		m_rectanglesSize( 0 ), m_game( game ), m_resolution( resolution )
{
}
GfxEngine::~GfxEngine( )
{
	if( m_rectangles )
		free (m_rectangles);
}

// Main Interface
void GfxEngine::processInput( const uint8_t state )
{
	switch( state )
	{
	case 0b101:
	{
		m_game->processInput( RightArrow );
		break;
	}
	case 0b011:
	{
		m_game->processInput( LeftArrow );
		break;
	}
	case 0b110:
	{
		m_game->processInput( Enter );
		break;
	}
	}
}
void GfxEngine::update( const int dt )
{
	m_game->update( dt );
}
void GfxEngine::render( )
{
	m_game->render( );
	refreshRAM( );
}

// Public functions
void GfxEngine::bindRectangle( const Rectangle* rect )
{
	++m_rectanglesSize;

	m_rectangles[m_rectanglesSize - 1] = rect;
}

// Private functions
void GfxEngine::refreshRAM( )
{
	// 8- as far as data is sent byte by byte used in random places in this function

	///Ram size
	const int RAMSize = m_resolution.x * m_resolution.y;

	/// One byte data
	uint8_t data = 0;

	/// Actual needed pos of pixel
	math::Vector2i pos;

//	for( uint8_t address = 0; address < RAMSize / 8; ++address )
//	{
//		for( uint8_t bit = 0; bit < 8; ++bit )
//		{
//			for( int i = 0; i < m_rectanglesSize; ++i )
//			{
//				pos.x = (address * 8 + bit) % m_resolution.x;
//				pos.y = (address * 8 + bit) / m_resolution.x;
//				if( m_rectangles[i].leftTopPoint.x >= address % 4 * 8 + bit )
//					data |= 1 << bit;
//			}
//		}
//		IOWR_8DIRECT( VRAM_BASE, address, data );
//	}
//------------------------------------

	for( uint8_t pixelNum = 0; pixelNum < RAMSize; ++pixelNum )
	{
		for( int i = 0; i < m_rectanglesSize; ++i )
		{
			pos.x = pixelNum % m_resolution.x;
			pos.y = pixelNum / m_resolution.x;
			if( m_rectangles[i]->getLeftTopPoint( ).x >= pos.x
			        && m_rectangles[i]->getRightBottomPoint( ).x < pos.x
			        && m_rectangles[i]->getLeftTopPoint( ).y >= pos.y
			        && m_rectangles[i]->getRightBottomPoint( ).y < pos.y )
			{
				data |= 1 << pixelNum % 8;
			}
		}
		// Last bit then save ready byte to RAM
		if( pixelNum % 8 == 7 )
			IOWR_8DIRECT( VRAM_BASE, pixelNum / 8, data );
	}
}
}
