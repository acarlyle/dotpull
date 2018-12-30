///get_parentOfEnum(obj_enum enum)

//returns string of the passed argument object's parent

var objEnum = argument0;

return object_get_name(object_get_parent(get_objectFromString(objEnum[| OBJECT.NAME])));
