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

function __PinocchioCache(_creator, _spriteIndex, _startImageIndex, _speed, _identifier)
{
    if (_speed < 0) show_error("Pinocchio:\nSpeed cannot be negative\n ", true);
    
    var _instanceDataStruct = global.__pinocchioInstanceMap[? _creator];
    if (_instanceDataStruct == undefined)
    {
        _instanceDataStruct = {};
        global.__pinocchioInstanceMap[? _creator] = _instanceDataStruct;
        ds_list_add(global.__pinocchioInstanceList, _creator);
    }
    
    var _animDataStruct = _instanceDataStruct[$ _spriteIndex];
    if (_animDataStruct == undefined)
    {
        _animDataStruct = {};
        _instanceDataStruct[$ _spriteIndex] = _animDataStruct;
    }
    
    var _occurrence = _animDataStruct[$ _identifier];
    if (_occurrence == undefined)
    {
        _occurrence = new __PinocchioClassOccurrence(_creator, _spriteIndex, _startImageIndex, _speed, _identifier);
        _animDataStruct[$ _identifier] = _occurrence;
    }
    else
    {
        _occurrence.speed = _speed;
        _occurrence.__Tick();
    }
    
    return _occurrence;
    
}

function __PinocchioClassOccurrence(_creator, _spriteIndex, _startImageIndex, _speed, _identifier) constructor
{
    creator = _creator;
    identifier = _identifier;
    spriteIndex = _spriteIndex;
    imageNumber = sprite_get_number(_spriteIndex);
    imageIndex = _startImageIndex;
    speed = _speed;
    callback = undefined;
    endOfAnimation = false;
    animationMode = 0; // 0 = Loop, 1 = Once, 2 = Ping-pong
    pingPongDirection = 1;
    onceComplete = false;
    
    static Once = function()
    {
        animationMode = 1;
        return self;
    }
    
    static PingPong = function()
    {
        animationMode = 2;
        return self;
    }
    
    static Callback = function(_callback)
    {
        callback = _callback;
        __CheckCallback();
        return self;
    }
    
    static __Tick = function()
    {
        endOfAnimation = false;
        
        if (animationMode == 0)
        {
            imageIndex = imageIndex + speed;
            __CheckCallback();
            imageIndex = imageIndex mod imageNumber;
        }
        else if (animationMode == 1)
        {
            if (!onceComplete)
            {
                imageIndex = imageIndex + speed;
                __CheckCallback();
                if (onceComplete) imageIndex = min(imageNumber - 1, imageIndex);
            }
        }
        else if (animationMode == 2)
        {
            imageIndex = imageIndex + pingPongDirection*speed;
            __CheckCallback();
            imageIndex = imageIndex mod imageNumber;
        }
    }
    
    static __CheckCallback = function()
    {
        if (!endOfAnimation)
        {
            if ((imageIndex >= imageNumber) || ((pingPongDirection < 0) && (imageIndex <= 0)))
            {
                endOfAnimation = true;
                onceComplete = true;
                
                if (is_method(callback))
                {
                    method(creator, callback)(spriteIndex, imageIndex, speed, identifier);
                    return true;
                }
            }
        }
        
        return false;
    }
}