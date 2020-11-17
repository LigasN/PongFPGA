/*
 * Vector2i.cpp
 *
 *  Created on: 16 lis 2020
 *      Author: Norbert
 */

#include "Vector2i.h"

namespace math
{
Vector2i::Vector2i( )
{
	x = 0;
	y = 0;
}

Vector2i::Vector2i( int x, int y )
{
	this->x = x;
	this->y = y;
}
Vector2i::~Vector2i( )
{

}

// Operators
void Vector2i::operator+=( Vector2i& vec2 )
{
	x += vec2.x;
	y += vec2.y;
}

}
