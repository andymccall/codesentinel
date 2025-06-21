; ==============================================================================
; handlers.asm
;
; Contains the application-specific logic, state machine, and event handlers.
; ==============================================================================

.include "../includes/system/neo6502.asm"
.include "../includes/constants.inc"

; --- Import functions we need to call ---
.import drv_screen_clear, drv_wait_for_key, drv_print_string, drv_print_newline
.import ui_draw_menubar, ui_draw_menu

; --- Import data we need to access ---
.import file_menu, edit_menu, help_menu
.import msg_new_selected, msg_open_selected, msg_save_selected
.import msg_cut_selected, msg_copy_selected, msg_paste_selected
.import msg_about_selected, msg_any_key

; --- Import zeropage variables we use ---
.importzp ptr1, item_ptr, app_state

; --- Export the main application loop ---
.export app_loop

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
file_menu_handler_jump: jmp file_menu_handler
edit_menu_handler_jump: jmp edit_menu_handler
help_menu_handler_jump: jmp help_menu_handler

; ------------------------------------------------------------------------------
; Main Menu Bar Handler
; ------------------------------------------------------------------------------
main_handler:
    jsr ui_draw_menubar
main_handler_loop:
    jsr drv_wait_for_key
    cmp #KEY_FILE
    beq select_file
    cmp #KEY_EDIT
    beq select_edit
    cmp #KEY_HELP
    beq select_help
    cmp #KEY_QUIT
    beq do_quit_jump
    jmp main_handler_loop
do_quit_jump:
    jmp quit

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

; ------------------------------------------------------------------------------
; File Menu Handler
; ------------------------------------------------------------------------------
file_menu_handler:
    lda #<file_menu
    sta ptr1
    lda #>file_menu
    sta ptr1+1
    jsr ui_draw_menu
file_menu_loop:
    jsr drv_wait_for_key
    cmp #KEY_NEW
    beq file_handle_new
    cmp #KEY_OPEN
    beq file_handle_open
    cmp #KEY_SAVE
    beq file_handle_save
    cmp #KEY_EXIT_MENU
    beq do_return_to_main_jump
    jmp file_menu_loop
file_handle_new:
    jsr handle_new
    jmp return_to_main
file_handle_open:
    jsr handle_open
    jmp return_to_main
file_handle_save:
    jsr handle_save
    jmp return_to_main
do_return_to_main_jump:
    jmp return_to_main

; ------------------------------------------------------------------------------
; Edit Menu Handler
; ------------------------------------------------------------------------------
edit_menu_handler:
    lda #<edit_menu
    sta ptr1
    lda #>edit_menu
    sta ptr1+1
    jsr ui_draw_menu
edit_menu_loop:
    jsr drv_wait_for_key
    cmp #KEY_CUT
    beq edit_handle_cut
    cmp #KEY_COPY
    beq edit_handle_copy
    cmp #KEY_PASTE
    beq edit_handle_paste
    cmp #KEY_EXIT_MENU
    beq do_return_to_main_jump
    jmp edit_menu_loop
edit_handle_cut:
    jsr handle_cut
    jmp return_to_main
edit_handle_copy:
    jsr handle_copy
    jmp return_to_main
edit_handle_paste:
    jsr handle_paste
    jmp return_to_main

; ------------------------------------------------------------------------------
; Help Menu Handler
; ------------------------------------------------------------------------------
help_menu_handler:
    lda #<help_menu
    sta ptr1
    lda #>help_menu
    sta ptr1+1
    jsr ui_draw_menu
help_menu_loop:
    jsr drv_wait_for_key
    cmp #KEY_ABOUT
    beq help_handle_about
    cmp #KEY_EXIT_MENU
    beq do_return_to_main_jump
    jmp help_menu_loop
help_handle_about:
    jsr handle_about
    jmp return_to_main

; ------------------------------------------------------------------------------
; Common Subroutines
; ------------------------------------------------------------------------------
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
; Action Handlers & Confirmation
; ------------------------------------------------------------------------------
handle_new:
    lda #<msg_new_selected
    sta item_ptr
    lda #>msg_new_selected
    sta item_ptr+1
    jsr show_confirmation_and_wait
    rts
handle_open:
    lda #<msg_open_selected
    sta item_ptr
    lda #>msg_open_selected
    sta item_ptr+1
    jsr show_confirmation_and_wait
    rts
handle_save:
    lda #<msg_save_selected
    sta item_ptr
    lda #>msg_save_selected
    sta item_ptr+1
    jsr show_confirmation_and_wait
    rts
handle_cut:
    lda #<msg_cut_selected
    sta item_ptr
    lda #>msg_cut_selected
    sta item_ptr+1
    jsr show_confirmation_and_wait
    rts
handle_copy:
    lda #<msg_copy_selected
    sta item_ptr
    lda #>msg_copy_selected
    sta item_ptr+1
    jsr show_confirmation_and_wait
    rts
handle_paste:
    lda #<msg_paste_selected
    sta item_ptr
    lda #>msg_paste_selected
    sta item_ptr+1
    jsr show_confirmation_and_wait
    rts
handle_about:
    lda #<msg_about_selected
    sta item_ptr
    lda #>msg_about_selected
    sta item_ptr+1
    jsr show_confirmation_and_wait
    rts

show_confirmation_and_wait:
    jsr drv_screen_clear
    jsr drv_print_string
    jsr drv_print_newline
    jsr drv_print_newline
    lda #<msg_any_key
    sta item_ptr
    lda #>msg_any_key
    sta item_ptr+1
    jsr drv_print_string
    jsr drv_wait_for_key
    rts

