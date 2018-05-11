///get_spriteFromObjStr(var objStr)

var objStr = argument0;

var objStrSplitBy_ = scr_split(objStr, "_");
var spriteStr = "spr_" + string(objStrSplitBy_[1]);
print(spriteStr);
//print(asset_get_index(spriteStr));
return asset_get_index(spriteStr);
