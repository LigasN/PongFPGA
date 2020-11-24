/*
 * Net.cpp
 *
 *  Created on: 20 lis 2020
 *      Author: Norbert
 */

#include "../GameEngine.h"
#include "../Utils/MathUtils.h"

Net::Net( const int windowWidth, const int windowHight ) :
		m_windowSize { windowWidth, windowHight },
		m_rect( windowWidth / 2 - 1, 0, windowWidth % 2 == 0 ? 2 : 1,
		        windowHight )
{
}

void Net::render( GameEngine* gameEngine )
{
	// TODO: Test with one pixel width

	int8_t renderData[m_windowSize.x * m_windowSize.y] {};
	int pos = 0;

	for( int j = 0, i = 0; j < m_rect.hight; ++j )
	{
		pos = (m_rect.left + i % 2 + m_windowSize.x * (m_rect.top + j));
		SET_BIT( renderData[pos / 8], pos % 8 );

		if( m_rect.width > 1 )
			++i;
	}
	gameEngine->addToRender( renderData );
}

