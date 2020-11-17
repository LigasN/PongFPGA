/*
 * Rectangle.h
 *
 *  Created on: 16 lis 2020
 *      Author: Norbert
 */

#ifndef RECTANGLE_H
#define RECTANGLE_H

#include "../Math/Vector2i.h"

namespace gfx
{

class Rectangle
{
public:
	Rectangle( math::Vector2i leftTopPoint, math::Vector2i rightBottomPoint );
	~Rectangle( );

	void move( math::Vector2i moveVec );

	math::Vector2i getLeftTopPoint( ) const;
	math::Vector2i getRightBottomPoint( ) const;

private:
	math::Vector2i m_leftTopPoint;
	math::Vector2i m_rightBottomPoint;

};

}

#endif // !RECTANGLE_H
