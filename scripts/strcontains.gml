///strcontains(var str, var substr)

/*
    returns true if the str contains the substr
*/

var str = argument0;
var substr = argument1;

if (string_pos(substr, str) != 0) return true;

return false;
