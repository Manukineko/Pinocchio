/// Draws a sprite using an animator that automatically animates the sprite's images for you, with
/// the added option of scaling/rotation/blending. If an instance is drawing multiple animator of
/// the same sprite, set the "identifier" argument to differentiate between animations
/// 
/// The animator returned by this function is a struct and has the following methods:
///     .Get()
///         Returns the current value for the animator
///     
///     .Once()
///         Instructs the animator to only play once
///     
///     .PingPong()
///         Instructs the animator to bounce between the minimum and maximum values
///     
///     .PingPongSharp()
///         As above, but with less dwell time at each extreme
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
    var _fullIdentifier = string(_spriteIndex) + ":" + _identifier;
    __pinocchioPointer = ptr(self);
    
    var _animator = __PinocchioCacheTest(__pinocchioPointer, _fullIdentifier);
    if (_animator == undefined)
    {
        _animator = new __PinocchioClassAnimator(__pinocchioPointer, _fullIdentifier, _startImageIndex, _speed, 0, sprite_get_number(_spriteIndex) - math_get_epsilon());
        _animator.spriteBased = true;
    }
    else
    {
        _animator.speed = _speed;
        _animator.__Tick();
    }
    
    draw_sprite_ext(_spriteIndex, _animator.value, _x, _y, _xScale, _yScale, _angle, _blend, _alpha);
    
    return _animator;
}