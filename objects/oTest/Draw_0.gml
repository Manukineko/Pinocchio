PinocchioSprite(sprTest1, 0, 0.1, x, y).Callback(function(_spriteIndex, _imageIndex, _speed, _identifier)
{
    show_debug_message(string(current_time) + ": " + string(id) + "    " + string(_imageIndex));
});