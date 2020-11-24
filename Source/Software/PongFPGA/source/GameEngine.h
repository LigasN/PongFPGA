/*
 * Game.h
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#ifndef GAME_H
#define GAME_H

#include "Utils/Rectangle.h"
#include "GameObjects/Ball.h"
#include "GameObjects/Net.h"
#include "GameObjects/Player.h"
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
	void update( );
	void render( );

	// Engine methods
	void addToRender( const int8_t data[RAM_ADDRESS_AMOUNT] );

private:

	bool m_gameStarted;

	// Objects
	Net m_net;
	Ball m_ball;
	Rectangle m_leftBorder;
	Rectangle m_rightBorder;
	Rectangle m_topBorder;
	Rectangle m_bottomBorder;

	// Players
	Player m_player;
	Player m_AIPlayer;

	// Data to render
	int8_t m_renderData[RAM_ADDRESS_AMOUNT];

};

#endif // !GAME_H
