set musicapp to item 1 of my appCheck()
set playerstate to item 2 of my appCheck()


if musicapp is "iTunes" then
	tell application "iTunes"
		if (count of artwork of current track) > 0 then
			set d to raw data of artwork 1 of current track
			set idTrack to id of current track
			if format of artwork 1 of current track is Çclass PNG È then
				set x to "png"
			else
				set x to "jpg"
			end if
		else
			return "default.png"
		end if
	end tell
else if musicapp is "Spotify" then
	(* tell application "Spotify"
		set d to artwork of current track
		set idTrack to my replace_chars(id of current track, ":", "-")
	end tell *)
	return "default.png"
else
	return "default.png"
end if


--(((POSIX path of "~/.tmp/") as text) & "cover." & x)
set temp_folder to (POSIX path of ((path to me as string) & "::"))
set temp_file to (POSIX path of ((path to me as string) & "::" & "cover-" & idTrack))

if (my FileExists(temp_file)) then
	return "cover-" & idTrack
else
	--do shell script "find '" & temp_folder & "' -name 'cover-*' | xargs rm;"
	set open_file to (open for access temp_file with write permission)
	set eof open_file to 0
	write d to open_file
	close access open_file
	return "cover-" & idTrack
end if

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
					end if
				end tell
			end using terms from
		else
			set activeApp to ""
		end if
	end repeat
	return {activeApp, playerstate}
end appCheck

on FileExists(theFile) -- (String) as Boolean
	tell application "System Events"
		if exists file theFile then
			return true
		else
			return false
		end if
	end tell
end FileExists

on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars