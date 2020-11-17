#ifndef GFXENGINE_H
#define GFXENGINE_H

#include "../Math/Vector2i.h"
#include "Rectangle.h"
#include <stdint.h>

namespace gfx
{

enum Key
{
	Enter = 0, RightArrow = 1, LeftArrow = 2
};

class IGame;

class GfxEngine
{
public:
	GfxEngine( IGame* game, const math::Vector2i resolution );
	~GfxEngine( );

	// Main Interface
	void processInput( const uint8_t state );
	void update( const int dt );
	void render( );

	// Public functions
	void bindRectangle( const Rectangle* rect );

private:
	const Rectangle* m_rectangles[10]; // Max amount of rectangles
	uint8_t m_rectanglesSize;

	IGame * m_game;
	const math::Vector2i m_resolution;

	// Private functions
	void refreshRAM( );
};

}
#endif // !GFXENGINE_H
