; ==============================================================================
; main.asm
;
; Main application entry point and zeropage definitions.
; ==============================================================================

.include "includes/system/neo6502.asm"
.include "includes/constants.inc"
.include "includes/zeropage.inc"

; --- Export zeropage variables so other modules can link to them ---
.exportzp ptr1, ptr2, item_ptr, app_state

.segment "CODE"
; --- Import functions from other modules that we need to call ---
.import app_loop

; --- STARTUP Segment ---
.segment "STARTUP"
    jmp start

; ==============================================================================
; CODE Segment
; ==============================================================================
.segment "CODE"
start:
    lda #STATE_MAIN_MENU
    sta app_state
    jmp app_loop
