///scr_createSurface(var surface, var m_room, var m_xPos = 0, var m_yPos = 0, var m_xScale = 1, var m_yScale = 1, var m_rot = 0, var m_color = c_white, var m_alpha = .5)

var surface = argument0;
var m_room = argument1;
var m_xPos = argument2;
var m_yPos = argument3;
var m_xScale = argument4;
var m_yScale = argument5;
var m_rot = argument6;
var m_color = argument7;
var m_alpha = argument8;

//print(" -> scr_createSurface of " + string(m_room));

var surfaceInf = instance_create(global.DEACTIVATED_X, global.DEACTIVATED_Y, surface);
surfaceInf.m_room = m_room;
surfaceInf.m_xPos = m_xPos;
surfaceInf.m_yPos = m_yPos;
surfaceInf.m_xScale = m_xScale;
surfaceInf.m_yScale = m_yScale;
surfaceInf.m_rot = m_rot;
surfaceInf.m_color = m_color;
surfaceInf.m_alpha = m_alpha;
