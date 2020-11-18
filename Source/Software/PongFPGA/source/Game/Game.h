/*
 * Game.h
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#ifndef GAME_H
#define GAME_H

#include "Rectangle.h"
#include <stdint.h>

class Game
{
public:
	Game( const uint16_t width, const uint16_t hight );
	~Game( );

	// Main Interface16
	void processInput( const uint8_t state );
	void update( const float dt );
	void render( );

private:
	const uint16_t m_width;
	const uint16_t m_hight;
	Rectangle m_ball;
	bool m_ballMovingToRight;
	bool m_ballMovingToLeft;

};

#endif // !GAME_H
