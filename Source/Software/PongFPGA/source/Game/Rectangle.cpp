/*
 * Rectangle.cpp
 *
 *  Created on: 20 lis 2020
 *      Author: Norbert
 */

#include "MathUtils.h"
#include "Vector2i.h"
#include "Rectangle.h"
#include "GameEngine.h"

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

bool Rectangle::checkCollisions( const Rectangle* otherRect ) const
{
	if( (left < otherRect->left + otherRect->width
	        && left + width > otherRect->left)
	        && (top < otherRect->top + otherRect->hight
	                && top + hight > otherRect->top) )
	{
		bool a = left < otherRect->left + otherRect->width;
		bool b = left + width > otherRect->left;
		bool c = top < otherRect->top + otherRect->hight;
		bool d = top + hight > otherRect->top;
	}
	return (left < otherRect->left + otherRect->width
	        && left + width > otherRect->left)
	        && (top < otherRect->top + otherRect->hight
	                && top + hight > otherRect->top);
}

const Vector2i Rectangle::getIntersection( const Rectangle* otherRect ) const
{
	int minx = MIN( left + width, otherRect->left + otherRect->width );
	int maxx = MAX( left, otherRect->left );
	int miny = MIN( top + hight, otherRect->top + otherRect->hight );
	int maxy = MAX( top, otherRect->top );
	int intx = MIN( left + width, otherRect->left + otherRect->width )
	        - MAX( left, otherRect->left );
	int inty = MIN( top + hight, otherRect->top + otherRect->hight )
	        - MAX( top, otherRect->top );

	return Vector2i { MIN( left + width, otherRect->left + otherRect->width )
	                          - MAX( left, otherRect->left ),
	                  MIN( top + hight, otherRect->top + otherRect->hight )
	                          - MAX( top, otherRect->top ) };
}
