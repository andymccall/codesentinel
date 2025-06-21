; ==============================================================================
; src/app/actions/cut.asm
;
; Contains the action for the "Cut" menu item.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import show_confirmation_and_wait

; --- Import data we need to access ---
.import msg_cut_selected

; --- Import zeropage variables we use ---
.importzp item_ptr

; --- Export the public functions from this module ---
.export handle_cut

.segment "CODE"

; ------------------------------------------------------------------------------
; handle_cut
; Sets up the pointer to the "Cut" message and calls the confirmation routine.
; ------------------------------------------------------------------------------
handle_cut:
    lda #<msg_cut_selected
    sta item_ptr
    lda #>msg_cut_selected
    sta item_ptr+1
    jmp show_confirmation_and_wait
