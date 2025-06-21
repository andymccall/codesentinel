; ==============================================================================
; main.asm
;
; Main application entry point and data definitions.
; ==============================================================================

.include "includes/system/neo6502.asm"
.include "includes/constants.inc"
.include "includes/zeropage.inc"

; --- Export zeropage variables so other modules can link to them ---
.exportzp ptr1, ptr2, item_ptr, app_state

; --- Export data labels so the handlers module can use them ---
.export file_menu, edit_menu, help_menu
.export msg_new_selected, msg_open_selected, msg_save_selected
.export msg_cut_selected, msg_copy_selected, msg_paste_selected
.export msg_about_selected, msg_any_key

.segment "CODE"
; --- Import functions from other modules that we need to call ---
.import app_loop

; --- STARTUP Segment ---
.segment "STARTUP"
    jmp start

; ==============================================================================
; DATA Segment - All application-specific data lives here.
; ==============================================================================
.segment "DATA"

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

; --- Help Menu Data ---
helpmenu_item_text_1: .asciiz "About (A)"
helpmenu_item_text_2: .asciiz "Back to Main Menu (B)"
helpmenu_items:
    .addr helpmenu_item_text_1, helpmenu_item_text_2
help_menu:
    .addr helpmenu_items
    .byte 2

; Action confirmation messages
msg_new_selected:   .asciiz "Action: New selected."
msg_open_selected:  .asciiz "Action: Open selected."
msg_save_selected:  .asciiz "Action: Save selected."
msg_cut_selected:   .asciiz "Action: Cut selected."
msg_copy_selected:  .asciiz "Action: Copy selected."
msg_paste_selected: .asciiz "Action: Paste selected."
msg_about_selected: .asciiz "Action: About selected."
msg_any_key:        .asciiz "Press any key to continue..."


; ==============================================================================
; CODE Segment
; ==============================================================================
.segment "CODE"
start:
    lda #STATE_MAIN_MENU
    sta app_state
    jmp app_loop
