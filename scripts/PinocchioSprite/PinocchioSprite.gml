/// Draws a sprite using an animator that automatically animates the sprite's images for you
/// If an instance is drawing multiple animator of the same sprite, set the "identifier" argument
/// to differentiate between animations
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
/// @param [identifier="anonymous"]

function PinocchioSprite(_spriteIndex, _startImageIndex, _speed, _x, _y, _identifier = __PINOCCHIO_DEFAULT_IDENTIFIER)
{
    __PINOCCHIO_MAKE_FINGERPRINT;
    var _fullIdentifier = string(_spriteIndex) + ":" + _identifier;
    
    var _animator = __PinocchioCacheTest(__pinocchioFingerprint, _fullIdentifier);
    if (_animator == undefined)
    {
        _animator = new __PinocchioClassAnimator(__pinocchioFingerprint, _fullIdentifier, _startImageIndex, _speed, 0, sprite_get_number(_spriteIndex) - math_get_epsilon());
        _animator.spriteBased = true;
    }
    else
    {
        _animator.speed = _speed;
        _animator.__Tick();
    }
    
    draw_sprite(_spriteIndex, _animator.value, _x, _y);
    
    return _animator;
}