# Execute the shell command.
command: "WorldClock.widget/WorldClock.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 10000

# CSS Style
style: """

  white06 = rgba(white,0.6)
  black02 = rgba(black,0.2)
  box = 4
  rows = 2

  bottom: 10px
  left: 230px
  white-space: wrap
  body.inverted &
      -webkit-filter invert(100%)

  .wrapper
    font-family: "Helvetica Neue"
    text-align: center
    font-size: 8pt
    background: black02
    width: (320px /rows)
    border: 1px solid white06

  .box, .lastbox
    width: (320px / box)
    display: inline-block
    padding: 15px 0px

  .Time
    color: white
    font-weight: 700

  .Timezone
    color: white06
"""


# Render the output.
render: -> """
"""

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  # Get our timezones and times.
  zones=output.split("\n")

  # Initialize our HTML.
  timeHTML = ''

  # Loop through each of the time zones.
  for zone, idx in zones

    # If the zone is not empty (e.g. the last newline), let's add it to the HTML.
    if zone != ''

      # Split the timezone from the time.
      values = zone.split(";")

      # Create the DIVs for each timezone/time. The last item is unique in that we don't want to display the border.
      if idx < zones.length - 2
        timeHTML = timeHTML + "<div class='box'><div class='Time'>" + values[1] + "</div><div class='Timezone'>" + values[0] + "</div></div>"
      else
        timeHTML = timeHTML + "<div class='lastbox'><div class='Time'>" + values[1] + "</div><div class='Timezone'>" + values[0] + "</div></div>"

  # Set the HTML of our main DIV.
  div.html("</canvas><div class='wrapper'>" + timeHTML + "</div>")
