; ==============================================================================
; menu.asm (UI Library)
;
; Platform-agnostic menu drawing and handling logic.
; ==============================================================================

.include "../includes/constants.inc"

; Import any driver functions this module will need
.import drv_print_string, drv_print_newline

; Import zeropage variables we need from the module that defines them (main.asm)
.importzp item_ptr, ptr1, ptr2

; Export the public functions of this module
.export ui_draw_menu, ui_draw_menubar

.segment "CODE"

; --- Data local to this module ---
menubar_text: .asciiz "(F)ile  (E)dit  (H)elp                         (Q)uit"

; ------------------------------------------------------------------------------
; ui_draw_menubar
; ------------------------------------------------------------------------------
ui_draw_menubar:
    lda #<menubar_text
    sta item_ptr
    lda #>menubar_text
    sta item_ptr+1
    jsr drv_print_string
    jsr drv_print_newline
    rts

; ------------------------------------------------------------------------------
; ui_draw_menu
; Draws the menu pointed to by ptr1. This version loops backwards.
; ------------------------------------------------------------------------------
ui_draw_menu:
    ldy #0
    lda (ptr1),y
    sta ptr2
    iny
    lda (ptr1),y
    sta ptr2+1
    iny
    lda (ptr1),y
    tax
outer_loop:
    dex
    bmi end_output
    txa
    asl a
    tay
    lda (ptr2),y
    sta item_ptr
    iny
    lda (ptr2),y
    sta item_ptr+1
    jsr drv_print_string
    jsr drv_print_newline
    jmp outer_loop
end_output:
    rts
