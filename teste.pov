#include "colors.inc"
#include "textures.inc"
#include "axis_xyz.inc"

camera 
{   ultra_wide_angle angle  60
    location  < 5.0 , 6.0 ,-8.0> 
    look_at   < 1.5 , 3.0 , 0.0>
}

light_source{<1800,2500,-2500> color White}

#declare Orange_Yellow = color rgb<1,0.77,0>;

sphere
{   <0,0,0>,1 hollow
    texture
    {   pigment
        {   gradient <0,1,0>
            color_map{[0.0 color Orange_Yellow]
                      [0.5 color White]
                      [1.0 color Orange_Yellow]}
            quick_color White
            scale 2 translate<0,-1,0> 
        }
        finish {ambient 1 diffuse 0}
    }
    scale 10000
}


#declare RED   = texture
                 {   pigment{color rgb<0.8,0,0.45> }
                     finish {ambient 0.1 diffuse 0.9 phong 1}
                 }

#declare WHITE = texture
                 {   pigment{color rgb<1,1,1> }
                     finish {ambient 0.1 diffuse 0.9 phong 1}
                 }
                 
                 
#include "stones.INC"
#include "stones2.INC"

#declare Ball = 
   sphere  
   {   <0,0,0>,0.70 scale <1,1.5,1>  
       texture
       {   T_Stone3   scale 1.5
           finish {ambient 0.2 diffuse 0.8 phong 0.3 phong_size 90}
       }
   }

#declare Radius0 =  1.5;
#declare NR      =  9.1; //number of revolutions
#declare NpR     =   30; //number of elements per revolution 
#declare Scale   = 0.78; //per revolution
#declare HpR     =  1.6;

#local Hd        = HpR/NpR;
#local Scale_p   = pow(Scale,1/360);
#local Scale_pE  = pow(Scale_p,360/NpR);
#local Old_S     = Scale_pE;
#local Old_H     = Hd;

union
{   #declare Nr = 0;         // start
    #declare EndNr = NR*NpR; // end
    #while (Nr< EndNr) 
        object
        {   Ball 
            translate<Radius0,0,0> 
            scale Old_S 
            translate<0,Old_H,0> 
            rotate<0,Nr * 360/NpR ,0>
        } 
        #declare Nr = Nr + 1;  // next Nr
        #declare Old_S = Scale_pE*Old_S;
        #declare Old_H = Old_H+Hd*Old_S;
    #end // --------------- end of loop ---------------------------
    rotate<0,0,0>
}

