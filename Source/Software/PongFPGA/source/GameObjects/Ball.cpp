/*
 * Ball.cpp
 *
 *  Created on: 24 lis 2020
 *      Author: Norbert
 */

#include "Ball.h"
#include "../Utils/MathUtils.h"

Ball::Ball( int diameter, Vector2i gameSize, int updateDelay ) :
		m_rect( gameSize.x / 2 - 3, gameSize.y / 2, diameter, diameter ),
		m_gameSize( gameSize ), m_velocity { 1, -1 },
		m_updateDelay( updateDelay ), m_initUpdateDelayValue( updateDelay )
{
}

// Main interface
void Ball::update( )
{
	static int updateDelayCounter = 0;
	if( updateDelayCounter > m_updateDelay )
	{
		updateDelayCounter = 0;

		m_rect.left += m_velocity.x;
		m_rect.top += m_velocity.y;
	}
	++updateDelayCounter;
}

void Ball::render( GameEngine* gameEngine )
{
	m_rect.render( gameEngine );
}

const Rectangle* Ball::getRect( ) const
{
	return &m_rect;
}

void Ball::handleCollision( const Rectangle* objectRect,
        const uint8_t collisionObjectId )
{
	Vector2i intersection = getIntersection( objectRect );

	// During collision with anything ball decrease its updateDelay
	if( m_updateDelay > 1 )
	{
		--m_updateDelay;
	}

	if( (collisionObjectId & VERTICAL_BORDER) > 0 )
	{
		m_rect.left = m_gameSize.x / 2;
		m_velocity.x = -m_velocity.x;
		m_velocity.y = -m_velocity.y;
		m_updateDelay = m_initUpdateDelayValue;
	}
	else
	{
		m_rect.left -= m_velocity.x > 0 ? intersection.x : -intersection.x;
		m_rect.top -= m_velocity.y > 0 ? intersection.y : -intersection.y;

		// Not so smart but on this resolution only one resolution
		if( (collisionObjectId & HORIZONTAL_BORDER) > 0 )
		{
			m_velocity.y = -m_velocity.y;
		}
		else if( (collisionObjectId & BAT) > 0 )
		{
			m_velocity.x = -m_velocity.x;
		}

		// Additional position update after collision to not wait until next
		// update. Visually ball would stand in the same position during two
		// Ball frame updates
		m_rect.left += m_velocity.x;
		m_rect.top += m_velocity.y;
	}

}

bool Ball::checkCollision( const Rectangle* otherRect ) const
{
	return (m_rect.left < otherRect->left + otherRect->width
	        && m_rect.left + m_rect.width > otherRect->left)
	        && (m_rect.top < otherRect->top + otherRect->hight
	                && m_rect.top + m_rect.hight > otherRect->top);
}

const Vector2i Ball::getIntersection( const Rectangle* otherRect ) const
{
	return Vector2i { MIN( m_rect.left + m_rect.width,
	        otherRect->left + otherRect->width )
	                          - MAX( m_rect.left, otherRect->left ),
	                  MIN( m_rect.top + m_rect.hight,
	                          otherRect->top + otherRect->hight )
	                          - MAX( m_rect.top, otherRect->top ) };
}

