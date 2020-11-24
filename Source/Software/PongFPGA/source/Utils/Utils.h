/*
 * Utils.h
 *
 *  Created on: 19 lis 2020
 *      Author: Norbert
 */

#ifndef UTILS_H
#define UTILS_H

enum Key
{
	ENTER = 0b110, RBUTTON = 0b011, LBUTTON = 0b101
};

enum CollisionObjectIds
{
	HORIZONTAL_BORDER = (1 << 0), VERTICAL_BORDER = (1 << 1), BAT = (1 << 2)
};

#endif // !UTILS_H
