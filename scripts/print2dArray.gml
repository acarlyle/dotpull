///print2dArray(var 2dArray, bool separator (if false, print array as is) )

var arr = argument0;
var separator = argument1; //if true, split array with '|', otherwise print as is

var tileSepChar = "";
if (separator) tileSepChar = "|";

print(" ");
print("->print2dArray()");

var printLine = "";
for (var i = 0; i < array_height_2d(arr); i++;){
    printLine = "";
    for (var j = 0; j < array_length_2d(arr, i); j++;){
        if arr[i, j] != "" printLine += (tileSepChar + string(arr[i, j]));
    } 
    print(string(printLine));   
}

print("print2dArray: Done printing!");
print(" ");
