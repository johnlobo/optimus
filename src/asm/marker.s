;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;------------------------------------------------------------------------------


;;
;; global functions declaration
;;
.globl cpct_getScreenPtr_asm
.globl cpct_px2byteM0_asm



;******************************
; 	u8 draw_marker(u8 x, u8 y, u8 w, u8 h, u8 t, u8 c){
; 	Desc:	Draws a marker on the mode 0 screen
;	Input:	- x coord
;			- y coord
;			- width
;			- Hight
;			- thickness
;           - color
;	Output:	
;	Destroyed registers: AF, HL, DE, BC
;
;******************************
.globl _draw_marker
_draw_marker::	
    width: .db 0
    y-bottom: .db 0
    color: .db 0
	push ix

	ld ix,#4
	add ix,sp

    ;; store the marker color
    ld a,5 (ix)
    ld h,a
    ld l,a
    call cpct_px2byteM0_asm
    ld (color),a
	
	ld a,0 (ix)				;get x coord
	ld c,a
	ld a,1 (ix)				;get y coord
	ld b,a
    ld de, #0xC000
    call cpct_getScreenPtr_asm

    ld a,2 (ix)             ;get width
    ld b,a

draw_rectangle:
top:
    ld a, (color)
    ld (hl), a
    inc hl
    djnz draw_rectangle
bottom:

    pop ix

	ret