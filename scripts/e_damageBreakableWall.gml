///e_damageBreakableWall(par_wall)

//damage this breakable wall

breakableWall = argument0;
if (breakableWall.hitsLeft > 0){
    breakableWall.hitsLeft--;
    print("Hits left: " + string(breakableWall.hitsLeft));
    if (breakableWall.hitsLeft == 0){
        breakableWall.isDeactivated = true;
    }
    breakableWall.image_index++;
}
