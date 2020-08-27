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
.globl _draw_marker



;******************************
; 	u8 draw_marker(u8 x, u8 y, u8 w, u8 h, u8 t, u8 c){
; 	Desc:	Draws a marker on the mode 0 screen
;	Input:	- x coord
;			- y coord
;			- width
;			- Hight
;			- thickness
;           - color1
;           - color2
;	Output:	
;	Destroyed registers: AF, HL, DE, BC
;
;******************************

_draw_marker::

	push ix

	ld ix,#4
	add ix,sp

    ;; calculate and store the marker color
    ld h,5 (ix)
    ld l,6 (ix)
    call cpct_px2byteM0_asm
    ld (color),a

top_line:
    ;; calculate top left screen address
	ld c,0 (ix)				;get x coord
	ld b,1 (ix)				;get y coord
    ld de, #0xC000
    call cpct_getScreenPtr_asm

    ld b,2 (ix)             ;get width

    call _draw_line          ;draw top line

columns:
    ld c,0 (ix)				;get x coord
    ld b,1 (ix)				;get y coord
    inc b                   ;one line below top
    ld e,2 (ix)				;get width
    ld d,3 (ix)				;get height
    dec d                   ;minus top and bottom line

    call _draw_columns

bottom_line:
    ;; calculate bottom left screen address
    ld c,0 (ix)				;get x coord
	ld a,1 (ix)				;get y coord
    ld b,3 (ix)             ;get height
    add b                   ;y + height
    ld b,a                  
    ld de, #0xC000
    call cpct_getScreenPtr_asm

    ld b,2 (ix)             ;get width
    
    call _draw_line          ;draw bottom line

    pop ix

	ret

    color: .db 0

;******************************
; 	Desc:	Draws a horizontal line on the mode 0 screen
;	Input:	- HL screen address
;			- b width 
;	Output:	
;	Destroyed registers: AF, HL, DE, BC
;
;******************************
_draw_line::
    ld a, (color)
loop:
    ld (hl), a
    inc hl
    djnz loop
    ret

;******************************
; 	Desc:	Draws two columns on the mode 0 screen
;	Input:	- c x_coord
;			- b y_coord
;           - d height
;           - e width
;	Output:	
;	Destroyed registers: AF, HL, DE, BC
;
;******************************
_draw_columns::
loop_2:
    push bc
    push de
    ld de, #0xC000
    call cpct_getScreenPtr_asm  ;get screen address
    ld a, (color)
left_column:
    ld (hl), a
right_column:
    pop de
    push de
    ld c,e                   ;get width
    ld b,#0
    add hl,bc
    dec hl
    ld (hl), a

    pop de
    pop bc

    inc b                   ;increase y coord
    dec d                   ;decrease height
    ld a,d
    or a                    ;reach height limit??
    jr nz, loop_2
    ret
