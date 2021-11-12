/// You'll probably never need to run this code as it is executed automatically
/// using a layer script hack. Please see __PinocchioSystem() for more information.
/// If you *are* seeing problems where this function isn't run for some reason
/// then you'll need to execute this code yourself, usually in a persistent controller
/// instance of some kind.

function PinocchioPostDrawEvent()
{
    if ((event_type == ev_draw) && (event_number == ev_draw_post))
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
            
            var _pointer = _instanceList[| _index];
            if (is_ptr(_pointer))
            {
                try
                {
                    var _dummy = _pointer.__pinocchioFingerprint;
                }
                catch(_)
                {
                    ds_list_delete(_instanceList, _index);
                    ds_map_delete(_instanceMap, _pointer);
                }
            }
            else if (!instance_exists(_pointer))
            {
                ds_list_delete(_instanceList, _index);
                ds_map_delete(_instanceMap, _pointer);
            }
        }
        
        global.__pinocchioSweepIndex = _index;
    }
}