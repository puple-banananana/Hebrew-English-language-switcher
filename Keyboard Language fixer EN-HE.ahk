#Requires AutoHotkey v2.0

#SingleInstance Force
LangSwItemName := "Change keyboard language after activating the tool?"
StartupItemName := "Activate Script on startup?"

A_TrayMenu.Add()  ; Creates a separator line.
A_TrayMenu.Add(LangSwItemName, LangSwMenuHandler)
A_TrayMenu.Add(StartupItemName, StartupMenuHandler)
Persistent

; ====== match all variables to ini file if available, if not - create an ini file ========


if (FileExist("Keyboard.LanguageFixer.EN.HE.ini")) {
	LangChangeCurrStt := IniRead(A_ScriptDir "\Keyboard.LanguageFixer.EN.HE.ini", "Settings", "ChangeLanguageAfterTrigger")
	ActiveOnStartCurrStt := IniRead(A_ScriptDir	"\Keyboard.LanguageFixer.EN.HE.ini", "Settings", "ActiveOnStartup")
	
	If (LangChangeCurrStt) {
		A_TrayMenu.Check(LangSwItemName)
	} Else {
		A_TrayMenu.UnCheck(LangSwItemName)
	}
	
	If (ActiveOnStartCurrStt) {
		A_TrayMenu.Check(StartupItemName)
	} Else {
		A_TrayMenu.UnCheck(StartupItemName)
	}
	; MsgBox LangChangeCurrStt 
	
} Else {
	FileAppend "[Settings]`n", "Keyboard.LanguageFixer.EN.HE.ini", "UTF-16-RAW"
	IniWrite("1", "Keyboard.LanguageFixer.EN.HE.ini", "Settings", "ChangeLanguageAfterTrigger")
	IniWrite("0", "Keyboard.LanguageFixer.EN.HE.ini", "Settings", "ActiveOnStartup")
	LangChangeCurrStt := "1"
	ActiveOnStartCurrStt := "0"
	A_TrayMenu.Check(LangSwItemName)
	A_TrayMenu.UnCheck(StartupItemName)
}


; ========= Tray Menu ===================

LangSwMenuHandler(langItemName, langpos , langMyMenu) {
	global
	langMyMenu.ToggleCheck(langItemName)
	; MsgBox LangChangeCurrStt
	LangChangePrevStt := LangChangeCurrStt
	LangChangeCurrStt := !LangChangePrevStt
	IniWrite(LangChangeCurrStt, "Keyboard.LanguageFixer.EN.HE.ini", "Settings", "ChangeLanguageAfterTrigger")
}

StartupMenuHandler(startupItemName, startpos , startupMyMenu) {
	global
	startupMyMenu.ToggleCheck(startupItemName)
	; MsgBox ActiveOnStartCurrStt
	ActiveOnStartPrevStt := ActiveOnStartCurrStt
	ActiveOnStartCurrStt := !ActiveOnStartPrevStt
	IniWrite(LangChangeCurrStt, "Keyboard.LanguageFixer.EN.HE.ini", "Settings", "ActiveOnStartup")
	
	If (A_IsCompiled) {
		ShortcutName := StrReplace(A_ScriptName, ".exe", ".lnk")
	} Else If (!A_IsCompiled) {
		ShortcutName := StrReplace(A_ScriptName, ".ahk", ".lnk")
	}
	
	If (ActiveOnStartCurrStt) {
		FileCreateShortcut A_ScriptDir "\" A_ScriptName , A_AppData "\Microsoft\Windows\Start Menu\Programs\Startup\"  ShortcutName
	} else {
		FileDelete A_AppData "\Microsoft\Windows\Start Menu\Programs\Startup\"  ShortcutName
	}

}


; ==== Set Map ====

Kybrdtble := Map()
Kybrdtble.CaseSense := 1

; = English to Hebrew =

Kybrdtble["`t"] := "`t"
Kybrdtble["`n"] := "`n"
Kybrdtble["!"] := "!"
Kybrdtble["+"] := "`+"
Kybrdtble["="] := "="
Kybrdtble["1"] := "1"
Kybrdtble["2"] := "2"
Kybrdtble["3"] := "3"
Kybrdtble["4"] := "4"
Kybrdtble["5"] := "5"
Kybrdtble["6"] := "6"
Kybrdtble["7"] := "7"
Kybrdtble["8"] := "8"
Kybrdtble["9"] := "9"
Kybrdtble["@"] := "@"
Kybrdtble["-"] := "-"
Kybrdtble["?"] := "?"
Kybrdtble[" "] := " "
Kybrdtble["q"] := "/"
Kybrdtble["w"] := "'"
Kybrdtble["e"] := "ק"
Kybrdtble["r"] := "ר"
Kybrdtble["t"] := "א"
Kybrdtble["y"] := "ט"
Kybrdtble["u"] := "ו"
Kybrdtble["i"] := "ן"
Kybrdtble["o"] := "ם"
Kybrdtble["p"] := "פ"
Kybrdtble["a"] := "ש"
Kybrdtble["s"] := "ד"
Kybrdtble["d"] := "ג"
Kybrdtble["f"] := "כ"
Kybrdtble["g"] := "ע"
Kybrdtble["h"] := "י"
Kybrdtble["j"] := "ח"
Kybrdtble["k"] := "ל"
Kybrdtble["l"] := "ך"
Kybrdtble["`;"] := "ף"
Kybrdtble["z"] := "ז"
Kybrdtble["x"] := "ס"
Kybrdtble["c"] := "ב"
Kybrdtble["v"] := "ה"
Kybrdtble["b"] := "נ"
Kybrdtble["n"] := "מ"
Kybrdtble["m"] := "צ"

