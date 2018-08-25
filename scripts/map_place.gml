///map_place(obj_layer thisLayer, par_object object, int posX, int posY)

/*
    Functions as GameMaker's instance_place, but for the virtual 2D array of this 
    room's map.
*/

/* 
    TODO hardcoding this check for obj str name sucks hardcore, this function will be called all the time
    the problem here is that a string doesn't know if it's a child of a parent; this function is often called
    with simply a parent and then it is met with a string compare which it fails obviously
*/

thisLayer = argument0;
object = argument1;
posX = argument2;
posY = argument3;

var thisRow = thisLayer.roomMapArr[(real(posY))/global.TILE_SIZE, (real(posX))/global.TILE_SIZE]
print("THISROW: " + string(thisRow));
var thisRowObjs = scr_split(thisRow, ";");
print("array length: " + string(array_length_1d(thisRowObjs)));
for (var i = 0; i < array_length_1d(thisRowObjs); i++){
    var objStr = scr_split(thisRowObjs[i], "[");
    print("objStr: " + string(objStr[0]));
    print("obj: " + string(object_get_name(object)));
    
    /*
        The following is ONLY to see what instance the id is assigned.  
        TODO find a better way to do this than this shit.  
    */
    
    var objFromStr = get_objectFromString(objStr[0]);
    
    if (!instance_exists(object)) instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, object);
    if (!instance_exists(objFromStr)) instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, objFromStr);
    
    if ((objFromStr.id == object.id)) return true;
}

return false;

/*switch (object){
    case par_robot:
        if (string_count("obj_player", 
                 thisLayer.roomMapArr[(real(posY))/global.TILE_SIZE, (real(posX))/global.TILE_SIZE])) return true;
        if (string_count("obj_roberta", 
                 thisLayer.roomMapArr[(real(posY))/global.TILE_SIZE, (real(posX))/global.TILE_SIZE])) return true;
        break;
}*/