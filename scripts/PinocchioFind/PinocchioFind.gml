/// Returns the Pinocchio animator for the scoped instance/struct with the given identifier, if it exists
/// If no animator with a matching identifier is found for the scoped instance/struct then <undefined> is returned
/// 
/// @param [identifier]     Unique identifier for the animator you're trying to find
/// @param [spriteIndex]    Sprite index associated with the animator you're trying to find

function PinocchioFind(_identifier, _spriteIndex)
{
    __PINOCCHIO_MAKE_FINGERPRINT;
    
    if (_spriteIndex != undefined)
    {
        var _fullIdentifier = string(_spriteIndex) + ":" + ((_identifier == undefined)? __PINOCCHIO_DEFAULT_IDENTIFIER : _identifier);
        return __PinocchioCacheTest(__pinocchioFingerprint, _fullIdentifier);
    }
    else
    {
        if (_identifier == undefined) show_error("Pinocchio:\nAn identifier must be specified if no sprite is specified\n ", true);
        return __PinocchioCacheTest(__pinocchioFingerprint, _identifier);
    }
}
