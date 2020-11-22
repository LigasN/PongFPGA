/*
 * Ball.h
 *
 *  Created on: 21 lis 2020
 *      Author: Norbert
 */

#ifndef BALL_H
#define BALL_H

#include <stdint.h>
#include "Vector2i.h"
#include "Rectangle.h"

class GameEngine;

class Ball
{
public:
	Ball( int diameter, Vector2i gameSize ) :
			m_rect( gameSize.x / 2 - 6, gameSize.y / 2 - 4, diameter,
			        diameter ),
			m_gameSize( gameSize ), m_velocity { 1, 1 }
	{
	}

	// Main interface
	void update( )
	{
		m_rect.left += m_velocity.x;
		m_rect.top += m_velocity.y;
	}

	void render( GameEngine* gameEngine )
	{
		m_rect.render( gameEngine );
	}

	const Rectangle* getRect( ) const
	{
		return &m_rect;
	}

	void handleCollision( const Vector2i intersection )
	{
		if( intersection.x > 0 )
		{
			m_rect.left = m_gameSize.x / 2;
			m_rect.top = m_gameSize.y / 2;
			m_velocity.x = -m_velocity.x;
			m_velocity.y = -m_velocity.y;
		}
		else
		{
			m_velocity.y = -m_velocity.y;
		}

	}

private:
	Rectangle m_rect;

	Vector2i m_gameSize;

	Vector2i m_velocity;
};

#endif // BALL_H
