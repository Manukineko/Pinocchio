/// Returns a generic Pinocchio animator for the scoped instance/struct with the given identifier
/// If animator with a matching identifier is found for the scoped instance/struct then a new one is created
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
/// @param identifier    Unique identifier to use for this animator. This should be unique within the scoped instance/struct
/// @param startValue    Starting value for the animator
/// @param speed         Speed that the value changes. This must be positive
/// @param minValue      Minimum value for the animator
/// @param maxValue      Maximum value for the animator

function PinocchioGeneric(_identifier, _startValue, _speed, _minValue, _maxValue)
{
    __pinocchioPointer = ptr(self);
    
    var _animator = __PinocchioCacheTest(__pinocchioPointer, _identifier);
    if (_animator == undefined)
    {
        _animator = new __PinocchioClassAnimator(__pinocchioPointer, _identifier, _startValue, _speed, _minValue, _maxValue);
    }
    else
    {
        with(_animator)
        {
            speed    = _speed;
            minValue = _minValue;
            maxValue = _maxValue;
            
            __Tick();
        }
    }
    
    return _animator;
}