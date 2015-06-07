# A widget that shows what's currently playing in either iTunes or Spotify.
# Assembled by Piotr Gajos
# https://github.com/Pe8er/Ubersicht-Widgets
# I don't know how to write code, so I obviously pulled pieces from all over the place, particularly from Chris Johnson's World Clock widget. Also big thanks to Josh "Baby Boi" Rutherford.

# Modified by cj81499
# https://github.com/cj81499/cj-Ubersicht-Widgets

command: "osascript 'Playbox.widget/Get Current Track.scpt'"

refreshFrequency: 5000

style: """

  white06 = rgba(white,0.6)
  black02 = rgba(black,0.2)

  bottom: (70px)
  left: (93px)
  width: 319px
  overflow: hidden
  white-space: nowrap

  .wrapper
    position: relative
    font-family: "Helvetica Neue"
    text-align: left
    font-size: 8pt
    color: white
    background: black02
    border: 1px solid white06
    padding: (6px) (12px)
    height: 38px

  .progress
    width: @width
    height: 2px
    background: white06
    position: absolute
    bottom: 0
    left: 0px

  .wrapper, .album
    overflow: hidden
    text-overflow: ellipsis

  .song
    font-weight: 700

  .song, .artist, .by
    display: inline

  .album, .by
    color: white06

  .rating
    float: right
    position: relative
  """

render: -> """
"""

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  # Get our pieces
  values = output.split(" ~ ")
  console.log(values)

  # Progress bar things
  tDuration = values[4]
  tPosition = values[5]
  tCurrent = '0'
  if tDuration != 'NA'
    tWidth = $(domEl).width();
    tCurrent = (tPosition / tDuration) * tWidth

    # Create the DIVs for each piece of data.
    medianowHTML = "
      <div class='wrapper'>
        <div class='song'>" + values[1] + "</div>
        <div class='artist'>" + values[0] + "</div>
        <div class='rating'>" + values[3] + "</div>
        <div class='album'>" + values[2] + "</div>
        <div class='progress' style='width: " + tCurrent + "px'></div>
      </div>"

  # Set the HTML of our main DIV.
  div.html(medianowHTML)
