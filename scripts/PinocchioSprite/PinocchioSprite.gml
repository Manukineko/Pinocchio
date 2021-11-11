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

function PinocchioSprite(_spriteIndex, _startImageIndex, _speed, _x, _y, _ident = "anonymous")
{
    var _instanceDataStruct = global.__pinocchioInstanceMap[? id];
    if (_instanceDataStruct == undefined)
    {
        _instanceDataStruct = {};
        global.__pinocchioInstanceMap[? id] = _instanceDataStruct;
        ds_list_add(global.__pinocchioInstanceList, id);
    }
    
    var _animDataStruct = _instanceDataStruct[$ _spriteIndex];
    if (_animDataStruct == undefined)
    {
        _animDataStruct = {};
        _instanceDataStruct[$ _spriteIndex] = _animDataStruct;
    }
    
    var _image = _animDataStruct[$ _ident];
    if (_image == undefined)_image = _startImageIndex;
    
    draw_sprite(_spriteIndex, _image, _x, _y);
    _animDataStruct[$ _ident] = _image + _speed;
}