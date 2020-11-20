/*
 * Player.cpp
 *
 *  Created on: 19 lis 2020
 *      Author: Norbert
 */

#include "Utils.h"
#include "GameEngine.h"
#include "Player.h"

Player::Player( const Vector2i batSize, const int gameHeight,
        const bool leftSide, const bool isAI ) :
		m_bat( batSize.x, 0/*(gameHeight / batSize.y) / 2*/, batSize.x,
		        batSize.y ),
		m_isAI( isAI ), m_movingUp( false ), m_movingDown( false )
{
}

// Main interface
void Player::processInput( const uint8_t state )
{
	switch( state )
	{
	case Lbutton: // L button
	{
		m_movingDown = false;
		m_movingUp = true;
		break;
	}
	case Rbutton: // R button
	{
		m_movingDown = true;
		m_movingUp = false;
		break;
	}
	}
}
void Player::update( const float dt )
{
	if( m_movingUp )
	{
		m_bat.top -= dt;
	}
	else if( m_movingDown )
	{
		m_bat.top += dt;
	}
	m_movingDown = false;
	m_movingUp = false;
}
void Player::render( GameEngine* gameEngine )
{
	m_bat.render( gameEngine );
}
