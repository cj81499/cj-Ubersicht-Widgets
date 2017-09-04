command: '/usr/local/bin/python3 cj\\ Ubersicht\\ Widgets.widget/Weather.widget/weather.py'

refreshFrequency: '5m' # Update every 5 minutes

style: """
  background: rgba(black, 0.2)
  border: 1px solid rgba(white, 0.6)
  bottom: 70px
  color: white
  font-family: Helvetica Neue
  font-size: 10px
  height: 50px
  left: 10px
  text-align: center
  width: 70px

  .move
    position: absolute
    top: 50%
    transform: translateY(-50%)
    width: 100%

  .weather
    display: none
    margin-top: 2px

  .temperature
    font-size: 16pt
    font-weight: bold
    line-height: @font-size - 4px

  .condition
    font-size: 10px
    font-weight 400
    overflow scroll
    white-space: nowrap

  [class^='error']
    display: none
    font-size: 10px
"""

render: ->
  """
  <div class='move'>
    <div class='weather'>
      <div class='temperature'></div>
      <div class='condition'></div>
      <div class='location'></div>
    </div>
    <div class = 'error'>
      <div class='error-internet'>Weather not found.<br>Check your connection.</div>
      <div class='error-api'>Weather not found.<br>Check your API settings.</div>
    </div>
  </div>
  """

update: (output, domEl) ->
  values = output.split(" : ")
  success = (values[0] == 'True')

  if success != false
    temperature = values[1].trim()
    condition = values[2].trim()
    location = values[3].trim()
    units = values[4].trim()
    showunits = (values[5].trim() == 'True')
    margin = 8

    if units != 'K'
      temperature = temperature.concat('°')
    else
      temperature = temperature.concat(' ')
      margin /= 2
    if showunits == true
      temperature = temperature.concat("#{units}")
      margin /= 2

    $(domEl).find('.temperature').html(temperature)
    $(domEl).find('.temperature').css('margin-left', margin)

    $(domEl).find('.condition').html(condition)

    $(domEl).find('.location').html(location)

    $(domEl).find('.weather').show()
    $(domEl).find('.error').hide()
  else
    error = values[1].trim()

    if error == 'Internet'
      $(domEl).find('.error-internet').show()
      $(domEl).find('.error-api').hide()
      $(domEl).find('.error').show()
      $(domEl).find('.weather').hide()
    else if error == 'API'
      $(domEl).find('.error-api').show()
      $(domEl).find('.error-internet').hide()
      $(domEl).find('.error').show()
      $(domEl).find('.weather').hide()
