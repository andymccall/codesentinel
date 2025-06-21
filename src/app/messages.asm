; ==============================================================================
; src/app/messages.asm
;
; Defines all application-specific user-facing message strings.
; ==============================================================================

; --- Export data labels so other modules can use them ---
.export msg_new_selected
.export msg_open_selected
.export msg_save_selected
.export msg_cut_selected
.export msg_copy_selected
.export msg_paste_selected
.export msg_about_selected
.export msg_any_key

.segment "DATA"

; Action confirmation messages
msg_new_selected:   .asciiz "Action: New selected."
msg_open_selected:  .asciiz "Action: Open selected."
msg_save_selected:  .asciiz "Action: Save selected."
msg_cut_selected:   .asciiz "Action: Cut selected."
msg_copy_selected:  .asciiz "Action: Copy selected."
msg_paste_selected: .asciiz "Action: Paste selected."
msg_about_selected: .asciiz "Action: About selected."
msg_any_key:        .asciiz "Press any key to continue..."
