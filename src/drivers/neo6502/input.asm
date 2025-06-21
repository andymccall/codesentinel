; ==============================================================================
; input.asm (Neo6502 Driver)
;
; Low-level keyboard input routines.
; ==============================================================================

.include "../../includes/system/neo6502.asm"

.export drv_wait_for_key

.segment "CODE"

; ------------------------------------------------------------------------------
; drv_wait_for_key
; Waits for a key and returns the keycode in the Accumulator.
; ------------------------------------------------------------------------------
drv_wait_for_key:
    lda #API_FN_READ_CHAR
    sta API_FUNCTION
wait_api_read:
    lda API_COMMAND
    bne wait_api_read
    lda #API_GROUP_CONSOLE
    sta API_COMMAND
wait_key_press:
    lda API_COMMAND
    bne wait_key_press
    lda API_PARAMETERS + 0
    rts
