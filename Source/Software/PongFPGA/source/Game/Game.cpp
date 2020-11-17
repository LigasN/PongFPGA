/*
 * Game.cpp
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#include "Game.h"
#include "../GfxEngine/GfxEngine.h"
#include "../Math/Vector2i.h"

namespace game
{

Game::Game( ) :
		gfx::IGame( ), m_ball( math::Vector2i( 0, 0 ), math::Vector2i( 1, 1 ) )
{
}

Game::~Game( )
{
}

// Main Interface

void Game::init( gfx::GfxEngine* gfxEngine )
{
	gfxEngine->bindRectangle( &m_ball );
}

void Game::processInput( const int key )
{
	if( key == ( int )gfx::RightArrow )
	{
		ballMoving = true;
		m_ball.move( math::Vector2i( 1, 0 ) );
	}
}

void Game::update( const float dt )
{
	m_ball.move( math::Vector2i( dt, 0 ) );
	ballMoving = false;
}

void Game::render( )
{
}

}

