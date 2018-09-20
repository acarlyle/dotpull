///print2dArray(var 2dArray)

var arr = argument0;

print(" ");
print("-> print2dArray() [Note: the '|' are added in this script; they are not in the array]");

var printLine = "";
for (var i = 0; i < array_height_2d(arr); i++;){
    printLine = "";
    for (var j = 0; j < array_length_2d(arr, i); j++;){
        if arr[i, j] != "" printLine += ("|" + string(arr[i, j]));
    } 
    print(string(printLine));   
}

print("print2dArray: Done printing!");
print(" ");
