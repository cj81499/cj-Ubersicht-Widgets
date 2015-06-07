/* Defining variables */

oldPlayState = 0;
var length;

function get(el) { return document.getElementById(el); }

/* Artwork functions */

function artworkUpdate(artURL)
{
	if (artURL == "")
		get('coverImg').src = "img/noart.png";
	else
		get('coverImg').src = artURL;
}

/* The play state (play/pause button function) and statusbar */

function playerUpdate()
{
	var pState = iTunes.playState();

	if (pState != oldPlayState)
	{
		if (pState == 0 || pState == 2)
			get('playage').innerHTML = '<img class="buttonactive" src="img/play.png">';
		else
			get('playage').innerHTML = '<img class="buttonactive" src="img/pause.png">';

		oldPlayState = pState;
	}

	var progress = iTunes.playerPosition();
    var width = 319/length*progress

    get('progression').width = width.toString();
	get('Scrubber').style.paddingLeft = width + "px";

}

function setTime()
{
    var event = window.event;
	var outside = document.getElementById('progressOver');

    var eventPosX = event.offsetX
    var progressWidth = outside.offsetWidth;

    /** To get the TIME position (in seconds), we just have to do: */
    var timePosition = eventPosX * (length / progressWidth);
	/** e.g: i click on the progress..
            'eventPosX' == 40.
            'progressWidth' ~= 92.
            'length' (the track duration) is 120 seconds.
        length / progressWidth ~=1.4
        eventPosX * 1.4 = 40* 1.4 = 56.
        The new player position is then 56 seconds.
    */

   	 iTunes.setPlayerPosition(timePosition);
}

/* Text track info definitions */

function trackUpdate(track)
{
    length = track.property('length');
	var name = track.property('title');
	var artist = track.property('artist');
	var album = track.property('album');

	get('songname').innerHTML = name;
	get('artist').innerHTML = artist;
	get('album').innerHTML = album;

}

/* Define the play/pause function */

function playPause()
{
	iTunes.playPause();
	playerUpdate();
}

/* Make it draggable */

mouseDown = false;
	mouseX = 0;
	mouseY = 0;

	mouseStartX = 0;
	mouseStartY = 0;
	startFrame = [];
	document.onmousedown = function(e)
	{
		mouseDown = true;

		mouseStartX = e.screenX;
		mouseStartY = e.screenY;
		startFrame = iTunes.frame();
	}
	document.onmouseup = function()
	{
		mouseDown = false;
	}
	document.onmousemove = function(e)
	{
		mouseX = e.screenX;
		mouseY = e.screenY;

		if (mouseDown)
		{
			deltaX = mouseX - mouseStartX;
			deltaY = mouseStartY - mouseY;	// flipped coordinate system

			iTunes.setFrame(startFrame[0]+deltaX, startFrame[1]+deltaY, startFrame[2], startFrame[3]);
		}
	}
