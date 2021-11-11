#macro __PINOCCHIO_VERSION  "0.0.2"
#macro __PINOCCHIO_DATE     "2021-11-11"

show_debug_message("Pinocchio: Welcome to Pinocchio by @jujuadams! This is version " + __PINOCCHIO_VERSION + ", " + __PINOCCHIO_DATE);

// Use a list here because it's faster to add to (also this is a static data structure so no GC needed on it)
global.__pinocchioInstanceList = ds_list_create();

// Use a list here because we can store struct pointers in it implicitly
// ...though that's not a feature yet, but we're future-proofing
global.__pinocchioInstanceMap = ds_map_create();

//Index for the internal GC sweep
global.__pinocchioSweepIndex = 0;