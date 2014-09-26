;Using 3rd Party File Explorer for File Selection in Open/Save as Dialogs

#IfWinActive ahk_class #32770
!s::
Send !d
ControlGetText, FILEDIR, Edit2, ahk_class #32770
Clipboard = %FILEDIR%
If (WinExist("ahk_class TTOTAL_CMD")) {
	WinActivate, ahk_class TTOTAL_CMD
	PostMessage, 1075, 2912
	Send ^a^v
	Sleep, 100
	if (WinExist("ahk_class Auto-Suggest Dropdown")) {
		Send {Enter}
	}
	Send {Enter}
} else {
	Send #+1
	Sleep, 500
	Send !d^v{Enter}
}
return

#IfWinExist, ahk_class #32770
!s::
If (WinActive("ahk_class TTOTAL_CMD")) {
	PostMessage, 1075, 2029
	Sleep, 100
	FILEDIR = %Clipboard%
	PostMessage, 1075, 2017
	Sleep, 100
	FILENAME = %Clipboard%
	WinActivate, ahk_class #32770
	Send !d
	Clipboard = %FILEDIR%
	Send ^a^v{Enter}
	ControlFocus, DirectUIHWND3, A
	ControlFocus, DirectUIHWND2, A
	Send %FILENAME%
} else if(WinActive("ahk_class CabinetWClass")) {
	ControlGetFocus, NOWFOCUS, A
	If (NOWFOCUS = "DirectUIHWND3") {
		Send {F2}^a^c{Esc}
		FILENAME = %Clipboard%
	}
	Send !d
	ControlGetText, FILEDIR, Edit1, ahk_class CabinetWClass
	WinActivate, ahk_class #32770
	Send !d
	Clipboard = %FILEDIR%
	Send ^a^v{Enter}
	ControlFocus, DirectUIHWND3, A
	ControlFocus, DirectUIHWND2, A
	Send %FILENAME%
} else {
	Send !s
}
return
!a::
if(WinActive("ahk_class CabinetWClass")) {
	ControlGetFocus, NOWFOCUS, A
	If (NOWFOCUS = "DirectUIHWND3") {
		Send {F2}^a^c{Esc}
		FILENAME = %Clipboard%
	}
	Send !d
	ControlGetText, FILEDIR, Edit1, ahk_class CabinetWClass
	Send !{F4}
	WinActivate, ahk_class #32770
	Send !d
	Clipboard = %FILEDIR%
	Send ^a^v{Enter}
	ControlFocus, DirectUIHWND3, A
	ControlFocus, DirectUIHWND2, A
	Send %FILENAME%
} else {
	Send !a
}
return