Kybrdtble["Q"] := "Q"
Kybrdtble["W"] := "W"
Kybrdtble["E"] := "E"
Kybrdtble["R"] := "R"
Kybrdtble["T"] := "T"
Kybrdtble["Y"] := "Y"
Kybrdtble["U"] := "U"
Kybrdtble["I"] := "I"
Kybrdtble["O"] := "O"
Kybrdtble["P"] := "P"
Kybrdtble["A"] := "A"
Kybrdtble["S"] := "S"
Kybrdtble["D"] := "D"
Kybrdtble["F"] := "F"
Kybrdtble["G"] := "G"
Kybrdtble["H"] := "H"
Kybrdtble["J"] := "J"
Kybrdtble["K"] := "K"
Kybrdtble["L"] := "L"
Kybrdtble["Z"] := "Z"
Kybrdtble["X"] := "X"
Kybrdtble["C"] := "C"
Kybrdtble["V"] := "V"
Kybrdtble["B"] := "B"
Kybrdtble["N"] := "N"
Kybrdtble["M"] := "M"

; Kybrdtble.Default := "`&"
Kybrdtble['"'] := '"'


; = Hebrew to English =

Kybrdtble["ק"] := "e"
Kybrdtble["ר"] := "r"
Kybrdtble["א"] := "t"
Kybrdtble["ט"] := "y"
Kybrdtble["ו"] := "u"
Kybrdtble["ן"] := "i"
Kybrdtble["ם"] := "o"
Kybrdtble["פ"] := "p"
Kybrdtble["ש"] := "a"
Kybrdtble["ד"] := "s"
Kybrdtble["ג"] := "d"
Kybrdtble["כ"] := "f"
Kybrdtble["ע"] := "g"
Kybrdtble["י"] := "h"
Kybrdtble["ח"] := "j"
Kybrdtble["ל"] := "k"
Kybrdtble["ך"] := "l"
Kybrdtble["ף"] := "`;"
Kybrdtble["ז"] := "z"
Kybrdtble["ס"] := "x"
Kybrdtble["ב"] := "c"
Kybrdtble["ה"] := "v"
Kybrdtble["נ"] := "b"
Kybrdtble["מ"] := "n"
Kybrdtble["צ"] := "m"
Kybrdtble["ת"] := "`,"
Kybrdtble["ץ"] := "`."

; = Edge cases Hebrew to English =

KybrdtbleHeEn := Map()

KybrdtbleHeEn["'"] := "w"
KybrdtbleHeEn["`."] := "`/"
KybrdtbleHeEn["`/"] := "q"
KybrdtbleHeEn[","] := "`'"

; = Edge cases English to Hebrew =

KybrdtbleEnHe := Map()

KybrdtbleEnHe["`,"] := "ת"
KybrdtbleEnHe["`."] := "ץ"
KybrdtbleEnHe["`'"] := ","
KybrdtbleEnHe["`/"] := "`."


^!q:: KeybordReplace()

KeybordReplace(){
	; Store clipboard
	If (FileExist("Company Logo.clip")) {
		FileDelete "Company Logo.clip"
	}
	FileAppend ClipboardAll(), "Company Logo.clip"
	
	SendInput "^x"
	Sleep 50
	CopiedTxtToRep := A_Clipboard
	; MsgBox CopiedTxtToRep
	
	
	TxtToRep := StrSplit(CopiedTxtToRep)

	For LetInArr in TxtToRep {
		; MsgBox LetInArr
		
		Try {
			CorLetStor := Kybrdtble.Get(LetInArr)
			; MsgBox "not Caught"
		} Catch {
			; MsgBox "Caught!"
			If (InStr(CopiedTxtToRep, "t", 1) or InStr(CopiedTxtToRep, "v", 1) or InStr(CopiedTxtToRep, "u", 1) or InStr(CopiedTxtToRep, "h", 1) or InStr(CopiedTxtToRep, "r", 1)) {
				CorLetStor := KybrdtbleEnHe.Get(LetInArr)
				; MsgBox "EN-HE Edge cases Activated"
			} Else If (InStr(CopiedTxtToRep, "ש") or InStr(CopiedTxtToRep, "ק") or InStr(CopiedTxtToRep, "ן") or InStr(CopiedTxtToRep, "ם") or InStr(CopiedTxtToRep, "ו")) {
				CorLetStor := KybrdtbleHeEn.Get(LetInArr)
				; MsgBox "HE-EN Edge cases Activated"
			} Else { 
				MsgBox "While problematic charachters where used, no vowels were used, Hampering Identification. `n Please add a vowel in English or Hebrew (while your keyboard is set to the incorrect language) to run successfully"
				SendInput "^v"
				Exit
			}
		}
		
		
		; MsgBox CorLetStor
		
		TxtToPrint .= CorLetStor
				
		; MsgBox TxtToPrint
	}
	
	loop{
		If ( StrLen(CopiedTxtToRep) = StrLen(TxtToPrint) ) {
			SendInput TxtToPrint
			break
		}
		Else {
			Sleep 20
		}
	}
	
	; MsgBox LangChangeCurrStt
	
	if (IniRead("Keyboard.LanguageFixer.EN.HE.ini", "Settings", "ChangeLanguageAfterTrigger")) {
		Sleep 10
		SendInput "{Shift down}"
		Sleep 10
		SendInput "{alt}"
		Sleep 10
		SendInput "{Shift up}"
	}
	
	TxtToRep := ""
	LetInArr := ""
	TxtToPrint := ""
	CorLetStor := ""
	
	ClipData := FileRead("Company Logo.clip", "RAW")  ; In this case, FileRead returns a Buffer.
	A_Clipboard := ClipboardAll(ClipData)  ; Convert the Buffer to a ClipboardAll and assign it.
}