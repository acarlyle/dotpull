///move_blackHole(par_object object)

/*
    This function handles:
        obj_blackHole
        
    If a robot or a pullable object is lined up with the black hole, it will be sucked
    towards it one tile.  If the object or robot collides with the black hole,
    it will be torn apart.  
*/

var blackHole = argument0;

print("-> move_blackHole(" + object_get_name(object.object_index) + ")");



//handle pulling pullable objects towards the hole
with(par_object){
    if (canPull){
        if scr_pathBetween(blackHole, self){
            print("PATH EXISTS! for " + string(object_get_name(self.object_index)) + " : )");
            //all this logic ignores miraptrs :\
            if (self.x == blackHole.x){
                if (self.y < blackHole.y){
                    self.y += global.TILE_SIZE;
                    print("Moved down to: " + string(self.y));
                }
                else{
                    self.y -= global.TILE_SIZE;
                }
            }
            else if (self.y == blackHole.y){
                if (self.x < blackHole.x){
                    self.x += global.TILE_SIZE;
                }
                else{
                    self.x -= global.TILE_SIZE;
                }
            }
            else if (self.y < blackHole.y && self.x < blackHole.x){ //downright
                self.y += global.TILE_SIZE;
                self.x += global.TILE_SIZE;
            }
            else if (self.y > blackHole.y && self.x < blackHole.x){ //upright
                self.y -= global.TILE_SIZE;
                self.x += global.TILE_SIZE;
            }
            else if (self.y < blackHole.y && self.x > blackHole.x){ //downleft
                self.y += global.TILE_SIZE;
                self.x -= global.TILE_SIZE;
            }
            else if (self.y > blackHole.y && self.x > blackHole.x){ //upleft
                self.y -= global.TILE_SIZE;
                self.x -= global.TILE_SIZE;
            }
            else{ //maybe if all else fails, check if there's a mirptr pathBetween and go to it ?
                print("Mirptr time ?");
            }
            //robot needs his current pos local variables updated to his new position
            if (get_parent(self) == "par_robot") scr_updateCurRobotPos(self);
        }
        else{
            print("PATH does not exist for " + string(object_get_name(self.object_index)))
        }
        
        print("here!");
        
        print(string(self.x) + ", " + string(self.y));
        
        if(scr_tileContains(blackHole.x, blackHole.y, array(self))){
            print("should disable obj");
            scr_disableObj(self);
        }
        
    }
}
