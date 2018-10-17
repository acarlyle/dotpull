///con_priorityObjectList();

var priorityElementList = ds_list_create();

//EXTREMELY IMPORTANT THAT OBJ BLOCKS ARE AT THE BEGINING OF THE LIST!!!!!!!  SAME WITH FALLING PLATS!!!
with (all) {
    if (x == global.DEACTIVATED_X || y == global.DEACTIVATED_Y) continue; //don't construct objects based on asset reference objects
    
    if (isPuzzleElement){
        //if (instance_place(x, y, obj_block)){
        if (isMovePriority){ 
            ds_list_insert(priorityElementList, 0, self);
            //print(object_index);
        }
        else{
            ds_list_add(priorityElementList, self);
            //print(object_index);
        }
        //print("added this object to ds list");
    }
}

for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (object_get_name(inst.object_index) == "obj_magneticSnare"){
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}

for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (get_parent(inst) == "par_breakableWall"){
        //print("moving breakableWall up to the tippy top of the priority list");
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}
//Cannon objects need to be pushed next because they can break walls
for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (get_parent(inst) == "par_cannon"){
        //print("moving breakableWall up to the tippy top of the priority list");
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}
for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (get_parent(inst) == "par_fallingPlatform"){
        //print("moving falling platform up to the tippy top of the priority list");
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}
for (var i = 0; i < ds_list_size(priorityElementList); i++){
    var inst = ds_list_find_value(priorityElementList, i);
    if (object_get_name(inst.object_index) == "obj_key"){
        ds_list_delete(priorityElementList, i);
        ds_list_insert(priorityElementList, 0, inst);
    }
}

print("-> con_priorityObjectList: priorityElementList size: " + string(ds_list_size(priorityElementList)));

return priorityElementList;
