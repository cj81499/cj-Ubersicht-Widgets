# A widget that shows what's currently playing in either iTunes or Spotify.
# I don't know how to write code, so I obviously pulled pieces from all over the place, particularly from Chris Johnson's World Clock widget.

# Assembled by Piotr Gajos [https://github.com/Pe8er/Ubersicht-Widgets]
# Artwork stuff by Damien Erambert [https://github.com/eramdam]
# Big thanks to Josh "Baby Boi" Rutherford. [https://github.com/sourcebits-jrutherford]

command: "osascript 'cj Ubersicht Widgets.widget/Playbox.widget/lib/GetMusicInfo.applescript'"

refreshFrequency: "2s"

style: """

  white06 = rgba(white,0.6)
  black02 = rgba(black,0.2)

  left 10px
  bottom 130px
  width 343px
  white-space nowrap
  color white
  font-family Helvetica Neue
  overflow scroll

  .wrapper
    text-align left
    font-size 8pt
    line-height 10pt
    background black02
    border 1px solid white06
    height 54px
    opacity 0
    transition opacity 1s linear

  .progress
    height 2px
    background white06
    position absolute
    bottom 1px
    left 1px
    transition width 2s linear

  .text
    margin-left 52px

  .song
    margin-top 5px
    font-weight 700

  .artist
    margin-top 2px

  .album
    margin-top 1px
    color white06

  .spotifyart, .spotifyartfade, .itunesart, .itunesartfade, .default
    position absolute
    height 40px
    width @height
    background-size cover
    float left
    margin 5px 5px
    border 1px solid white06
    transition opacity 1s linear
    opacity 1
    z-index 2

  .default
    z-index 1

  .spotifyartfade, .itunesartfade
    z-index 3

  .spotifyart
    // background-color rgba(0, 255, 127, 1)

  .spotifyartfade
    // background-color rgba(0, 127, 127, 1)

  .itunesart
    // background-color rgba(63, 127, 255, 1)
  
  .itunesartfade
    // background-color rgba(127, 127, 255, 1)

  .default
    // background-color rgba(255, 0, 255, 1)
"""

render: (output) ->"
  <div class='wrapper'>
    <div class='spotifyartfade'></div>
    <div class='spotifyart'></div>
    <div class='itunesartfade'></div>
    <div class='itunesart'></div>
    <img class='default' src='cj Ubersicht Widgets.widget/Playbox.widget/lib/default.png'>
    <div class=text>
      <div class='song'></div>
      <div class='artist'></div>
      <div class='album'></div>
    </div>
    <div class='progress'></div>
  </div>"

# Update the rendered output.
update: (output, domEl) ->

  # Get our pieces
  values = output.split(" @ ")

  # Set Values
  currSong = $(domEl).find('.song').html().trim()
  currAlbum = $(domEl).find('.album').html().trim()
  currArtSpotify = $(domEl).find('.spotifyartfade').css('background-image').split('url(').pop().slice(0,-1)
  currArtiTunes = $(domEl).find('.itunesartfade').css('background-image')
  Player = values[0].trim()
  Song = values[1].trim()
  Artist = values[2].trim()
  Album = values[3].trim()
  Percent = values[4].trim()
  Artwork = values[5].trim()
  Width = $(domEl).width()

  # Display values
  $(domEl).find('.song').html(Song)
  $(domEl).find('.artist').html(Artist)
  $(domEl).find('.album').html(Album)

  # Set bar width
  $(domEl).find('.progress').css(width: Percent * Width)

  if Player == "Spotify" # Handle Spotify
    $(domEl).find('.wrapper').css('opacity', '1')
    $(domEl).find('.spotifyart').css('opacity', '1')
    $(domEl).find('.itunesart').css('opacity', '0')
    $(domEl).find('.itunesartfade').css('opacity', '0')
    if Album == currAlbum or Song == currSong
      $(domEl).find('.spotifyartfade').css('opacity', '0')
    else
      $(domEl).find('.spotifyartfade').css('opacity', '1')
      # Set spotifyartfade and art
      $(domEl).find('.spotifyartfade').css('background-image', 'url('+Artwork+')') # spotifyartfade is up to date
    $(domEl).find('.spotifyart').css('background-image', 'url('+currArtSpotify+')') # spotifyart is one refresh behind
  else if Player == "iTunes" # Handle iTunes
    $(domEl).find('.wrapper').css('opacity', '1')
    $(domEl).find('.itunesart').css('opacity', '1')
    $(domEl).find('.spotifyart').css('opacity', '0')
    $(domEl).find('.spotifyartfade').css('opacity', '0')
    if Album == currAlbum or Song == currSong
      $(domEl).find('.itunesartfade').css('opacity', '0')
    else
      $(domEl).find('.itunesartfade').css('opacity', '1')
      # Set itunesartfade and art
      $(domEl).find('.itunesartfade').css('background-image', 'url("'+'cj Ubersicht Widgets.widget/Playbox.widget/lib/'+Artwork+"?"+new Date().getTime()+'")') # itunesartfade is up to date
    $(domEl).find('.itunesart').css('background-image', currArtiTunes) # itunesart is one refresh behind
  else if Player == "None" # Handle No Player
    $(domEl).find('.wrapper').css('opacity', '0')

  if Player == "Spotify" or Player == "iTunes" # Show default art when no art
    if Artwork == "No Art"
      $(domEl).find('.spotifyart').css('opacity', '0')
      $(domEl).find('.spotifyartfade').css('opacity', '0')
      $(domEl).find('.itunesart').css('opacity', '0')
      $(domEl).find('.itunesartfade').css('opacity', '0')
