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
		m_borders( 0, 0, WINDOW_WIDTH, WINDOW_HIGHT ),
		m_player( Vector2i { 1, 4 }, false ),
		m_AIPlayer( Vector2i { 1, 4 }, true, true )
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
		m_gameStarted = true;
	}
	m_player.processInput( ( int )state );

}

void GameEngine::update( const float dt )
{
	if( m_gameStarted )
	{
		m_player.update( dt );
		m_AIPlayer.update( dt );
		m_ball.update( dt );

		// Checking collisions
		if( m_ball.getRect( )->checkCollisions( m_player.getRect( ) ) )
		{
			m_ball.handleCollision(
			        m_ball.getRect( )->getIntersection( m_player.getRect( ) ) );
		}
		if( m_ball.getRect( )->checkCollisions( &m_borders ) )
		{
			m_ball.handleCollision(
			        m_ball.getRect( )->getIntersection( &m_borders ) );
		}
		if( m_player.getRect( )->checkCollisions( &m_borders ) )
		{
			m_player.handleCollision(
			        m_player.getRect( )->getIntersection( &m_borders ) );
		}
		if( m_AIPlayer.getRect( )->checkCollisions( &m_borders ) )
		{
			m_AIPlayer.handleCollision(
			        m_AIPlayer.getRect( )->getIntersection( &m_borders ) );
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
	//m_ball.render( this );

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

