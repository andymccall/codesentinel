; ==============================================================================
; src/app/handlers/help.asm
;
; Contains the input handler and data for the Help menu state.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import drv_wait_for_key
.import ui_draw_menu
.import handle_about
.import return_to_main

; --- Import zeropage variables we use ---
.importzp ptr1

; --- Export this handler and its data ---
.export help_handler

.segment "CODE"
; ------------------------------------------------------------------------------
; help_handler
; Draws the Help menu and waits for user input.
; ------------------------------------------------------------------------------
help_handler:
    lda #<help_menu
    sta ptr1
    lda #>help_menu
    sta ptr1+1
    jsr ui_draw_menu

help_menu_loop:
    jsr drv_wait_for_key
    cmp #KEY_ABOUT
    beq do_handle_about
    cmp #KEY_EXIT_MENU
    beq do_return_to_main
    jmp help_menu_loop

do_handle_about:
    jsr handle_about
    jmp return_to_main
do_return_to_main:
    jmp return_to_main

.segment "RODATA"
; --- Help Menu Data ---
helpmenu_item_text_1: .asciiz "About (A)"
helpmenu_item_text_2: .asciiz "Back to Main Menu (B)"
helpmenu_items:
    .addr helpmenu_item_text_1, helpmenu_item_text_2
help_menu:
    .addr helpmenu_items
    .byte 2
