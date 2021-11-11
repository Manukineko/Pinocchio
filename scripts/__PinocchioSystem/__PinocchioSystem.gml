#macro __PINOCCHIO_VERSION  "0.0.1"
#macro __PINOCCHIO_DATE     "2021-11-11"

show_debug_message("Pinocchio: Welcome to Pinocchio by @jujuadams! This is version " + __PINOCCHIO_VERSION + ", " + __PINOCCHIO_DATE);

global.__pinocchioInstanceMap = ds_map_create();
global.__pinocchioInstanceList = ds_list_create();
global.__pinocchioCheckIndex = 0;