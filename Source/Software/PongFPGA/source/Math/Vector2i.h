/*
 * Vector2i.h
 *
 *  Created on: 16 lis 2020
 *      Author: Norbert
 */

#ifndef VECTOR2I_H
#define VECTOR2I_H

namespace math
{

struct Vector2i
{
	Vector2i( );
	Vector2i( int x, int y );
	~Vector2i( );

	// Operators
	void operator+=( Vector2i& vec2 );

	// Members
	int x;
	int y;
};

// Operators
static Vector2i operator+( const Vector2i& vec1, const Vector2i& vec2 )
{
	return Vector2i( vec1.x + vec2.x, vec1.y + vec2.y );
}
static Vector2i operator-( const Vector2i& vec1, const Vector2i& vec2 )
{
	return Vector2i( vec1.x - vec2.x, vec1.y - vec2.y );
}

}

#endif // !VECTOR2I_H
