/*
 * Game.cpp
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#include "Vector2i.h"
#include "Player.h"
#include "Utils.h"
#include "system.h"
#include "GameEngine.h"
#include <io.h>
#include <stdio.h>

GameEngine::GameEngine( ) :
		m_gameStarted( false ), m_net( WINDOW_WIDTH, WINDOW_HIGHT ),
		m_ball( 1, Vector2i { WINDOW_WIDTH, WINDOW_HIGHT } ),
		m_leftBorder( -2, -2, 2, WINDOW_HIGHT + 4 ),
		m_rightBorder( WINDOW_WIDTH, -2, 2, WINDOW_HIGHT + 4 ),
		m_topBorder( -2, -2, WINDOW_WIDTH + 4, 2 ),
		m_bottomBorder( -2, WINDOW_HIGHT, WINDOW_WIDTH + 4, 2 ),
		m_player( WINDOW_HIGHT, Vector2i { 1, 4 }, false, false ),
		m_AIPlayer( WINDOW_HIGHT, Vector2i { 1, 4 }, true, true )
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
		m_player.update( );
		m_AIPlayer.update( );
		m_ball.update( );

		// Checking collisions
		if( m_ball.getRect( )->checkCollisions( m_player.getRect( ) ) )
		{
			m_ball.handleCollision(
			        m_ball.getRect( )->getIntersection( m_player.getRect( ) ),
			        BAT );
		}
		if( m_ball.getRect( )->checkCollisions( m_AIPlayer.getRect( ) ) )
		{
			m_ball.handleCollision(
			        m_ball.getRect( )->getIntersection( m_AIPlayer.getRect( ) ),
			        BAT );
		}
		if( m_ball.getRect( )->checkCollisions( &m_leftBorder ) )
		{
			m_ball.handleCollision(
			        m_ball.getRect( )->getIntersection( &m_leftBorder ),
			        VERTICAL_BORDER );
			m_gameStarted = false;

		}
		else if( m_ball.getRect( )->checkCollisions( &m_rightBorder ) )
		{
			m_ball.handleCollision(
			        m_ball.getRect( )->getIntersection( &m_rightBorder ),
			        VERTICAL_BORDER );
			m_gameStarted = false;

		}
		if( m_ball.getRect( )->checkCollisions( &m_topBorder ) )
		{
			m_ball.handleCollision(
			        m_ball.getRect( )->getIntersection( &m_topBorder ),
			        HORIZONTAL_BORDER );

		}
		else if( m_ball.getRect( )->checkCollisions( &m_bottomBorder ) )
		{
			m_ball.handleCollision(
			        m_ball.getRect( )->getIntersection( &m_bottomBorder ),
			        HORIZONTAL_BORDER );

		}
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

