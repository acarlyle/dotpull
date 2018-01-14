///roomObjectArrList(ds_list list)

var arr;
//print(ds_list_size(argument0));
for (var i = 0; i < ds_list_size(argument0); i++){
    arr[i] = ds_list_find_value(argument0, i);
    //print("Added thing to arr");
    //print(arr[i].x);
    //print(i);
}

return arr;
