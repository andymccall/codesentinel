; ==============================================================================
; zeropage.inc
;
; Defines all variables that reside in the zeropage for fast access.
; ==============================================================================

.segment "ZEROPAGE"
ptr1:       .res 2  ; General purpose pointer 1
ptr2:       .res 2  ; General purpose pointer 2
item_ptr:   .res 2  ; Pointer to the current menu item's text string.
app_state:  .res 1  ; Holds the current state of the application.