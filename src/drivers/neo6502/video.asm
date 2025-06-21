; ==============================================================================
; video.asm (Neo6502 Driver)
;
; Low-level video output routines. This is the only place that should
; directly call video-related Neo6502 APIs.
; ==============================================================================

.include "../../includes/system/neo6502.asm"
.include "../../includes/constants.inc"

; Export these functions so other modules can use them
.export drv_screen_clear, drv_print_string, drv_print_newline

; Import zeropage variables that we use from the module that defines them (main.asm)
.importzp item_ptr

.segment "CODE"

; ------------------------------------------------------------------------------
; drv_screen_clear
; ------------------------------------------------------------------------------
drv_screen_clear:
    lda #API_FN_CLEAR_SCREEN
    sta API_FUNCTION
clear_wait_api:
    lda API_COMMAND
    bne clear_wait_api
    lda #API_GROUP_CONSOLE
    sta API_COMMAND
    rts

; ------------------------------------------------------------------------------
; drv_print_string
; Prints the null-terminated string pointed to by `item_ptr`.
; ------------------------------------------------------------------------------
drv_print_string:
    lda #API_FN_WRITE_CHAR
    sta API_FUNCTION
    ldy #0
print_next_char:
    lda API_COMMAND
    bne print_next_char
    lda (item_ptr),y
    beq end_of_string
    sta API_PARAMETERS + 0
    lda #API_GROUP_CONSOLE
    sta API_COMMAND
    iny
    jmp print_next_char
end_of_string:
    rts

; ------------------------------------------------------------------------------
; drv_print_newline
; ------------------------------------------------------------------------------
drv_print_newline:
    lda #API_FN_WRITE_CHAR ; *** FIX: Set API function before printing ***
    sta API_FUNCTION
wait_newline:
    lda API_COMMAND
    bne wait_newline
    lda #CHAR_CR
    sta API_PARAMETERS + 0
    lda #API_GROUP_CONSOLE
    sta API_COMMAND
    rts
