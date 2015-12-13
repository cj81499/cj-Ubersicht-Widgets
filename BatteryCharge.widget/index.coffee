command: "pmset -g batt | grep \"%\" | awk 'BEGINN { FS = \";\" };{ print $3,$2 }' | sed -e 's/-I/I/' -e 's/-0//' -e 's/;//' -e 's/;//'"

refreshFrequency: 60000

style: """
    bottom: 40px
    left: 10px
    fill: white
    border: 1px solid rgba(white, 0.6)
    background: rgba(black, 0.2)
    font-family: Helvetica Neue
    height: 20px
    width: 70px

.charge, .discharge
	margin-top: -154px
	margin-left: 12px
"""

render: -> """
<svg>
	<rect id="chargebar" y=18 x=-1 height="2"/>
	<text id="text" x=32 y=14 style="font-size:12">##%</text>
  	<div id="charge" class='charge'> <img src="BatteryCharge.widget/charge.png"></div>
  	<div id="discharge" class='discharge'> <img src="BatteryCharge.widget/discharge.png"></div>
</svg>
"""

update: (output, domEl) ->
  values = output.split(' ')
  text = $('#text')
  state = values[0]
  charge = parseInt(values[1])
  fill = 'rgba(255,255,255,0.6)'

  $('#chargebar').attr('width',charge * (0.72))
  $('#chargebar').css('fill',fill)
  $('#charge').css('display',if state == 'discharging' then 'none' else 'block')
  $('#discharge').css('display',if state == 'discharging' then 'block' else 'none')

  text.text(charge + '%')
