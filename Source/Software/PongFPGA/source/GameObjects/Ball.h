/*
 * Ball.h
 *
 *  Created on: 21 lis 2020
 *      Author: Norbert
 */

#ifndef BALL_H
#define BALL_H

#include "../Utils/Utils.h"
#include "../Utils/Vector2i.h"
#include "../Utils/Rectangle.h"
#include <stdint.h>

class GameEngine;

class Ball
{
public:
	Ball( int diameter, Vector2i gameSize );

	// Main interface
	void update( );
	void render( GameEngine* gameEngine );

	bool checkCollision( const Rectangle* otherRect ) const;
	void handleCollision( const Rectangle* objectRect,
	        const uint8_t collisionObjectId );

	const Rectangle* getRect( ) const;

private:
	Rectangle m_rect;
	Vector2i m_gameSize;
	Vector2i m_velocity;

	const Vector2i getIntersection( const Rectangle* otherRect ) const;
};

#endif // BALL_H
