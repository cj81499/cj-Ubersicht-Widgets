on getLocaliTunesArt(name)
	set mypath to POSIX path of (path to me)
	set AppleScript's text item delimiters to "/"
	set mypathend to last text item of mypath
	set AppleScript's text item delimiters to ""
	set mypathendlength to length of mypathend
	set mypath to text 1 through -(mypathendlength + 1) of mypath
	
	try
		tell application "iTunes" to tell artwork 1 of current track -- get the raw bytes of the artwork into a var
			set srcBytes to raw data
			if format is Çclass PNG È then -- figure out the proper file extension
				set ext to ".png"
			else
				set ext to ".jpg"
			end if
		end tell
		
		set fileName to (mypath as POSIX file) & name & ext as string -- set the filename to ~/my path/cover.ext
		set outFile to open for access file fileName with write permission -- write to file
		set eof outFile to 0 -- truncate the file
		write srcBytes to outFile -- write the image bytes to the file
		close access outFile
	on error
		return "No Art"
	end try
	return "coveriTunes" & ext
end getLocaliTunesArt

on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

set spotify_running to is_running("Spotify")
set iTunes_running to is_running("iTunes")

if spotify_running and iTunes_running then
	return "Spotify @ ERROR @ Use only one music app @  @ 0 @ No Art @ "
end if

if spotify_running then #Spotify
	
	tell application "Spotify"
		set player_state to player state
		if player_state is stopped then
			set is_playing to false
		else
			set is_playing to true
		end if
	end tell
	
	if is_playing then
		tell application "Spotify"
			try
				set player to "Spotify"
				set track_name to name of current track
				set track_artist to artist of current track
				set track_album to album of current track
				set track_duration to (duration of current track) / 1000
				set track_position to player position
				set track_percent to track_position / track_duration
				set track_art to artwork url of current track
				return player & " @ " & track_name & " @ " & track_artist & " @ " & track_album & " @ " & track_percent & " @ " & track_art & " @ "
			end try
		end tell
	else
		return "Spotify @ Spotify is Stopped @  @  @ 0 @ No Art @ "
	end if
	
else if iTunes_running then #iTunes
	
	tell application "iTunes"
		set player_state to player state
		if player_state is stopped then
			set is_playing to false
		else
			set is_playing to true
		end if
	end tell
	
	if is_playing then
		tell application "iTunes"
			try
				set player to "iTunes"
				set track_name to name of current track
				set track_artist to artist of current track
				set track_album to album of current track
				set track_duration to (duration of current track)
				set track_position to player position
				set track_percent to track_position / track_duration
				set iTunes_art to "No Art" # iTunes doesn't give a nice artwork URL like Spotify. I may try to add support later, but for now, this will just display the default artwork icon.
				set iTunes_art to (my getLocaliTunesArt("coveriTunes"))
				return player & " @ " & track_name & " @ " & track_artist & " @ " & track_album & " @ " & track_percent & " @ " & iTunes_art & " @ "
			end try
		end tell
	else
		return "iTunes @ iTunes is Stopped @  @  @ 0 @ No Art @ "
	end if
	
else
	return "None @ No music playing @  @  @ 0 @ No Art @ "
end if
