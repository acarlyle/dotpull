///scr_split(string str, string splitByMe)

var splitBy = argument1; //string to split the first string by
var slot = 0;
var splits; //array to hold all splits
var str2 = ""; //var to hold the current split we're working on building

//print(argument0);

var i;
//for (i = 1; i < (string_length(argument[0])+1); i++) {
//   var currStr = string_copy(argument[0], i, 1);
for (i = 1; i < (string_length(argument0)+1); i++) {
    var currStr = string_copy(argument0, i, 1);
    if (currStr == splitBy) {
        splits[slot] = str2; //add this split to the array of all splits
        slot++;
        str2 = "";
    } else {
        str2 = str2 + currStr;
        splits[slot] = str2;
    }
}
//print(splits[0]);
//print(splits[1]);

return splits;
