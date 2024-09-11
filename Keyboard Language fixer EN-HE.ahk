#Requires AutoHotkey v2.0

#SingleInstance Force


; ============= Keyboard Fix =============

; ==== Set Map ====

Kybrdtble := Map()
Kybrdtble.CaseSense := 1

; = English to Hebrew =

Kybrdtble["`t"] := "`t"
Kybrdtble["`n"] := "`n"
Kybrdtble["-"] := "-"
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
	FileDelete "Company Logo.clip"
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
			If (InStr(CopiedTxtToRep, "t") or InStr(CopiedTxtToRep, "v") or InStr(CopiedTxtToRep, "u") or InStr(CopiedTxtToRep, "h") or InStr(CopiedTxtToRep, "r")) {
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
	
	
	TxtToRep := ""
	LetInArr := ""
	TxtToPrint := ""
	CorLetStor := ""
	
	ClipData := FileRead("Company Logo.clip", "RAW")  ; In this case, FileRead returns a Buffer.
	A_Clipboard := ClipboardAll(ClipData)  ; Convert the Buffer to a ClipboardAll and assign it.
}


; ============ Screen Flipping ===========
 
^!Up:: Run '"C:\Program Files\display\display64.exe" /rotate 0' , , "Hide"
^!Down:: Run '"C:\Program Files\display\display64.exe" /rotate 180' , , "Hide"
^!Left:: Run '"C:\Program Files\display\display64.exe" /rotate 90' , , "Hide"
^!Right:: Run '"C:\Program Files\display\display64.exe" /rotate 270' , , "Hide"
