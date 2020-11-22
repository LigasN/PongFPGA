/*
 * Ball.h
 *
 *  Created on: 21 lis 2020
 *      Author: Norbert
 */

#ifndef BALL_H
#define BALL_H

#include <stdint.h>
#include "Utils.h"
#include "Vector2i.h"
#include "Rectangle.h"

class GameEngine;

class Ball
{
public:
	Ball( int diameter, Vector2i gameSize ) :
			m_rect( gameSize.x / 2 - 6, gameSize.y / 2 - 4, diameter,
			        diameter ),
			m_gameSize( gameSize ), m_velocity { 1, -1 }
	{
	}

	// Main interface
	void update( )
	{
		static int updateDelayCounter = 0;
		if( updateDelayCounter > 50 )
		{
			updateDelayCounter = 0;

			m_rect.left += m_velocity.x;
			m_rect.top += m_velocity.y;
		}
		++updateDelayCounter;
	}

	void render( GameEngine* gameEngine )
	{
		m_rect.render( gameEngine );
	}

	const Rectangle* getRect( ) const
	{
		return &m_rect;
	}

	void handleCollision( const Vector2i intersection,
	        const uint8_t collisionObjectId )
	{
		if( (collisionObjectId & VERTICAL_BORDER) > 0 )
		{
			m_rect.left = m_gameSize.x / 2;
			m_velocity.x = -m_velocity.x;
			m_velocity.y = -m_velocity.y;
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

private:
	Rectangle m_rect;

	Vector2i m_gameSize;

	Vector2i m_velocity;
};

#endif // BALL_H
