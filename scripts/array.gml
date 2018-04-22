///array(*args);

//print("-> array(...)");

var arr;
for (var i=0;i<argument_count;i+=1)
{
//    print("Arr[" + string(i) + "]: " + string(argument[i]));
    arr[i] = argument[i];
}
return arr;
