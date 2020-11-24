/*
 * Character.cpp
 *
 *  Created on: 24 lis 2020
 *      Author: Norbert
 */

#include "Character.h"
#include "../GameEngine.h"
#include "../Utils/MathUtils.h"

Character::Character( const uint8_t left, const uint8_t top ) :
		m_left( left ), m_top( top ), m_character( 0 ), m_characters { 71,
		                                                               69,
		                                                               69,
		                                                               69,
		                                                               71, // 0, 1
		        119, 68, 119, 65, 119,	// 2, 3
		        117, 21, 119, 68, 116,	// 4, 5
		        119, 65, 71, 69, 71,	// 6, 7
		        119, 85, 119, 69, 119	// 8, 9
		}
{

}

bool Character::setCharacter( const uint8_t character )
{
	if( character > 9 || character < 0 )
		return false;

	m_character = character;
	return true;
}

void Character::render( GameEngine* gameEngine )
{
	int8_t renderData[RAM_ADDRESS_AMOUNT] {};
	uint8_t startPos = 0;

	for( int j = 0; j < CHARACTER_HIGHT; ++j )
	{
		for( int i = 0; i < CHARACTER_WIDTH; ++i )
		{
			startPos = (m_left + i + WINDOW_WIDTH * (m_top + j)); // like in Ball.h

			if( GET_BIT(
			        m_characters[j + ((m_character / 2) * CHARACTER_HIGHT)],
			        (((m_character % 2) * CHARACTER_WIDTH) + i) ) )
			{
				SET_BIT( renderData[startPos / 8], startPos % 8 );
			}
		}
	}
	gameEngine->addToRender( renderData );
}
