; ==============================================================================
; src/app/handlers/file.asm
;
; Contains the input handler and data for the File menu state.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import drv_wait_for_key
.import ui_draw_menu
.import handle_new, handle_open, handle_save
.import return_to_main

; --- Import zeropage variables we use ---
.importzp ptr1

; --- Export this handler and its data ---
.export file_handler

.segment "CODE"
; ------------------------------------------------------------------------------
; file_handler
; Draws the File menu and waits for user input.
; ------------------------------------------------------------------------------
file_handler:
    lda #<file_menu
    sta ptr1
    lda #>file_menu
    sta ptr1+1
    jsr ui_draw_menu

file_menu_loop:
    jsr drv_wait_for_key
    cmp #KEY_NEW
    beq do_handle_new
    cmp #KEY_OPEN
    beq do_handle_open
    cmp #KEY_SAVE
    beq do_handle_save
    cmp #KEY_EXIT_MENU
    beq do_return_to_main
    jmp file_menu_loop

do_handle_new:
    jsr handle_new
    jmp return_to_main
do_handle_open:
    jsr handle_open
    jmp return_to_main
do_handle_save:
    jsr handle_save
    jmp return_to_main
do_return_to_main:
    jmp return_to_main

.segment "RODATA"
; --- File Menu Data ---
filemenu_item_text_1: .asciiz "New (N)"
filemenu_item_text_2: .asciiz "Open (O)"
filemenu_item_text_3: .asciiz "Save (S)"
filemenu_item_text_4: .asciiz "----"
filemenu_item_text_5: .asciiz "Back to Main Menu (B)"
filemenu_items:
    .addr filemenu_item_text_1, filemenu_item_text_2, filemenu_item_text_3, filemenu_item_text_4, filemenu_item_text_5
file_menu:
    .addr filemenu_items
    .byte 5
