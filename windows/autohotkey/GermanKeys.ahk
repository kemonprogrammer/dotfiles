#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Right Alt + Key (Covers both AltGr and standard RAlt) ---

; ä (Right Alt + a)
>!a::
<^>!a::Send "ä"

; ö (Right Alt + o)
>!o::
<^>!o::Send "ö"

; ü (Right Alt + u)
>!u::
<^>!u::Send "ü"

; ß (Right Alt + s)
>!s::
<^>!s::Send "ß"

; € (Right Alt + e)
>!e::
<^>!e::Send "€"

; ° (Right Alt + `)
>!`::
<^>!`::Send "°"

; § (Right Alt + 3)
>!3::
<^>!3::Send "§"

; --- Shift + Right Alt for Uppercase ---

>!+a::
<^>!+a::Send "Ä"

>!+o::
<^>!+o::Send "Ö"

>!+u::
<^>!+u::Send "Ü"
