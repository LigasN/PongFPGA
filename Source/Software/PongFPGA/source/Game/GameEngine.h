/*
 * Game.h
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#ifndef GAME_H
#define GAME_H

#include "Player.h"
#include "Rectangle.h"
#include <stdint.h>

#define WINDOW_WIDTH 32u
#define WINDOW_HIGHT 24u
#define RAM_ADDRESS_AMOUNT (WINDOW_WIDTH * WINDOW_HIGHT)/8

class GameEngine
{
public:
	GameEngine( );
	~GameEngine( );

	// Main interface
	void processInput( const uint8_t state );
	void update( const float dt );
	void render( );

	// Engine methods
	void addToRender( const int8_t data[RAM_ADDRESS_AMOUNT] );

private:

	// Objects
	Rectangle m_net;
	Rectangle m_ball;

	// Players
	Player m_player;

	// Data to render
	int8_t m_renderData[RAM_ADDRESS_AMOUNT];

	// To delete in feature
	bool m_ballMovingToRight;
	bool m_ballMovingToLeft;

};

#endif // !GAME_H
