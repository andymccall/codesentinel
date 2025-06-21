; ==============================================================================
; constants.inc
;
; Defines global constants for the application.
; ==============================================================================

; Application States
STATE_MAIN_MENU = 0
STATE_FILE_MENU = 1
STATE_EDIT_MENU = 2
STATE_HELP_MENU = 3

; Menu Control Keys
KEY_FILE        = $66   ; 'f'
KEY_EDIT        = $65   ; 'e'
KEY_HELP        = $68   ; 'h'
KEY_QUIT        = $71   ; 'q'

; File Menu Keys
KEY_NEW         = $6E   ; 'n'
KEY_OPEN        = $6F   ; 'o'
KEY_SAVE        = $73   ; 's'
KEY_EXIT_MENU   = $62   ; 'b' (to exit a submenu)

; Edit Menu Keys
KEY_CUT         = $78   ; 'x'
KEY_COPY        = $63   ; 'c'
KEY_PASTE       = $76   ; 'v'

; Help Menu Keys
KEY_ABOUT       = $61   ; 'a'

; Useful character constants
CHAR_CR = $0d
