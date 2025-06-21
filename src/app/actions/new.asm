; ==============================================================================
; src/app/actions/new.asm
;
; Contains the action for the "New" menu item.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import show_confirmation_and_wait

; --- Import data we need to access ---
.import msg_new_selected

; --- Import zeropage variables we use ---
.importzp item_ptr

; --- Export the public functions from this module ---
.export handle_new

.segment "CODE"

; ------------------------------------------------------------------------------
; handle_new
; Sets up the pointer to the "New" message and calls the confirmation routine.
; ------------------------------------------------------------------------------
handle_new:
    lda #<msg_new_selected
    sta item_ptr
    lda #>msg_new_selected
    sta item_ptr+1
    jmp show_confirmation_and_wait
