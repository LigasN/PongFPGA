/*
 * Rectangle.h
 *
 *  Created on: 16 lis 2020
 *      Author: Norbert
 */

#ifndef RECTANGLE_H
#define RECTANGLE_H

#include "Vector2i.h"

class GameEngine;

class Rectangle
{
public:
	Rectangle( int left, int top, int width, int hight );

	void render( GameEngine* gameEngine );

	// Public members because only by includes
	// problems it is not a struct
	int left;
	int top;
	int width;
	int hight;

};

#endif // !RECTANGLE_H
