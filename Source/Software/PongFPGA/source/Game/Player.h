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
	Player( const Vector2i batSize, const bool leftSide = true,
	        const bool isAI = false );

	// Main interface
	void processInput( const uint8_t state );
	void update( const float dt );
	void render( GameEngine* gameEngine );

private:
	Rectangle m_bat;
	bool m_isAI;

	// Moving flags
	bool m_movingUp;
	bool m_movingDown;

	bool m_leftSide;

};

#endif // !PLAYER_H
