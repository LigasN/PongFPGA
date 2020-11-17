/*
 * Game.h
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#ifndef GAME_H
#define GAME_H

#include "../GfxEngine/GameInterface.h"
#include "../GfxEngine/Rectangle.h"

namespace game
{

class Game : public gfx::IGame
{
public:
	Game( );
	~Game( );

	// Main Interface
	void init( gfx::GfxEngine* gfxEngine );
	void processInput( const int key );
	void update( const float dt );
	void render( );

private:
	gfx::Rectangle m_ball;
	bool ballMoving;

};

}

#endif // !GAME_H
