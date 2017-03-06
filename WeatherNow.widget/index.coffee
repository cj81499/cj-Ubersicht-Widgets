# Code originally created by Felix Hageloh (https://github.com/felixhageloh)
# Automatic location detection and switch to Yahoo api by @nickroberts (https://github.com/nickroberts)
# Original icons by Erik Flowers (http://erikflowers.github.io/weather-icons/)
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

options =
  widgetEnable  : true              # Easily enable or disable the widget.
  city          : "Pittsford"   # default city in case location detection fails
  region        : "US"              # default region in case location detection fails
  units         : 'F'               # c for celcius. f for Fahrenheit
  staticLocation: false             # set to true to disable automatic location lookup

refreshFrequency: '10m'             # Update every 10 minutes

style: """
  icon-size = 20px
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

  .text
    width: 70px
    position: absolute
    top: 50%
    left: 50%
    transform: translateY(-50%) translateX(-50%)

  .temperature
    font-weight: bold
    font-size: 16pt
    line-height: @font-size
    margin-left: 8px

  .condition
    margin-top: 2px
    font-size: 10px
    font-weight 400
"""

command: "#{process.argv[0]} cj\\ Ubersicht\\ Widgets.widget/WeatherNow.widget/get-weather \
\"#{options.city}\" \
\"#{options.region}\" \
#{options.units} \
#{'static' if options.staticLocation}"

render: -> """
  <div class='text'>
    <div class='temperature'></div>
    <div class='condition'></div>
  </div>
"""

update: (output, domEl) ->
  @$domEl = $(domEl)

  data    = JSON.parse(output)
  channel = data?.query?.results?.channel
  return @renderError(data) unless channel

  if channel.title == "Yahoo! Weather - Error"
    return @renderError(data, channel.item?.title)

  @renderCurrent channel

renderCurrent: (channel) ->
  weather  = channel.item
  location = channel.location

  el = @$domEl.find('.text')
  el.find('.temperature').text "#{Math.round(weather.condition.temp)}°"
  el.find('.condition').text weather.condition.text

renderError: (data, message) ->
  console.error 'weather widget:', data.error if data?.error
  @$domEl.children().hide()

  message ?= """
     Could not retreive weather data for #{data.location}.
      <p>Are you connected to the internet?</p>
  """

  @$domEl.append "<div class=\"error\">#{message}<div>"
