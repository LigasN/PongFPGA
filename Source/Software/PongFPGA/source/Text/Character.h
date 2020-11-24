/*
 * Font.h
 *
 *  Created on: 24 lis 2020
 *      Author: Norbert
 */

#ifndef CHARACTER_H
#define CHARACTER_H

#include <stdint.h>

// Matrix of characters written in a row like 	0 1
//												2 3
//												4 5
//												6 ...
// where one character is 3x4 with one column free after.
// Thanks to solution with 2 characters in a row there is
// only one dimension array where even numbers are in the
// second column. Check documents directory in repository
// for checking that values are proper.

#define CHARACTER_WIDTH 4 // No more possible in uint8_t
#define CHARACTER_HIGHT 5

class GameEngine;

class Character
{
public:
	Character( const uint8_t left, const uint8_t top );

	bool setCharacter( const uint8_t character );

	void render( GameEngine* gameEngine );

private:
	//Position
	const uint8_t m_left;
	const uint8_t m_top;

	uint8_t m_character;

	// Size equal to characters amount * m_charactersWidth
	// 10 <- characters amount
	// 2  <- characters per row
	// definition in constructor body
	const uint8_t m_characters[10 / 2 * CHARACTER_HIGHT];
};

#endif // !CHARACTER_H
