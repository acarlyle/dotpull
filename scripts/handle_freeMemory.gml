///handle_freeMemory()

/*
    gets rid of objects construced at deactivated pos (for map_place checking, the object index
    needs to exist, which is why they are drawn into the game)
*/

print(" -> handle_freeMemory() [doesn't do anything currently]");

//Destroy 
with (all){
    if (object_get_parent(object_index) == par_control) continue; //Don't delete control objs
    
    //print("handle_freeMemory:  parent is : " + string(object_get_name(object_get_parent(object_index))));
    
    if (x == global.DEACTIVATED_X || y == global.DEACTIVATED_Y){
    
        print("handle_freeMemory: destroying " + string(object_get_name(object_index)) + " at: " + string(x) + "," +  string(y));
        
        //instance_destroy();
    }
}

//with (all) if (isPuzzleElement) handle_destroyThisObjectStacks(self);
//with (par_surface) instance_destroy();
