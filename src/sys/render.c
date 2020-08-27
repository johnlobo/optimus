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
#include "palette/main_palette.h"
#include "comp/bg_optimus_pack.h"
#include "render.h"
#include "../entities/dice.h"
#include "../sprites/dice.h"
#include "../sprites/dots.h"

// Máscara de transparencia
cpctm_createTransparentMaskTable(table_trans, 0x0100, M0, 0);

u8 *const dice_sprites[6] = { sp_dice_0, sp_dice_1, sp_dice_2, sp_dice_3, sp_dice_4, sp_dice_5};
u8 *const dots_sprites[6] = { sp_dots_0, sp_dots_1, sp_dots_2, sp_dots_3, sp_dots_4, sp_dots_5};

void init_render(){
    cpct_setVideoMode(0);
    cpct_setPalette(main_palette, 16);

    //cpct_memcpy((u8*)0xc000, bg_optimus,16000);
    cpct_zx7b_decrunch_s((u8*) DECOMPRESS_VMEM_END, bg_optimus_pack_end); 
}

void render_dice(TRoll *roll, u8 x, u8 y){
    u8 i;
    u8 *pvmem;

    for (i=0; i<roll->count; i++){
        pvmem = cpct_getScreenPtr(CPCT_VMEM_START,x+(i*(SP_DICE_0_W+1)), y);
        cpct_drawSprite(dice_sprites[roll->dice[i].color], pvmem, SP_DICE_0_W, SP_DICE_0_H);
        cpct_drawSpriteMaskedAlignedTable(dots_sprites[roll->dice[i].value - 1], pvmem, SP_DOTS_0_W, SP_DOTS_0_H, table_trans);
        }
}