///isEnum(var checkMe)

/*
    checks if the object past is an enum by seeing if it's a ds_list
    sometimes map_place doesn't return an enum, and is important to know
*/

var checkMe = argument0;

return ds_exists(checkMe, ds_type_list);
