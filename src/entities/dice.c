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
#include "dice.h"

void init_dice(TRoll *roll){
    u8 i;

    roll->count = 6;
    for (i=0;i<6;i++){
        roll->dice[i].value=1;
        roll->dice[i].color=WHITE;
    }
}

void roll_dice(TRoll *roll){
    u8 i;

    for (i=0; i<roll->count; i++){
        roll->dice[i].color=i;
        roll->dice[i].value=(cpct_rand() % 6)+1;
    }
}