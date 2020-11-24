/*
 * Net.h
 *
 *  Created on: 20 lis 2020
 *      Author: Norbert
 */

#ifndef NET_H
#define NET_H

#include "../Utils/Vector2i.h"
#include "../Utils/Rectangle.h"
#include <stdint.h>

class GameEngine;

class Net
{
public:
	Net( const int windowWidth, const int windowHight );

	void render( GameEngine* gameEngine );

private:
	Vector2i m_windowSize;
	Rectangle m_rect;

};

#endif // !NET_H
