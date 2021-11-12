/// Performs a full sweep over the whole animation cache
/// If any host instance for any animation has been destroyed or
/// deactivated, the animation state is cleared for that instance
/// 
/// N.B. It is advisable to call this function in a Room Start event
///      so that the animation cache is cleaned out frequently

function PinocchioCleanUp()
{
    var _instanceList = global.__pinocchioInstanceList;
    var _instanceMap = global.__pinocchioInstanceMap;
    
    var _i = ds_list_size(_instanceList) - 1;
    repeat(_i+1)
    {
        var _pointer = _instanceList[| _i];
        try
        {
            var _dummy = _pointer.__pinocchioPointer;
        }
        catch(_)
        {
            ds_list_delete(_instanceList, _i);
            ds_map_delete(_instanceMap, _pointer);
        }
        
        --_i;
    }
}