///map_place(obj_layer layer, par_object object, int posX, int posY)

/*
    Functions as GameMaker's instance_place, but for the virtual 2D array of this 
    room's map.
    
    Returns objenum if this object in the layer's enum list.
    Otherwise returns the object asset if it found it or false.
*/

/* 
    TODO hardcoding this check for obj str name sucks hardcore, this function will be called all the time
    the problem here is that a string doesn't know if it's a child of a parent; this function is often called
    with simply a parent and then it is met with a string compare which it fails obviously
*/

var layer = argument0;
var object = argument1;
var posX = argument2;
var posY = argument3;

print("-> map_place(" + string(object_get_name(object)) + ", " + string(posX) + "," + string(posY) + ")");

var thisTile = layer.roomMapArr[(real(posY))/global.TILE_SIZE, (real(posX))/global.TILE_SIZE]
//print("map_place: THISROW: " + string(thisTile));
var thisTileObjs = scr_split(thisTile, ";");
//print("map_place: array length: " + string(array_length_1d(thisTileObjs)));
for (var i = 0; i < array_length_1d(thisTileObjs); i++){
    var objStr = scr_split(thisTileObjs[i], "[");
    //print("map_place: Tile object: " + string(objStr[0]));
    //print("map_place: Object to find: " + string(object_get_name(object)));
    
    /*
        The following is inst create ONLY to see what instance the id is assigned.  
        TODO find a better way to do this than this shit.  
    */
    
    var objFromStr = get_objectFromString(objStr[0]);
    
    //print("ObjFromStr as an object: " + string(objectStr(objFromStr)));
    
    
    if (!instance_exists(object)) instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, object);
    if (!instance_exists(objFromStr)) instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, objFromStr);
    
    if ((objFromStr.id == object.id)){
        var enumRef = ds_map_find_value(layer.objNameAndPosToEnumMap, objStr[0] + ":" + string(posX) + "," + string(posY));
        if (enumRef) print("map_place: ObjEnum found: " + enumRef[| OBJECT.NAME]);
        if (!enumRef){ print("map_place Returning " + string(objectStr(objFromStr))); return objFromStr; }
        
        return enumRef; //return enum if it's in the layer's enum List
    }
}

return false;

/*switch (object){
    case par_robot:
        if (string_count("obj_player", 
                 layer.roomMapArr[(real(posY))/global.TILE_SIZE, (real(posX))/global.TILE_SIZE])) return true;
        if (string_count("obj_roberta", 
                 layer.roomMapArr[(real(posY))/global.TILE_SIZE, (real(posX))/global.TILE_SIZE])) return true;
        break;
}*/
