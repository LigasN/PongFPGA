/*
 * Rectangle.cpp
 *
 *  Created on: 20 lis 2020
 *      Author: Norbert
 */

#include "MathUtils.h"
#include "Vector2i.h"
#include "Rectangle.h"
#include "../GameEngine.h"

Rectangle::Rectangle( int left, int top, int width, int hight ) :
		left( left ), top( top ), width( width ), hight( hight )
{
}

void Rectangle::render( GameEngine* gameEngine )
{
	int8_t renderData[RAM_ADDRESS_AMOUNT] {};
	int pos = 0;
	for( int j = 0; j < hight; ++j )
	{
		for( int i = 0; i < width; ++i )
		{
			pos = (left + i + WINDOW_WIDTH * (top + j));
			SET_BIT( renderData[pos / 8], pos % 8 );
		}
	}
	gameEngine->addToRender( renderData );
}
