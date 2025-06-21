; ==============================================================================
; src/app/handlers/main.asm
;
; Contains the input handler for the Main Menu Bar state.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import drv_wait_for_key
.import ui_draw_menubar
.import select_file, select_edit, select_help
.import quit

; --- Export the public functions from this module ---
.export main_handler

.segment "CODE"

; ------------------------------------------------------------------------------
; main_handler
; Draws the main menu bar and waits for user input.
; ------------------------------------------------------------------------------
main_handler:
    jsr ui_draw_menubar

main_handler_loop:
    jsr drv_wait_for_key
    cmp #KEY_FILE
    beq do_select_file
    cmp #KEY_EDIT
    beq do_select_edit
    cmp #KEY_HELP
    beq do_select_help
    cmp #KEY_QUIT
    beq do_quit
    jmp main_handler_loop

do_select_file:
    jmp select_file
do_select_edit:
    jmp select_edit
do_select_help:
    jmp select_help
do_quit:
    jmp quit
