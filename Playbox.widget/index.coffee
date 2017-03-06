# A widget that shows what's currently playing in either iTunes or Spotify.
# I don't know how to write code, so I obviously pulled pieces from all over the place, particularly from Chris Johnson's World Clock widget.

# Assembled by Piotr Gajos [https://github.com/Pe8er/Ubersicht-Widgets]
# Artwork stuff by Damien Erambert [https://github.com/eramdam]
# Big thanks to Josh "Baby Boi" Rutherford. [https://github.com/sourcebits-jrutherford]

command: "osascript 'cj Ubersicht Widgets.widget/Playbox.widget/lib/GetMusicInfo.applescript'"

refreshFrequency: "1s"

style: """

  white06 = rgba(white,0.6)
  black02 = rgba(black,0.2)

  left: 10px
  bottom 130px
  width: 343px
  white-space: nowrap
  color white
  font-family Helvetica Neue
  overflow: hidden

  .wrapper
    text-align left
    font-size 8pt
    line-height 10pt
    background black02
    border 1px solid white06
    height: 54px

  .progress
    height: 2px
    background: white06
    position: absolute
    bottom: 1px
    left: 1px
    transition: width 1s linear;

  .song
    margin-top 5px
    font-weight: 700

  .artist
    margin-top 2px

  .album
    margin-top 1px
    color: white06

  .art, .default
    height: 40px
    width: @height
    background-size cover
    float left
    margin 5px 5px
    border 1px solid white06
"""

render: (output) ->"
  <div class='wrapper'>
    <div class='art'></div>
    <img class='default' src='cj Ubersicht Widgets.widget/Playbox.widget/lib/default.png'>
    <div class='song'></div>
    <div class='artist'></div>
    <div class='album'></div>
    <div class='progress'></div>
  </div>"

# Update the rendered output.
update: (output, domEl) ->

  # Get our pieces
  values = output.split(" @ ")

  # Set Values
  Song = values[0]
  Artist = values[1]
  Album = values[2]
  Percent = values[3]
  Artwork = values[4]

  # Get our main DIV.
  div = $(domEl)
  Width = $(domEl).width();

  # Display values
  $(domEl).find('.song').html(Song)
  $(domEl).find('.artist').html(Artist)
  $(domEl).find('.album').html(Album)
  $(domEl).find('.progress').css(width: Percent * Width)
  if Artwork isnt currArt
    $(domEl).find('.art').css('background-image', 'url('+Artwork+')')
  if Artwork is "No Art"
    $(domEl).find('.art').css('display', 'none')
    $(domEl).find('.default').css('display', 'block')
  else
    $(domEl).find('.art').css('display', 'block')
    $(domEl).find('.default').css('display', 'none')

  currArt = $(domEl).find('.art').css('background-image').split('/').pop().slice(0,-1)
