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
		end try
	end tell
else
	return "No Song @ No Artist @ No Album @ 0 @ No Art @ "
end if