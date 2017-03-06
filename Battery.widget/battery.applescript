set allText to do shell script "pmset -g batt"

try
	set AppleScript's text item delimiters to "'"
	set powerType to " " & (first word of text item 2 of allText)
	
	set AppleScript's text item delimiters to ";"
	set chargeLevel to last word of text item 1 of allText
	
	set AppleScript's text item delimiters to ";"
	set status to text item 2 of allText
	
	return chargeLevel & " @" & status & " @" & powerType
on error
	return "NA"
end try