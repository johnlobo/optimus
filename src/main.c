//-----------------------------LICENSE NOTICE------------------------------------
//  This file is part of CPCtelera: An Amstrad CPC Game Engine
//  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//------------------------------------------------------------------------------

#include <cpctelera.h>
#include "sys/render.h"
#include "entities/dice.h"

TRoll diceRoll, diceDiscarded, diceSelected;

void main(void) {
   u8 color1, color2, aux_color;

   cpct_disableFirmware();
   
   init_render();

   init_dice(&diceRoll);
   roll_dice(&diceRoll);
   render_dice(&diceRoll, 30, 14);

   color1=4;
   color2=6;

   draw_marker(28, 12, 10, 18, 2, color1,color2);

   // Loop forever
   while (1){
      cpct_scanKeyboard();
      if (cpct_isAnyKeyPressed()){
         roll_dice(&diceRoll);
         render_dice(&diceRoll, 30, 14);
         aux_color = color1;
         color1 = color2;
         color2 = aux_color;
         draw_marker(28, 12, 10, 18, 2, color1,color2);
      }
   };

}
