/// Performs a full sweep over the whole animation cache
/// If any host instance for any animation has been destroyed or
/// deactivated, the animation state is cleared for that instance

function PinocchioCleanUpSweep()
{
    var _instanceList = global.__pinocchioInstanceList;
    var _instanceMap = global.__pinocchioInstanceMap;
    
    var _i = ds_list_size(_instanceList) - 1;
    repeat(_i+1)
    {
        var _instance = _instanceList[| _i];
        if (!instance_exists(_instance))
        {
            ds_list_delete(_instanceList, _i);
            ds_map_delete(_instanceMap, _instance);
        }
        
        --_i;
    }
}