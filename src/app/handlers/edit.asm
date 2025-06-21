; ==============================================================================
; src/app/handlers/edit.asm
;
; Contains the input handler and data for the Edit menu state.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import drv_wait_for_key
.import ui_draw_menu
.import handle_cut, handle_copy, handle_paste
.import return_to_main

; --- Import zeropage variables we use ---
.importzp ptr1

; --- Export this handler and its data ---
.export edit_handler

.segment "CODE"
; ------------------------------------------------------------------------------
; edit_handler
; Draws the Edit menu and waits for user input.
; ------------------------------------------------------------------------------
edit_handler:
    lda #<edit_menu
    sta ptr1
    lda #>edit_menu
    sta ptr1+1
    jsr ui_draw_menu

edit_menu_loop:
    jsr drv_wait_for_key
    cmp #KEY_CUT
    beq do_handle_cut
    cmp #KEY_COPY
    beq do_handle_copy
    cmp #KEY_PASTE
    beq do_handle_paste
    cmp #KEY_EXIT_MENU
    beq do_return_to_main
    jmp edit_menu_loop

do_handle_cut:
    jsr handle_cut
    jmp return_to_main
do_handle_copy:
    jsr handle_copy
    jmp return_to_main
do_handle_paste:
    jsr handle_paste
    jmp return_to_main
do_return_to_main:
    jmp return_to_main

.segment "RODATA"
; --- Edit Menu Data ---
editmenu_item_text_1: .asciiz "Cut (X)"
editmenu_item_text_2: .asciiz "Copy (C)"
editmenu_item_text_3: .asciiz "Paste (V)"
editmenu_item_text_4: .asciiz "Back to Main Menu (B)"
editmenu_items:
    .addr editmenu_item_text_1, editmenu_item_text_2, editmenu_item_text_3, editmenu_item_text_4
edit_menu:
    .addr editmenu_items
    .byte 4
