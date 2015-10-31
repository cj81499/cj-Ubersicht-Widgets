# A widget that shows what's currently playing in either iTunes or Spotify.
# I don't know how to write code, so I obviously pulled pieces from all over the place, particularly from Chris Johnson's World Clock widget.

# Assembled by Piotr Gajos [https://github.com/Pe8er/Ubersicht-Widgets]
# Artwork stuff by Damien Erambert [https://github.com/eramdam]
# Big thanks to Josh "Baby Boi" Rutherford. [https://github.com/sourcebits-jrutherford]

command: "sh 'Playbox.widget/playbox.sh'"

refreshFrequency: 1000

style: """

  white06 = rgba(white,0.6)
  black02 = rgba(black,0.2)

  left: 10px
  bottom 215px
  width: 300px
  overflow: hidden
  white-space: nowrap
  color white
  font-family Helvetica Neue
  display: inline
  text-overflow: ellipsis

  .wrapper
    position: relative
    text-align left
    font-size 8pt
    line-height 10pt
    background black02
    border 1px solid white06
    padding 8px

  .progress
    width: @width
    height: 2px
    background: white06
    position: absolute
    bottom: 0
    left: 0

  .song
    font-weight: 700

  .album
    color: white06

  .art
    width 38px
    height @width
    background-size cover
    float left
    margin 0 (5px) 0 0
    border 1px solid white06

"""

render: (output) ->
  # Get our pieces
  values = output.split(" ~ ")

  # Initialize our HTML.
  medianowHTML = ''

  # Progress bar things
  tDuration = values[4].replace(',','.')
  tPosition = values[5].replace(',','.')
  player = values[6]
  tArtwork = values[7]

  # Create the DIVs for each piece of data.

  medianowHTML = "
    <canvas class='media-bg-slice'></canvas>
    <div class='wrapper'>
      <div class='art' style='background-image: url(Playbox-full-cover.widget/as/default.png)'></div>
      <div class='song'>" + values[1] + "</div>
      <div class='artist'>" + values[0] + "</div>
      <div class='album'>" + values[2]+ "</div>
      <div class='progress'></div>
    </div>"

  return medianowHTML

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  # Get our pieces
  values = output.slice(0,-1).split(" ~ ")

  # Initialize our HTML.
  medianowHTML = ''

  # Progress bar things
  tDuration = values[3].replace(',','.')
  tPosition = values[4].replace(',','.')
  player = values[5]
  tArtwork = values[6]
  tWidth = $(domEl).width();
  tCurrent = (tPosition / tDuration) * tWidth

  currArt = $(domEl).find('.art').css('background-image').split('/').pop().slice(0,-1)

  $(domEl).find('.song').html(values[1])
  $(domEl).find('.artist').html(values[0])
  $(domEl).find('.album').html(values[2])
  $(domEl).find('.progress').css width: tCurrent
  if tArtwork isnt currArt
    $(domEl).find('.art').css('background-image', 'url(Playbox.widget/as/'+tArtwork+')')
