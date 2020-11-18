/*
 * Game.cpp
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#include "Game.h"
#include "system.h"
#include <io.h>

Game::Game( const uint16_t width, const uint16_t hight ) :
		m_width( width ), m_hight( hight ), m_ballMovingToRight( false ),
		m_ballMovingToLeft( false )
{
	m_ball =
	{	0, 0, 1, 1};
}

Game::~Game( )
{
}

// Main Interface
void Game::processInput( const uint8_t state )
{
	switch( state )
	{
	case 0b101: // L button
	{
		m_ballMovingToRight = false;
		m_ballMovingToLeft = true;
		break;
	}
	case 0b011: // R button
	{
		m_ballMovingToRight = true;
		m_ballMovingToLeft = false;
		break;
	}
	case 0b110: // enter
	{
		m_ballMovingToRight = false;
		m_ballMovingToLeft = false;
		break;
	}
	}
	update( 1 );
}

void Game::update( const float dt )
{
	if( m_ballMovingToRight )
	{
		m_ball.left += dt;
		m_ball.top += dt;
	}
	else if( m_ballMovingToLeft )
	{
		m_ball.left -= dt;
		m_ball.top -= dt;
	}

	//m_ballMovingToRight = false;
	//m_ballMovingToLeft = false;
}

void Game::render( )
{
	// 8- as far as data is sent byte by byte used in random places in this function

	///Ram size
	const int RAMSize = m_width * m_hight;

	/// One byte data
	uint8_t address = 0;
	uint8_t data = 0;

	/// Actual needed pos of pixel
	int px_x = 0;
	int px_y = 0;

	for( int pixelNum = 0; pixelNum < RAMSize; ++pixelNum )
	{
		for( int i = 0; i < 1; ++i ) // 1 as rectangles in game (now without special variable)
		{
			px_x = pixelNum % m_width;
			px_y = pixelNum / m_width;
			if( m_ball.left <= px_x && m_ball.left + m_ball.width > px_x && m_ball.top <= px_y
			        && m_ball.top + m_ball.hight > px_y )
			{
				data |= 1 << pixelNum % 8;
			}
		}
		// Last bit then save ready byte to RAM
		if( pixelNum % 8 == 7 )
		{
			address = pixelNum / 8;
			IOWR_8DIRECT( VRAM_BASE, address, data );
			data = 0;
		}
	}
}

