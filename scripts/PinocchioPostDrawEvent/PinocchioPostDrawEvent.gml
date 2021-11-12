/// Ticks over a portion of the animation cache
/// If a host instance for an animation has been destroyed or
/// deactivated, the animation state is cleared for that instance
/// 
/// N.B. This function only needs to be called once a frame,
///      probably in a persistent controller instance

function PinocchioPostDrawEvent()
{
    if (PINOCCHIO_AUTOMATIC_TICK)
    {
        var _instanceList = global.__pinocchioInstanceList;
        var _instanceMap = global.__pinocchioInstanceMap;
        var _listSize = ds_list_size(_instanceList);
        if (_listSize <= 0) exit;
        
        var _index = min(global.__pinocchioSweepIndex, _listSize);
        
        var _iterations = clamp(ceil(sqrt(_listSize)), 1, _listSize);
        repeat(_iterations)
        {
            //Move backwards through the cache list so we are always trying to check the oldest stuff before looping round
            _index--;
            
            //Check to see if we need to wrap around
            if (_index < 0)
            {
                //If we do, jump to the end of the list
                _index += ds_list_size(_instanceList);
                
                //If the size of the list is 0 then we'll still be negative
                if (_index < 0)
                {
                    _index = 0; //Clamp to 0
                    break;
                }
            }
            
            var _instance = _instanceList[| _index];
            if (!instance_exists(_instance))
            {
                ds_list_delete(_instanceList, _index);
                ds_map_delete(_instanceMap, _instance);
            }
        }
        
        global.__pinocchioSweepIndex = _index;
    }
}