/// Draws a sprite with a cached animation state
/// This function only works with object instances and not structs (at the moment)
/// If an instance is drawing multiple occurrence of the same sprite, set the "identifier" argument
/// 
/// @param spriteIndex
/// @param startImageIndex
/// @param speed
/// @param x
/// @param y
/// @param [identifier="anonymous"]

function PinocchioSprite(_spriteIndex, _startImageIndex, _speed, _x, _y, _identifier = __PINOCCHIO_DEFAULT_IDENTIFIER)
{
    with(__PinocchioCache(id, _spriteIndex, _startImageIndex, _speed, _identifier))
    {
        draw_sprite(_spriteIndex, imageIndex, _x, _y);
        return self;
    }
}