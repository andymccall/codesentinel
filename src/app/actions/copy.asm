; ==============================================================================
; src/app/actions/copy.asm
;
; Contains the action for the "Copy" menu item.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import show_confirmation_and_wait

; --- Import data we need to access ---
.import msg_copy_selected

; --- Import zeropage variables we use ---
.importzp item_ptr

; --- Export the public functions from this module ---
.export handle_copy

.segment "CODE"

; ------------------------------------------------------------------------------
; handle_copy
; Sets up the pointer to the "Copy" message and calls the confirmation routine.
; ------------------------------------------------------------------------------
handle_copy:
    lda #<msg_copy_selected
    sta item_ptr
    lda #>msg_copy_selected
    sta item_ptr+1
    jmp show_confirmation_and_wait
