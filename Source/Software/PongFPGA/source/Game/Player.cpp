/*
 * Player.cpp
 *
 *  Created on: 19 lis 2020
 *      Author: Norbert
 */

#include "Utils.h"
#include "GameEngine.h"
#include "Player.h"

Player::Player( const Vector2i batSize, const bool leftSide, const bool isAI ) :
		m_rect( leftSide ? batSize.x : WINDOW_WIDTH - 2 * batSize.x,
		        (WINDOW_HIGHT / batSize.y) / 2, batSize.x, batSize.y ),
		m_isAI( isAI ), m_movingUp( false ), m_movingDown( false ),
		m_leftSide( leftSide )
{
}

// Main interface
void Player::processInput( const uint8_t state )
{
	switch( state )
	{
	case LBUTTON: // L button
	{
		m_movingUp = m_leftSide ? true : false;
		m_movingDown = m_leftSide ? false : true;
		break;
	}
	case RBUTTON: // R button
	{
		m_movingUp = m_leftSide ? false : true;
		m_movingDown = m_leftSide ? true : false;
		break;
	}
	}
}
void Player::update( const float dt )
{
	if( m_movingUp )
	{
		if( m_velocity <= 0 )
		{
			m_velocity -= dt;
		}
		else
		{
			m_velocity = 0;
		}
	}
	else if( m_movingDown )
	{
		if( m_velocity >= 0 )
		{
			m_velocity += dt;
		}
		else
		{
			m_velocity = 0;
		}
	}
	m_rect.top += m_velocity;
	m_movingDown = false;
	m_movingUp = false;
}
void Player::render( GameEngine* gameEngine )
{
	m_rect.render( gameEngine );
}
const Rectangle* Player::getRect( ) const
{
	return &m_rect;
}
void Player::handleCollision( const Vector2i rect )
{
	if( m_velocity > 0 )
	{
		m_rect.top -= rect.y;
	}
	else
	{
		m_rect.top += rect.y;
	}
	m_velocity = 0;
}
