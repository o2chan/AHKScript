;Using Total Commander to Open Current Folder in File Explorer

#If (WinActive("ahk_class CabinetWClass") and (WinExist("ahk_class TTOTAL_CMD")))
!e::
Send !d
ControlGetText, FILEDIR, Edit1, ahk_class CabinetWClass
Clipboard = %FILEDIR%
WinActivate, ahk_class TTOTAL_CMD
PostMessage, 1075, 2912
Send ^a^v
Sleep, 100
if (WinExist("ahk_class Auto-Suggest Dropdown")) {
	Send {Enter}
}
Send {Enter}
return

#IfWinActive ahk_class TTOTAL_CMD
!e::
PostMessage, 1075, 2029
Sleep, 100
FILEDIR = %Clipboard%
PostMessage, 1075, 1002
ControlGetFocus, FOCUSOBJ, ahk_class TTOTAL_CMD
Send ^a^c
Sleep, 50
FILENAME = %Clipboard%
StringTrimRight TEMPFILENAME, FILENAME, 1
If (TEMPFILENAME = FILEDIR) {
	FILENAME := ""
}
Send #1
Sleep, 300
Clipboard = %FILEDIR%
Send !d
Sleep, 200
Send ^a^v{Enter}
ControlFocus, DirectUIHWND3, A
Sleep, 100
Send %FILENAME%
return
