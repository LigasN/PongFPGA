/*
 * Player.h
 *
 *  Created on: 19 lis 2020
 *      Author: Norbert
 */

#ifndef PLAYER_H
#define PLAYER_H

#include "Vector2i.h"
#include "Rectangle.h"
#include <stdint.h>

class GameEngine;

class Player
{
public:
	Player( const int windowHight, const Vector2i batSize, const bool leftSide,
	        const bool isAI );

	// Main interface
	void processInput( const uint8_t state );
	void update( );
	void render( GameEngine* gameEngine );
	const Rectangle* getRect( ) const;
	void handleCollision( const Vector2i rect );

private:
	const int m_windowHight;
	Rectangle m_rect;
	bool m_isAI;

	int m_velocity;

	// Moving flags
	bool m_movingUp;
	bool m_movingDown;
	bool m_leftSide;

};

#endif // !PLAYER_H
