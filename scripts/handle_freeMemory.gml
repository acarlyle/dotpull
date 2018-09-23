///handle_freeMemory()

print(" -> handle_freeMemory()");

//Destroy 
with (all){
    if object_index == obj_layer continue;
    if object_index == obj_control continue;
    
    if (x == global.DEACTIVATED_X || y == global.DEACTIVATED_Y){
        instance_destroy();
    }
}

//with (all) if (isPuzzleElement) handle_destroyThisObjectStacks(self);
//with (par_surface) instance_destroy();
