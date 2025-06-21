; ==============================================================================
; src/app/actions/save.asm
;
; Contains the action for the "Save" menu item.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import show_confirmation_and_wait

; --- Import data we need to access ---
.import msg_save_selected

; --- Import zeropage variables we use ---
.importzp item_ptr

; --- Export the public functions from this module ---
.export handle_save

.segment "CODE"

; ------------------------------------------------------------------------------
; handle_save
; Sets up the pointer to the "Save" message and calls the confirmation routine.
; ------------------------------------------------------------------------------
handle_save:
    lda #<msg_save_selected
    sta item_ptr
    lda #>msg_save_selected
    sta item_ptr+1
    jmp show_confirmation_and_wait
