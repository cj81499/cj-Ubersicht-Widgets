global aname, tname, alname

set musicapp to item 1 of my appCheck()
set playerstate to item 2 of my appCheck()

--return musicapp

try
	if musicapp is not "" then
		--if playerstate is not "Paused"
		if musicapp is "iTunes" then
			tell application "iTunes"
				set {tname, aname, alname, tduration} to {name, artist, album, duration} of current track
				set tpos to player position
			end tell
		else if musicapp is "Spotify" then
			tell application "Spotify"
				set {tname, aname, alname} to {name, artist, album} of current track
				set tpos to player position
				set tduration to (duration of current track) / 1000
			end tell
		end if
		
		return aname & " ~ " & tname & " ~ " & alname & " ~ " & tduration & " ~ " & tpos & " ~ " & musicapp
		--end if
	else
		return "." & " ~ " & "Nothing Playing" & " ~ " & "." & " ~ " & "." & " ~ " & "." & " ~ " & "." & " ~ " & "."
	end if
on error e
	return e
end try

on appCheck()
	set apps to {"iTunes", "Spotify"}
	set playerstate to {}
	set activeApp to {}
	repeat with i in apps
		tell application "System Events" to set state to (name of processes) contains i
		if state is true then
			set activeApp to (i as string)
			using terms from application "iTunes"
				tell application i
					if player state is playing then
						set playerstate to "Playing"
						exit repeat
					else
						set playerstate to "Paused"
						--exit repeat
					end if
				end tell
			end using terms from
		else
			set activeApp to ""
		end if
	end repeat
	return {activeApp, playerstate}
end appCheck