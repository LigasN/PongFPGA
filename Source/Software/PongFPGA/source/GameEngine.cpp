/*
 * Game.cpp
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#include "Utils/Vector2i.h"
#include "GameObjects/Player.h"
#include "Utils/Utils.h"
#include "GameEngine.h"
#include "system.h"
#include <io.h>
#include <stdio.h>

GameEngine::GameEngine( ) :
		m_gameStarted( false ), m_net( WINDOW_WIDTH, WINDOW_HIGHT ),
		m_ball( 1, Vector2i { WINDOW_WIDTH, WINDOW_HIGHT }, 30 ),
		m_leftBorder( -2, -2, 2, WINDOW_HIGHT + 4 ),
		m_rightBorder( WINDOW_WIDTH, -2, 2, WINDOW_HIGHT + 4 ),
		m_topBorder( -2, -2, WINDOW_WIDTH + 4, 2 ),
		m_bottomBorder( -2, WINDOW_HIGHT, WINDOW_WIDTH + 4, 2 ),
		m_player( WINDOW_HIGHT, Vector2i { 1, 4 }, false, NULL ),
		m_AIPlayer( WINDOW_HIGHT, Vector2i { 1, 4 }, true, m_ball.getRect( ) ),
		m_leftScore( 0 ), m_rightScore( 0 ), m_leftScoreDisplay( 10, 2 ),
		m_rightScoreDisplay( 19, 2 )
{
}

GameEngine::~GameEngine( )
{
}

// Main Interface
void GameEngine::processInput( const uint8_t state )
{
	if( state == ENTER )
	{
		m_gameStarted = !m_gameStarted;
	}

	if( m_gameStarted )
	{
		m_player.processInput( ( int )state );
	}
}

void GameEngine::update( )
{
	if( m_gameStarted )
	{
		m_ball.update( ); // after all because of collisions checking
		m_player.update( );
		m_AIPlayer.update( );

		// Checking collisions
		// Players
		if( m_ball.checkCollision( m_player.getRect( ) ) )
		{
			m_ball.handleCollision( m_player.getRect( ), BAT );
		}
		if( m_ball.checkCollision( m_AIPlayer.getRect( ) ) )
		{
			m_ball.handleCollision( m_AIPlayer.getRect( ), BAT );
		}

		// Walls
		if( m_ball.checkCollision( &m_leftBorder ) )
		{
			m_ball.handleCollision( &m_leftBorder, VERTICAL_BORDER );
			m_gameStarted = false;

			++m_rightScore;

		}
		else if( m_ball.checkCollision( &m_rightBorder ) )
		{
			m_ball.handleCollision( &m_rightBorder, VERTICAL_BORDER );
			m_gameStarted = false;

			++m_leftScore;
		}
		if( m_ball.checkCollision( &m_topBorder ) )
		{
			m_ball.handleCollision( &m_topBorder, HORIZONTAL_BORDER );

		}
		else if( m_ball.checkCollision( &m_bottomBorder ) )
		{
			m_ball.handleCollision( &m_bottomBorder, HORIZONTAL_BORDER );

		}

		// Wins handling
		if( m_rightScore > 9 || m_leftScore > 9 )
		{
			m_rightScore = 0;
			m_leftScore = 0;
		}

		// Scores displays
		m_leftScoreDisplay.setCharacter( m_leftScore );
		m_rightScoreDisplay.setCharacter( m_rightScore );
	}
}

void GameEngine::render( )
{
	// 8- as far as data is sent byte by byte used in random places in this function

	// Render objects
	m_net.render( this );
	m_player.render( this );
	m_AIPlayer.render( this );
	m_ball.render( this );

	// Render texts
	m_leftScoreDisplay.render( this );
	m_rightScoreDisplay.render( this );

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

