command: "du -ch ~/.Trash | grep total | cut -c 1-5"

refreshFrequency: 60000

render: (output) -> """
  <div>
    <img src="TrashSize.widget/icon.png">
    <a class="size">#{output}</a>
  </div>
"""

style: """
  bottom: 10px
  left: 10px
  color: #fff
  background-color: rgba(#000, 0.5)
  font-family: Helvetica Neue
  border: 1px solid rgba(white, 0.6)
  background: rgba(black, 0.2)
  font-size: 12px
  height: 20px
  width: 73px

  a
    margin-left: 10px
    
  img
    margin-top: 5px
    margin-left: 12px
"""

update: (output, domEl) ->
  if (output.indexOf(" 0B") > -1)
    $(domEl).find('.size').html("Empty")