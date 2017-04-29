options =

  API_key: "???" # Your API key from http://openweathermap.org
  units: "F" # "F", "C", or "K"
  decimals: 0 # 0, 1, or 2
  displayunits: false # When enabled, if the number is too long, units will hide itself.

command: "/usr/local/bin/python3 cj\\ Ubersicht\\ Widgets.widget/Weather.widget/weather.py #{options.API_key} #{options.units} #{options.decimals}"

refreshFrequency: '5m' # Update every 5 minutes

style: """
  bottom: 70px
  left: 10px
  width: 70px
  height: 50px
  font-family: "Helvetica Neue"
  text-align: center
  color: white
  background: rgba(black, 0.2)
  border: 1px solid rgba(white, 0.6)
  font-size: 10px

  .move
    width: 70px
    position: absolute
    top: 50%
    transform: translateY(-50%)

  .temperature
    font-weight: bold
    font-size: 16pt
    line-height: @font-size
    margin-left: 8px

  .condition
    font-size: 10px
    font-weight 400

  [class^="error"]
    font-size: 10px
    display: none
"""

render: ->
  """
  <div class='move'>
    <div class='weather'>
      <div class='temperature'></div>
      <div class='condition'></div>
      <div class='location'></div>
    </div>
    <div class='error1'>Weather not found.<br>Check your connection.</div>
    <div class='error2'>Weather not found.<br>Set your API Key.</div>
  </div>
  """

update: (output, domEl) ->

  # Get our pieces
  values = output.split(" : ")
  temperature = values[0].trim()
  condition = values[1].trim()
  location = values[2]

  # Display an error if something goes wrong
  if temperature == "Error" or temperature == "offline"
    if condition == "Couldn't get inputs. (No API Key Set)"
      $(domEl).find('.error2').css('display', 'block')
    else
      $(domEl).find('.error1').css('display', 'block')
    $(domEl).find('.weather').css('display', 'none')

  # Display the weather if everything worked
  else
    $(domEl).find('.error1').css('display', 'none')
    $(domEl).find('.weather').css('display', 'block')

    # Display temperature and show and hide units as needed
    if options.displayunits != true
        $(domEl).find('.temperature').html("#{(temperature)}°")
    else if options.displayunits == true
      if options.units == "F" and temperature.length < 5
        $(domEl).find('.temperature').html("#{(temperature)}°#{options.units}")
      else if options.units == "C" and temperature.length < 4
        $(domEl).find('.temperature').html("#{(temperature)}°#{options.units}")
      else
        $(domEl).find('.temperature').html("#{(temperature)}°")

    # Resize condition and location if they're too long
    if condition.length >= 15
      $(domEl).find('.condition').css('font-size', '8px')
    else
      $(domEl).find('.condition').css('font-size', '10px')
    if location.length >= 15
      $(domEl).find('.location').css('font-size', '8px')
    else
      $(domEl).find('.location').css('font-size', '10px')

    # Display condition and location
    $(domEl).find('.condition').html(condition)
    $(domEl).find('.location').html(location)
