///scr_initRoom

//var block1 = instance_create(112, 0, obj_block);

var list = ds_list_create();

//print("Creating list");
with (all) {
    if (isPuzzleElement){
        ds_list_add(list, self);
        //print("added this object to ds list");
    }
}
//print("finished creating list");

var arr = roomObjectArrayList(list);

//print("checking array x values");

ds_list_destroy(list);
return arr;
