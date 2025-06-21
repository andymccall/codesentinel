; ==============================================================================
; src/app/actions/paste.asm
;
; Contains the action for the "Paste" menu item.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import show_confirmation_and_wait

; --- Import data we need to access ---
.import msg_paste_selected

; --- Import zeropage variables we use ---
.importzp item_ptr

; --- Export the public functions from this module ---
.export handle_paste

.segment "CODE"

; ------------------------------------------------------------------------------
; handle_paste
; Sets up the pointer to the "Paste" message and calls the confirmation routine.
; ------------------------------------------------------------------------------
handle_paste:
    lda #<msg_paste_selected
    sta item_ptr
    lda #>msg_paste_selected
    sta item_ptr+1
    jmp show_confirmation_and_wait
