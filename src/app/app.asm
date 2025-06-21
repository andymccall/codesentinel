; ==============================================================================
; src/app/app.asm
;
; Contains the main application loop, state dispatcher, and common subroutines.
; ==============================================================================

.include "../includes/system/neo6502.asm"
.include "../includes/constants.inc"

; --- Import functions we need to call ---
.import drv_screen_clear, drv_wait_for_key, drv_print_string, drv_print_newline
.import main_handler, file_handler, edit_handler, help_handler

; --- Import data we need to access ---
.import msg_any_key

; --- Import zeropage variables we use ---
.importzp app_state, item_ptr

; --- Export the public functions from this module ---
.export app_loop, quit, return_to_main, select_file, select_edit, select_help
.export show_confirmation_and_wait

.segment "CODE"
; ------------------------------------------------------------------------------
; Main Application Loop / State Dispatcher
; ------------------------------------------------------------------------------
app_loop:
    jsr drv_screen_clear
    lda app_state
    cmp #STATE_MAIN_MENU
    beq main_handler_jump
    cmp #STATE_FILE_MENU
    beq file_menu_handler_jump
    cmp #STATE_EDIT_MENU
    beq edit_menu_handler_jump
    cmp #STATE_HELP_MENU
    beq help_menu_handler_jump
    jmp quit

main_handler_jump:      jmp main_handler
file_menu_handler_jump: jmp file_handler
edit_menu_handler_jump: jmp edit_handler
help_menu_handler_jump: jmp help_handler

; ------------------------------------------------------------------------------
; Common Subroutines
; ------------------------------------------------------------------------------
select_file:
    lda #STATE_FILE_MENU
    sta app_state
    jmp app_loop

select_edit:
    lda #STATE_EDIT_MENU
    sta app_state
    jmp app_loop

select_help:
    lda #STATE_HELP_MENU
    sta app_state
    jmp app_loop

return_to_main:
    lda #STATE_MAIN_MENU
    sta app_state
    jmp app_loop

quit:
    jsr drv_screen_clear
wait_api_reset:
    lda API_COMMAND
    bne wait_api_reset
    lda #API_FN_RESET
    sta API_FUNCTION
    lda #API_GROUP_SYSTEM
    sta API_COMMAND
    rts

; ------------------------------------------------------------------------------
; show_confirmation_and_wait
;
; A generic routine to display a message and wait for a keypress.
; Input: `item_ptr` must point to the message to be displayed.
; ------------------------------------------------------------------------------
show_confirmation_and_wait:
    jsr drv_screen_clear
    jsr drv_print_string    ; Print the message from item_ptr
    jsr drv_print_newline
    jsr drv_print_newline
    ; Now print the "any key" prompt
    lda #<msg_any_key
    sta item_ptr
    lda #>msg_any_key
    sta item_ptr+1
    jsr drv_print_string
    jsr drv_wait_for_key    ; Wait for user input
    rts
