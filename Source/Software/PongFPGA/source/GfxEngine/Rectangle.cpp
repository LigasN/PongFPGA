/*
 * Rectangle.cpp
 *
 *  Created on: 17 lis 2020
 *      Author: Norbert
 */

#include "Rectangle.h"

namespace gfx
{

Rectangle::Rectangle( math::Vector2i leftTopPoint, math::Vector2i rightBottomPoint ) :
		m_leftTopPoint( leftTopPoint ), m_rightBottomPoint( rightBottomPoint )
{

}
Rectangle::~Rectangle( )
{
}

// Getters
math::Vector2i Rectangle::getLeftTopPoint( ) const
{
	return m_leftTopPoint;
}
math::Vector2i Rectangle::getRightBottomPoint( ) const
{
	return m_rightBottomPoint;
}

void Rectangle::move( math::Vector2i moveVec )
{
	m_leftTopPoint += moveVec;
	m_rightBottomPoint += moveVec;
}

}
