command: "curl -s 'http://feeds.feedburner.com/brainyquote/QUOTEBR'"

refreshFrequency: "1h"

style:"""
  bottom: 10px
  left: 231px
  font-family: Helvetica Neue
  color: white
  font-size:12px

  .wrapper
    width: 120px
    height: 110px
    border: 1px solid rgba(white, 0.6)
    background: rgba(black, 0.2)

  .move
    position: absolute
    top: 50%
    transform: translateY(-50%)

  .quote
    padding: 5px

  .author
    font-size: 10px
    opacity: 0.6
    float:right
    padding-right: 5px
    margin-top: -5px
"""

render: (output) ->"""
  <div class= "wrapper">
      <div class="move">
        <div class="quote"></div>
        <div class="author"></div>
      </div>
  </div>
"""

update: (output, domEl) ->
  # Define constants, and extract the juicy html.
  dom = $(domEl)
  xml = $(jQuery.parseXML(output))

  # Find the info we need, and inject it into the DOM.
  dom.find('.quote').html xml.find('description').eq(2)
  dom.find('.author').html xml.find('title').eq(2)
