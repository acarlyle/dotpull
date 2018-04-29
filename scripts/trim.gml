///trim(var str)

/*
    This string function trims the last character of the 
    str arg.
*/

var str = argument0;

if (strlen(str) > 0) str = string_delete(str, strlen(str), 1);

return str;
