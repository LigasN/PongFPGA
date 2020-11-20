/*
 * Game.cpp
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#include "Vector2i.h"
#include "Utils.h"
#include "Rectangle.h"
#include "system.h"
#include "GameEngine.h"
#include <io.h>
#include <stdio.h>

GameEngine::GameEngine( ) :
		m_net( WINDOW_WIDTH / 2, 0, 1 + WINDOW_WIDTH % 2, WINDOW_HIGHT ), m_ball( 0, 0, 1, 1 ),
		m_player( Vector2i
			{ 1, 4 }, WINDOW_HIGHT ),
		m_ballMovingToRight( false ), m_ballMovingToLeft( false )
{
}

GameEngine::~GameEngine( )
{
}

// Main Interface
void GameEngine::processInput( const uint8_t state )
{
	m_player.processInput( ( int )state );

}

void GameEngine::update( const float dt )
{
	m_player.update( dt );
}

void GameEngine::render( )
{
	// 8- as far as data is sent byte by byte used in random places in this function

	// Render objects
	m_player.render( this );

	for( unsigned int address = 0; address < RAM_ADDRESS_AMOUNT; ++address )
	{
		IOWR_8DIRECT( VRAM_BASE, address, m_renderData[address] );
		m_renderData[address] = 0;
	}
}

// Engine methods
void GameEngine::addToRender( const int8_t data[RAM_ADDRESS_AMOUNT] )
{
	for( unsigned int i = 0; i < RAM_ADDRESS_AMOUNT; ++i )
	{
		m_renderData[i] |= data[i];
	}
}

