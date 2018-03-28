///scr_pathBetween(par_obect objectFrom, par_object objectTo)

/*
    This script returns true if there's a pullable path between 2 objects.
*/

var oFrom = argument0;
var oTo = argument1;

var posX = oFrom.x;
var posY = oFrom.y;
var toPosX = oTo.x;
var toPosY = oTo.y;

var badObjList = array(par_obstacle, par_robot); 

//check above objectFrom for objectTo
while(instance_place(posX, posY, par_platform)){
    posY -= global.TILE_SIZE;
    
    if (scr_tileContains(posX, posY, obj_mirptr)){
        var mirptr = instance_place(posX, posY, obj_mirptr);
        posX = mirptrPtr.x;
        posY = mirptrPtr.y;
    }
    if ((posX == toPosX && posY == toPosY)){
        print("omg is object !");
        return true;
    }
    if (scr_tileContains(posX, posY, badObjList)){
        break;
    }
}
posX = oFrom.x;
posY = oFrom.y;
//check below objectFrom for objectTo
while(instance_place(posX, posY, par_platform)){
    posY += global.TILE_SIZE;
    
    if (scr_tileContains(posX, posY, obj_mirptr)){
        var mirptr = instance_place(posX, posY, obj_mirptr);
        posX = mirptrPtr.x;
        posY = mirptrPtr.y;
    }
    if ((posX == toPosX && posY == toPosY)){
        print("omg is object !");
        return true;
    }
    if (scr_tileContains(posX, posY, badObjList)){
        break;
    }
}
posX = oFrom.x;
posY = oFrom.y;
//check right objectFrom for objectTo
while(instance_place(posX, posY, par_platform)){
    posX += global.TILE_SIZE;
    
    if (scr_tileContains(posX, posY, obj_mirptr)){
        var mirptr = instance_place(posX, posY, obj_mirptr);
        posX = mirptrPtr.x;
        posY = mirptrPtr.y;
    }
    if ((posX == toPosX && posY == toPosY)){
        print("omg is object !");
        return true;
    }
    if (scr_tileContains(posX, posY, badObjList)){
        break;
    }
}
posX = oFrom.x;
posY = oFrom.y;
//check left objectFrom for objectTo
while(instance_place(posX, posY, par_platform)){
    posX -= global.TILE_SIZE;
    
    if (scr_tileContains(posX, posY, obj_mirptr)){
        var mirptr = instance_place(posX, posY, obj_mirptr);
        posX = mirptrPtr.x;
        posY = mirptrPtr.y;
    }
    if ((posX == toPosX && posY == toPosY)){
        print("omg is object !");
        return true;
    }
    if (scr_tileContains(posX, posY, badObjList)){
        break;
    }
}
posX = oFrom.x;
posY = oFrom.y;
//check upleft objectFrom for objectTo
while(instance_place(posX, posY, par_platform)){
    posX -= global.TILE_SIZE;
    posY -= global.TILE_SIZE;
    
    if (scr_tileContains(posX, posY, obj_mirptr)){
        var mirptr = instance_place(posX, posY, obj_mirptr);
        posX = mirptrPtr.x;
        posY = mirptrPtr.y;
    }
    if ((posX == toPosX && posY == toPosY)){
        print("omg is object !");
        return true;
    }
    if (scr_tileContains(posX, posY, badObjList)){
        break;
    }
}
posX = oFrom.x;
posY = oFrom.y;
//check upright objectFrom for objectTo
while(instance_place(posX, posY, par_platform)){
    posX += global.TILE_SIZE;
    posY -= global.TILE_SIZE;
    
    if (scr_tileContains(posX, posY, obj_mirptr)){
        var mirptr = instance_place(posX, posY, obj_mirptr);
        posX = mirptrPtr.x;
        posY = mirptrPtr.y;
    }
    if ((posX == toPosX && posY == toPosY)){
        print("omg is object !");
        return true;
    }
    if (scr_tileContains(posX, posY, badObjList)){
        break;
    }
}
posX = oFrom.x;
posY = oFrom.y;
//check downleft objectFrom for objectTo
while(instance_place(posX, posY, par_platform)){
    posX -= global.TILE_SIZE;
    posY += global.TILE_SIZE;
    
    if (scr_tileContains(posX, posY, obj_mirptr)){
        var mirptr = instance_place(posX, posY, obj_mirptr);
        posX = mirptrPtr.x;
        posY = mirptrPtr.y;
    }
    if ((posX == toPosX && posY == toPosY)){
        print("omg is object !");
        return true;
    }
    if (scr_tileContains(posX, posY, badObjList)){
        break;
    }
}
posX = oFrom.x;
posY = oFrom.y;
//check downright objectFrom for objectTo
while(instance_place(posX, posY, par_platform)){
    posX += global.TILE_SIZE;
    posY += global.TILE_SIZE;
    
    if (scr_tileContains(posX, posY, obj_mirptr)){
        var mirptr = instance_place(posX, posY, obj_mirptr);
        posX = mirptrPtr.x;
        posY = mirptrPtr.y;
    }
    if ((posX == toPosX && posY == toPosY)){
        print("omg is object !");
        return true;
    }
    if (scr_tileContains(posX, posY, badObjList)){
        break;
    }
}
return false;
