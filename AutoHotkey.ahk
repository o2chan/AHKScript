#Persistent
#SingleInstance force
DetectHiddenWindows On
SetTitleMatchMode 2


getFocusClass() {
    ControlGetFocus, FocusedControl, A
    ControlGet, FocusedControlHwnd, Hwnd,, %FocusedControl%, A
    WinGetClass, FocusedControlClass, ahk_id %FocusedControlHwnd%
    return (FocusedControlClass)
}

TOTALCMDON = 0

SetTimer MONITOR, 500
return

MONITOR:

;Autostart TotalVC when TC is running
IfWinExist ahk_class TTOTAL_CMD 
{
	IfWinNotExist TotalVC.ahk
	{
		If (TOTALCMDON = 0) {
			Run D:\Program Files\Totalcmd\Plugins\Utilities\TotalVC.ahk
		}
	}
	TOTALCMDON = 1
} else {
	IfWinExist TotalVC.ahk
	{
		If TOTALCMDON {
			WinClose TotalVC.ahk
		}
	}
	TOTALCMDON = 0
}

Return

;Enhance Copy Operation in QT Objects
#IfWinActive ahk_class QWidget
^v::Send %Clipboard%

;Enhance Copy Operation in CMD
#IfWinActive ahk_class ConsoleWindowClass
^v::Send %Clipboard%

;Enhance SumatraPDF
#If (WinActive("ahk_class SUMATRA_PDF_FRAME")) and (getFocusClass() != "Edit")
u::Send {PgDn}
i::Send {PgUp}
f::Send j
d::Send k
r::Send {PgDn}
e::Send {PgUp}
$!F3::Send ^c!{F3}

;Enhance Anki
#If (WinActive("Anki")) and (getFocusClass() != "Edit")
`::Send !{F3}
f::Send 1
d::Send !{F3}
g::Send !{F3}
h::Send 1
j::Send {Space}
k::Send ^z

;Enhance GoldenDict Window (Bug exist)
#IfWinActive ahk_class QTool
^v::Send %Clipboard%
j::Send {Down}
k::Send {Up}
f::Send {Down}
d::Send {Up}
s::Send {Esc}

;Enhance CHM Reader
#If (WinActive("ahk_class HH Parent")) and (getFocusClass() != "Edit")
j::Send {Down}
k::Send {Up}
r::Send {PgDn}
e::Send {PgUp}
f::Send {Down}
d::Send {Up}
u::Send {PgDn}
i::Send {PgUp}
s::Send {Esc}

;Enhance Firefox
#IfWinActive ahk_class MozillaWindowClass
$!F3::Send ^c!{F3}
!WheelUp::Send ^+{Tab}
!WheelDown::Send ^{Tab}


;Global Hotkeys
#IfWinActive
AppsKey::Send {Esc}
AppsKey & Esc::return
AppsKey & RCtrl::Send {AppsKey}
Capslock::Ctrl
+RShift::Capslock

getFocusClass2() {
    ControlGetFocus, FocusedControl, A
	Msgbox %FocusedControl%
    ControlGet, FocusedControlHwnd, Hwnd,, %FocusedControl%, A
    WinGetClass, FocusedControlClass, ahk_id %FocusedControlHwnd%
	Msgbox %FocusedControlClass%
	return
}
;^e::getFocusClass2()	;Print Class of Active Element
