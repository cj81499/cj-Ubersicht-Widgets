on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

set spotify_running to is_running("Spotify")
set iTunes_running to is_running("iTunes")

if spotify_running then
	tell application "Spotify"
		try
			set track_name to name of current track
			set track_artist to artist of current track
			set track_album to album of current track
			set track_duration to (duration of current track) / 1000
			set track_position to player position
			set track_percent to track_position / track_duration
			set track_art to artwork url of current track
			return track_name & " @ " & track_artist & " @ " & track_album & " @ " & track_percent & " @ " & track_art
		end try
	end tell
else if iTunes_running then
	tell application "iTunes"
		try
			set track_name to name of current track
			set track_artist to artist of current track
			set track_album to album of current track
			set track_duration to (duration of current track)
			set track_position to player position
			set track_percent to track_position / track_duration
			# iTunes doesn't give a nice artwork URL like Spotify. I may try to add support later, but for now, this will just display the default artwork icon.
			set track_art to "No Art @ "
			return track_name & " @ " & track_artist & " @ " & track_album & " @ " & track_percent & " @ " & track_art
		end try
	end tell
else
	return "No Song @ No Artist @ No Album @ 0 @ No Art @ "
end if

on getLocaliTunesArt()
	do shell script "rm -rf " & readSongMeta({"oldFilename"}) -- delete old artwork
	tell application "iTunes" to tell artwork 1 of current track -- get the raw bytes of the artwork into a var
		set srcBytes to raw data
		if format is Çclass PNG È then -- figure out the proper file extension
			set ext to ".png"
		else
			set ext to ".jpg"
		end if
	end tell
	set fileName to (mypath as POSIX file) & "cover" & (random number from 0 to 999) & ext as string -- get the filename to ~/my path/cover.ext
	set outFile to open for access file fileName with write permission -- write to file
	set eof outFile to 0 -- truncate the file
	write srcBytes to outFile -- write the image bytes to the file
	close access outFile
	set currentCoverURL to POSIX path of fileName
	writeSongMeta({"oldFilename" & "##" & currentCoverURL})
	set currentCoverURL to getPathItem(currentCoverURL)
end getLocaliTunesArt