/// Draws a sprite with a cached animation state with the added option of scaling/rotation/blending
/// This function only works with object instances and not structs (at the moment)
/// If an instance is drawing multiple occurrence of the same sprite, set the "identifier" argument
/// 
/// @param spriteIndex
/// @param startImageIndex
/// @param speed
/// @param x
/// @param y
/// @param xScale
/// @param yScale
/// @param angle
/// @param blend
/// @param alpha
/// @param [identifier="anonymous"]

function PinocchioSpriteExt(_spriteIndex, _startImageIndex, _speed, _x, _y, _xScale, _yScale, _angle, _blend, _alpha, _identifier = __PINOCCHIO_DEFAULT_IDENTIFIER)
{
    with(__PinocchioCache(id, _spriteIndex, _startImageIndex, _speed, _identifier))
    {
        draw_sprite_ext(_spriteIndex, imageIndex, _x, _y, _xScale, _yScale, _angle, _blend, _alpha);
        return self;
    }
}