#macro __PINOCCHIO_VERSION  "0.0.2"
#macro __PINOCCHIO_DATE     "2021-11-11"

show_debug_message("Pinocchio: Welcome to Pinocchio by @jujuadams! This is version " + __PINOCCHIO_VERSION + ", " + __PINOCCHIO_DATE);

#macro __PINOCCHIO_DEFAULT_IDENTIFIER  "anonymous"

// Use a list here because it's faster to add to (also this is a static data structure so no GC needed on it)
global.__pinocchioInstanceList = ds_list_create();

// Use a list here because we can store struct pointers in it implicitly
// ...though that's not a feature yet, but we're future-proofing
global.__pinocchioInstanceMap = ds_map_create();

//Index for the internal GC sweep
global.__pinocchioSweepIndex = 0;

function __PinocchioCacheTest(_creator, _identifier)
{
    var _instanceDataStruct = global.__pinocchioInstanceMap[? _creator];
    if (_instanceDataStruct == undefined) return undefined;
    return _instanceDataStruct[$ _identifier];
}

function __PinocchioClassAnimator(_creator, _identifier, _startValue, _speed, _minValue, _maxValue) constructor
{
    if (_speed < 0) show_error("Pinocchio:\nSpeed cannot be negative\n ", true);
    
    var _instanceDataStruct = global.__pinocchioInstanceMap[? _creator];
    if (_instanceDataStruct == undefined)
    {
        _instanceDataStruct = {};
        global.__pinocchioInstanceMap[? _creator] = _instanceDataStruct;
        ds_list_add(global.__pinocchioInstanceList, _creator);
    }
    
    _instanceDataStruct[$ _identifier] = self;
    
    
    
    minValue = min(_minValue, _maxValue);
    maxValue = max(_minValue, _maxValue);
    value    = ((_startValue - minValue) mod (maxValue - minValue)) + minValue;
    speed    = _speed;
    
    spriteBased = false;
    animation_type = 0; //0 = Loop, 1 = Once, 2 = Ping-pong, 3 = Sharp ping-pong
    pingPongDirection = 1;
    
    static Get = function()
    {
        return value;
    }
    
    static Once = function()
    {
        animation_type = 1;
        return self;
    }
    
    static PingPong = function()
    {
        animation_type = 2;
        return self;
    }
    
    static PingPongSharp = function()
    {
        if (!spriteBased) show_error("Pinocchio:\n.PingPongSharp() can only be used with sprite-based animators\n ", true);
        animation_type = 3;
        return self;
    }
    
    static __Tick = function()
    {
        switch(animation_type)
        {
            case 0:
                value = ((value - minValue + speed) mod (maxValue - minValue)) + minValue;
            break;
            
            case 1:
                value = min(maxValue, value + speed);
            break;
            
            case 2:
                if (pingPongDirection > 0)
                {
                    value += speed;
                    
                    if (value >= maxValue)
                    {
                        value = maxValue;
                        pingPongDirection = -1;
                    }
                }
                else
                {
                    value -= speed;
                    
                    if (value <= minValue)
                    {
                        value = minValue;
                        pingPongDirection = 1;
                    }
                }
            break;
            
            case 3:
                if (pingPongDirection > 0)
                {
                    value += speed;
                    
                    if (value >= maxValue)
                    {
                        value = ceil(maxValue) - 1;
                        pingPongDirection = -1;
                    }
                }
                else
                {
                    value -= speed;
                    
                    if (value <= minValue)
                    {
                        value = minValue + 1;
                        pingPongDirection = 1;
                    }
                }
            break;
        }
    }
}