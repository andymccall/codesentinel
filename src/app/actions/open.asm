; ==============================================================================
; src/app/actions/open.asm
;
; Contains the action for the "Open" menu item.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; --- Import functions we need to call ---
.import show_confirmation_and_wait

; --- Import data we need to access ---
.import msg_open_selected

; --- Import zeropage variables we use ---
.importzp item_ptr

; --- Export the public functions from this module ---
.export handle_open

.segment "CODE"

; ------------------------------------------------------------------------------
; handle_open
; Sets up the pointer to the "Open" message and calls the confirmation routine.
; ------------------------------------------------------------------------------
handle_open:
    lda #<msg_open_selected
    sta item_ptr
    lda #>msg_open_selected
    sta item_ptr+1
    jmp show_confirmation_and_wait
