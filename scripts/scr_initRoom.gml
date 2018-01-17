///scr_initRoom

//var block1 = instance_create(112, 0, obj_block);

var list = ds_list_create();

//print("Creating list");

//EXTREMELY IMPORTANT THAT OBJ BLOCKS ARE AT THE BEGINING OF THE LIST!!!!!!!  
//THEY ARE WITH DS_LIST_SORT IN ASCENDING ORDER!!!
with (all) {
    if (isPuzzleElement){
        if (instance_place(x, y, obj_block)){
            ds_list_insert(list, 0, self);
        }
        else{
            ds_list_add(list, self);
        }
        //if (isSpike) print("is spike");
        //print("added this object to ds list");
    }
}

ds_list_sort(list, true);

//print("finished creating list");

var arr = roomObjectArrayList(list);

//print("checking array x values");

ds_list_destroy(list);
return arr;
