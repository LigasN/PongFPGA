/*
 * Net.h
 *
 *  Created on: 20 lis 2020
 *      Author: Norbert
 */

#ifndef NET_H
#define NET_H

#include "Vector2i.h"
#include "Rectangle.h"
#include <stdint.h>

class GameEngine;

class Net
{
public:
	Net( const int windowWidth, const int windowHight ) :
			m_windowSize { windowWidth, windowHight },
			m_rect( windowWidth / 2 - 1, 0, windowWidth % 2 == 0 ? 2 : 1,
			        windowHight )
	{
	}

	void render( GameEngine* gameEngine );

private:
	Vector2i m_windowSize;
	Rectangle m_rect;

};

#endif // !NET_H
