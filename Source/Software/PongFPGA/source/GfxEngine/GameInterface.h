/*
 * GameInterface.h
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#ifndef GAMEINTERFACE_H
#define GAMEINTERFACE_H

namespace gfx
{

#include <stdint.h>

class GfxEngine;

class IGame
{
public:

	virtual ~IGame( )
	{
	}

	// Main Interface
	virtual void init( gfx::GfxEngine* gfxEngine ) = 0;
	virtual void processInput( const int key ) = 0;
	virtual void update( const float dt ) = 0;
	virtual void render( ) = 0;
};

}

#endif // !GAMEINTERFACE_H
