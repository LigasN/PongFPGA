/*
 * MathUtils.h
 *
 *  Created on: 21 lis 2020
 *      Author: Norbert
 */

#ifndef MATH_UTILS_H
#define MATH_UTILS_H

#define MAX(a, b) ((a)>=(b)? (a) : (b))
#define MIN(a, b) ((a)<=(b)? (a) : (b))

#define SET_BIT(var, bit_num) (var |= (1 << bit_num))
#define GET_BIT(var, bit_num) ((var & (1 << bit_num)) > 0 ? true : false)

#endif // !MATH_UTILS_H
