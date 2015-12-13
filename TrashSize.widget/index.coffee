command: "du -sh ~/.Trash | cut -c 1-5"

refreshFrequency: 60000

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
  width: 70px

  .output
    margin-left: 32px
    margin-top: -14px

  .img
    margin-top: 5px
    margin-left: 12px
"""

render: (output) -> """
  <img class='img' src="TrashSize.widget/icon.png">
  <div class='output'>
"""

update: (output, domEl) ->
  $(domEl).find('.output').html output
