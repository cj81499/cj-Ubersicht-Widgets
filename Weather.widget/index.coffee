# Edit location and forecast.io api key
apiKey   = 'APIKEY'
#location = '1,1' #House
location = '1,1' #Apartment
exclude  = "hourly,alerts,flags"
command: "curl -s 'https://api.forecast.io/forecast/#{apiKey}/#{location}?units=auto&exclude=#{exclude}'"
refreshFrequency: 300000

style: """
  bottom: 70px
  left: 10px
  color: white
  width: 73px
  height: 50px
  font-family: "Helvetica Neue"
  text-align: center
  font-size: 8pt
  background: rgba(black, 0.2)
  border: 1px solid rgba(white, 0.6)
  display: inline-block

  .temp
    font-weight: 700
    font-size: 16pt
    line-height: @font-size
    margin-left: 8px
    overflow: visible
    padding-top: 6px
    padding-bottom: 2px
"""

render: (o) -> """
  <div class='weather'>
    <div class='temp'></div>
    <div class='summary'></div>
  </div>
"""

update: (output, domEl) ->
  data  = JSON.parse(output)
  $domEl = $(domEl)

  $domEl.find('.temp').html """
    <div class='now'>#{Math.round(data.currently.apparentTemperature)}°</div>
  """
  $domEl.find('.summary').text "#{data.currently.summary}"
