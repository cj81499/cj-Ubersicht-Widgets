command: "/usr/local/bin/python3 cj\\ Ubersicht\\ Widgets.widget/Quote.widget/quote.py"

refreshFrequency: "1h"

style:"""
  bottom 10px
  left 231px
  font-family Helvetica Neue
  color white
  font-size 12px
  width 120px
  height 110px
  border 1px solid rgba(white, 0.6)
  background rgba(black, 0.2)

  .wrapper
    width 120px
    height 110px

  .move
    position absolute
    top 50%
    transform translateY(-50%)

  .quote
    padding 0px 4px
    text-align left

  .author
    text-align right
    font-size 10px
    opacity 0.6
    float right
    padding-right 5px
    margin-top 2px

  .error
    text-align center
    font-size 10px
"""

render: (output) ->
  """
  <div class= "wrapper">
      <div class="move">
        <div class="error">Quote not found.<br>Check your internet connection.</div>
        <div class="content">
          <div class="quote"></div>
          <div class="author"></div>
        </div>
      </div>
  </div>
  """

update: (output, domEl) ->

  # Get our pieces
  values = output.split(" : ")
  quote = values[0]
  author = values[1]

  if quote.slice(0,-1) == "offline" # Display an error if something goes wrong
    $(domEl).find('.content').css('display', 'none')
    $(domEl).find('.error').css('display', 'block')
  else # Display content otherwise
    $(domEl).find('.content').css('display', 'block')
    $(domEl).find('.error').css('display', 'none')

    $(domEl).find('.quote').html(quote)
    $(domEl).find('.author').html(author)
