MODE = 0
SINGLEWIN = 0
SHOWSELECT = 0
ALLSELECT = 0
COMMENTVIEW = 0
COMMENTRIGHT = 0

setSwitch(ByRef SW) {
	if (SW = 0){
		SW = 1
	} else {
		SW = 0
	}
	return SW
}
setSwitch2(ByRef SW) {
	if (SW = 2){
		SW = 0
	} else {
		SW += 1
	}
	return SW
}

getFocusClass() {
    ControlGetFocus, FocusedControl, A
    ControlGet, FocusedControlHwnd, Hwnd,, %FocusedControl%, A
    WinGetClass, FocusedControlClass, ahk_id %FocusedControlHwnd%
	return (FocusedControlClass)
}

plistActive() {
	WinGet,syssd,id,ahk_class #32768
	return syssd
}

focusList() {
	ControlGetFocus, FocusedControl, A
	if (FocusedControl = "TMyListBox1") {
		return 2
	} else {
		return 1
	}
}

#IfWinActive ahk_class TTOTAL_CMD
;Global Hotkeys
F1::setSwitch(MODE)

#If (WinActive("ahk_class TTOTAL_CMD")) and MODE
;Hotkeys in TotalVC Mode
$F2::Send ^{F2}
$F3::Send ^{F1}
$F4::
if setSwitch(SINGLEWIN) {
	PostMessage, 1075, 4001
	PostMessage, 1075, 3201
	PostMessage, 1075, 2902
	PostMessage, 1075, 910
	PostMessage, 1075, 269
} else {
	Send ^{F2}
	PostMessage, 1075, 3200
	PostMessage, 1075, 2902
	PostMessage, 1075, 909
}
return
F12::PostMessage, 1075, 2902

#If (WinActive("ahk_class TTOTAL_CMD")) and MODE and (getFocusClass() = "TMyListBox") and (not plistActive())
;Left Hand Command
q::Send ^+{Tab}					;Select Previous Tab
w::PostMessage, 1075, 4001		;Activate Left Window
e::PostMessage, 1075, 4002		;Activate Right Window
r::Send ^{Tab}					;Select Next Tab
t::PostMessage, 1075, 529		;Restore Selection
+t::PostMessage, 1075, 530		;Save Selection
a::								;New Tab
Send ^t
PostMessage, 1075, 2122
return
s::Send ^w						;Close Current Tab
+s::Send ^+w{Enter}				;Close Other Tabs
!s::Send {Tab}^w{Tab}			;Close Tab in Destination Window
$d::Send ^d						;Open Hotlist
$f::Send f{BS}					;Quick Search
+f::PostMessage, 1075, 2912		;Select Current Path
g::Send ^z						;Edit Comment
z::Send !{F6}					;Unzip File
+z::Send !{F5}					;Zip File
!z::							;Unzip File in Current Window
UNZIPTEMP = %clipboard%
PostMessage, 1075, 2029
Send !{F6}
Send %clipboard%!s
clipboard = %UNZIPTEMP%
return
x::Send {Del}					;Delete
+x::Send +{Del}					;Delete Permanently
c::Send {F7}					;New Folder
+c::Send +{F4}{BS}{Enter}		;New Text File
v::Send {Tab}^t^dv{Tab}			;Open Virtual Drive
b::PostMessage, 1075, 331		;Change Dir

;Right Hand Command
y::PostMessage, 1075, 2018		;Copy File Name
+y::PostMessage, 1075, 2029		;Copy File Path
u::Send {F2}					;Rename File
i::Send {F3}					;Preview File
+i::Send ^q						;Preview FIle in Destination Window
o::Send {F4}					;Edit File
p::Send {Enter}					;Open File
h::Left							;Emulate Left Key
+h::Send {Tab}!{Left}{Tab}		;Destination to Previous Directory
#h::return
j::Down							;Emulate Down Key
#j::return
k::Up							;Emulate Up Key
#k::return
l::Right						;Emulate Right Key
+l::Send {Tab}!{Right}{Tab}		;Destination to Next Directory
#l::return
`;::PostMessage, 1075, 532		;Target = Source
;n::Send {F5}					;Copy File
n::PostMessage, 1075, 905
+n::Send +{F5}					;Copy File to Current Window
m::Send {F6}					;Move File
+m::Send ^+{F5};				;Create Shortcut
\::PostMessage, 1075, 2122		;Back to Root
+\::							;Back to Root in Destination Window
Send {Tab}
PostMessage, 1075, 2122
return

;Num Command
`::								;Toggle Comment View
if setSwitch(COMMENTVIEW) {
	if (focusList() = 2) {
		COMMENTTEMP = %clipboard%
		PostMessage, 1075, 2017
		Sleep, 200
		ifInString, clipboard, \
		{
			StringTrimRight, clipboard, clipboard, 1
		}
		Send ^+u
		PostMessage, 1075, 4001
		Send ^+{F2}
		Send %clipboard%{Esc}{Esc}
		clipboard = %COMMENTTEMP%
		COMMENTRIGHT = 1		
	} else {
		Send ^+{F2}
	}
	PostMessage, 1075, 910
} else {
	PostMessage, 1075, 909
	Send ^+{F2}
	if (COMMENTRIGHT) {
		COMMENTTEMP = %clipboard%
		PostMessage, 1075, 2017
		Sleep, 200
		ifInString, clipboard, \
		{
			StringTrimRight, clipboard, clipboard, 1
		}
		Send ^+u
		PostMessage, 1075, 4002
		Send %clipboard%{Esc}{Esc}
		clipboard = %COMMENTTEMP%
		COMMENTRIGHT = 0
	}
}
return	
^`::Send ^+{F1}
1::Send ^{F3}
2::Send ^{F4}
3::Send ^{F6}
4::Send ^{F5}
0::
if setSwitch(SHOWSELECT) {
	PostMessage, 1075, 2023
} else {
	PostMessage, 1075, 312
	PostMessage, 1075, 529
}
return
-::Send {NumpadMult}
=::
if setSwitch(ALLSELECT) {
	Send ^{NumpadAdd}
} else {
	Send ^{NumpadSub}
}
return

;Enhance Lister
#IfWinActive ahk_class TLister
j::Down
k::Up
h::Left
l::Right
m::BS
n::Space
d::Send {Esc}
