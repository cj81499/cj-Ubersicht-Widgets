# Attributions:
# The svg path for the bolt icon provided by Open Iconic
# The source code is available at https://github.com/iconic/open-iconic

command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $3,$2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 20000

style: """
    bottom: 40px
    left: 10px
    fill: white
    border: 1px solid rgba(white, 0.6)
    background: rgba(black, 0.2)
    font-family: Helvetica Neue
    height: 20px
    width: 73px

.bolt, .battery
	margin-top: -154px
	margin-left: 12px
"""

render: -> """
<svg>
	<rect id="chargebar" y=18 x=-1 height="2"/>
	<text id="text" x=32 y=14 style="font-size:12">##%</text>
  	<div id="charge" class='bolt'> <img src="BatteryCharge.widget/bolt.png"></div>
  	<div id="discharge" class='battery'> <img src="BatteryCharge.widget/battery.png"></div>
</svg>
"""

update: (output, domEl) ->
  values = output.split(' ')
  text = $('#text')
  state = values[0]
  charge = parseInt(values[1])
  fill = 'rgba(255,255,255,0.6)'

  $('#chargebar').attr('width',charge * 0.75)
  $('#chargebar').css('fill',fill)
  $('#charge').css('display',if state == 'discharging' then 'none' else 'block')
  $('#discharge').css('display',if state == 'charging' then 'none' else 'block')

  text.text(charge + '%')