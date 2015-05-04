# A widget that shows current weather.
# Assembled by Piotr Gajos
# https://github.com/Pe8er/Ubersicht-Widgets
# I don't know how to write code, so I obviously pulled pieces from all over the place, particularly from Chris Johnson's World Clock widget. Also big thanks to Josh "Baby Boi" Rutherford.

# jq required for use:  http://stedolan.github.io/jq/
# Optionally just use brew:  'brew install jq'

# Execute the shell command.
command: "Weather.widget/Weather.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 1800000

# CSS Style
style: """

  bottom: 70px
  left: 10px
  width: 75px
  body.inverted &
      -webkit-filter invert(100%)

  .wrapper
    font-family: "Helvetica Neue"
    text-align: center
    font-size: 8pt
    color: white
    background: rgba(black, 0.2)
    border: 1px solid rgba(white, 0.6)
    height: 50px

  .temp, .cond
    overflow: hidden
    text-overflow: ellipsis

  .temp
    font-weight: 700
    font-size: 16pt
    line-height: @font-size
    margin-left: 8px
    overflow: visible
    padding-top: 6px
    padding-bottom: 2px

  """


# Render the output.
render: -> """
"""

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  # Get our pieces
  values = output.split("\n")

  # Initialize our HTML.
  weatherHTML = ''

  # Making my life easy
  loc = values[0]
  cond = values[1]
  temp = values[2]

    # Create the DIVs for each piece of data.
  weatherHTML = "
    <div class='wrapper'>
      <div class='temp'>" + temp + "</div>
      <div class='cond'>" + cond + "</div>
    </div>"

  # Set the HTML of our main DIV.
  div.html(weatherHTML)