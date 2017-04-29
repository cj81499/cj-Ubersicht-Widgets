command: "osascript 'cj Ubersicht Widgets.widget/Battery.widget/battery.applescript'"

refreshFrequency: '10s'

style:"""
  bottom: 40px
  left: 10px
  border: 1px solid rgba(255, 255, 255, 0.6)
  background: rgba(0, 0, 0, 0.2)
  color: white
  font-family: Helvetica Neue
  font-size: 12px
  height: 20px
  width: 70px

  .percent
    position: absolute
    margin-left: 32px
    margin-top: 3px

  .icon
    position: absolute
    margin-top: 5px
    margin-left: 13px

  .bolt
    position: absolute
    margin-top: 5px
    margin-left: 3px

  .bar
    posotion: absolute
    background: rgba(255, 255, 255, 0.6)
    width: 3px
    margin-left: 14px
"""

render: (output) ->
  """
  <div class='percent'>??%</div>

  <img id='icon' class='icon' src='cj Ubersicht Widgets.widget/Battery.widget/images/battery.png'>

  <img id='bolt' class='bolt' src='cj Ubersicht Widgets.widget/Battery.widget/images/bolt.png'>

  <div id='bar' class='bar'></div>
  """

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  # Get our pieces.
  values = output.split(' @ ')
  percent = Number(values[0].replace /^\s+|\s+$/g, "")
  status = values[1].replace /^\s+|\s+$/g, ""
  type = values[2].replace /^\s+|\s+$/g, ""

  # Put percent value
  div.find('.percent').html(percent + '%')

  # Hide bolt when not plugged in or when fully charged
  $('#bolt').css('display',if type == 'AC' and status != "charged" then 'block' else 'none')

  # Set bar height and position
  if 100 >= percent > 95
    $(domEl).find('.bar').css('height', '7px')
    $(domEl).find('.bar').css('margin-top', '6px')
  else if 95 >= percent > 80
    $(domEl).find('.bar').css('height', '5px')
    $(domEl).find('.bar').css('margin-top', '8px')
  else if 80 >= percent > 60
    $(domEl).find('.bar').css('height', '4px')
    $(domEl).find('.bar').css('margin-top', '9px')
  else if 60 >= percent > 40
    $(domEl).find('.bar').css('height', '3px')
    $(domEl).find('.bar').css('margin-top', '10px')
  else if 40 >= percent > 20
    $(domEl).find('.bar').css('height', '2px')
    $(domEl).find('.bar').css('margin-top', '11px')
  else if 20 >= percent > 10
    $(domEl).find('.bar').css('height', '1px')
    $(domEl).find('.bar').css('margin-top', '12px')
  else if 10 >= percent > 0
    $(domEl).find('.bar').css('height', '1px')
    $(domEl).find('.bar').css('margin-top', '12px')
  # Set bar color
  if 100 >= percent > 10
    $(domEl).find('.bar').css('background', 'rgba(255, 255, 255, 0.6)')
  else if 10 >= percent >= 0
    $(domEl).find('.bar').css('background', 'rgba(255, 0, 0, 0.6)')
