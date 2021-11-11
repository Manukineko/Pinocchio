/// Ticks over a portion of the animation cache
/// If a host instance for an animation has been destroyed or
/// deactivated, the animation state is cleared for that instance

function PinocchioCleanUpTick()
{
    var _instanceList = global.__pinocchioInstanceList;
    var _listSize = ds_list_size(_instanceList);
    if (_listSize <= 0) exit;
    
    var _instanceMap = global.__pinocchioInstanceMap;
    
    var _index = global.__pinocchioCheckIndex;
    _index = _index mod _listSize;
    
    var _iterations = clamp(ceil(sqrt(_listSize)), 1, _listSize);
    repeat(_iterations)
    {
        var _instance = _instanceList[| _index];
        if (!instance_exists(_instance))
        {
            ds_list_delete(_instanceList, _index);
            ds_map_delete(_instanceMap, _instance);
            _listSize--;
            _index--;
        }
        
        _index = (_index + 1) mod _listSize;
    }
    
    global.__pinocchioCheckIndex = _index;
}